<%@ page contentType="text/html; charset=gbk"%>
<%@ page import="com.eportal.DAO.*" %>
<%@ page import="com.eportal.ORM.Traffic" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%
	//使用WebApplicationContextUtils工具类获取Spring IOC容器中的dao实例
	BaseDAO dao = (BaseDAOImpl)WebApplicationContextUtils.getRequiredWebApplicationContext(pageContext.getServletContext()).getBean("dao");
	String ip="";//IP地址
	double ipvalue = 0;
	String fromUrl="";//来路URL
	String toUrl="";//受访URL
	String address="";//IP归属地	
	if(request.getRemoteAddr()!=null){
		ip=request.getRemoteAddr();//取得IP地址
		//计算IP地址所对应的数值
		String[] tmp = ip.split("\\.");
		ipvalue = Double.parseDouble(tmp[0])*256*256*256+Double.parseDouble(tmp[1])*256*256+Double.parseDouble(tmp[2])*256+Double.parseDouble(tmp[3]);
	}
	if(request.getParameter("fromUrl")!=null && request.getParameter("fromUrl").length()>0){
		fromUrl=request.getParameter("fromUrl");//取得来路URL
	}else{
		fromUrl="直接进入";
	}
	if(request.getParameter("toUrl")!=null && request.getParameter("toUrl").length()>0){
		toUrl=request.getParameter("toUrl");//取得受访URL
	}
	if(ip.startsWith("192")||ip.startsWith("127")){
		address="本地";
	}else{
		//通过JDBC调用MySQL存储过程pro_iptoaddress取得IP归属地
		Connection conn = dao.getConnection();
		CallableStatement stmt = conn.prepareCall("{call pro_iptoaddress(?,?)}");
		stmt.setDouble(1,ipvalue);
		stmt.registerOutParameter(2, Types.VARCHAR);
	    stmt.execute();
	    address= stmt.getString(2);
	    if(address==null||address.length()<1)address="未知地区";	
	}
	//保存访问记录
	Traffic traffic = new Traffic();
	traffic.setIp(ip);
	traffic.setSourceUrl(fromUrl);
	traffic.setTargetUrl(toUrl);
	traffic.setArea(address);
	traffic.setVisitDate(new java.util.Date());
	dao.saveOrUpdate(traffic);	
%>