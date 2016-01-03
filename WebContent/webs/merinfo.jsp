<%@ page contentType="text/html; charset=gbk"%>
<%@page import="com.eportal.ORM.Merchandise"%>
<%@page import="com.eportal.util.Tools"%>
<%@page import="com.eportal.service.*"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="java.util.*"%>
<%@include file="../common/web_head.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"  xml:lang="zh-CN" lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>${merName}-<s:text name="website_name"/></title>
<base target="_blank" />
<meta name="Keywords" content='${merName}' />
<meta name="Description" content='${merName},${merModel}' />
<meta name="robots" content="index, follow" />
<meta name="googlebot" content="index, follow" />
<link href="<%=basepath%>/css/style.css" rel="stylesheet" type="text/css" />
</head>

<body>
<!--DIV页面主容器-->
<div class="container">
<%@include file="../common/menubar.jsp"%>
<!-- 栏间留空 -->	
	<div class="split"></div>
<!--位置导航区-->	
	<div class="nav">
		<div class="nav_left"></div>
		<div class="nav_main">
			您现在的位置：<a href="<%=basepath%>/webs/index.jsp">首页</a> >> 商品详情
		</div>
		<div class="nav_now">
			<%@include file="../common/jsdate.jsp"%>	
		</div>
		<div class="nav_right"></div>
	</div>
<!-- 栏间留空 -->	
	<div class="split"></div>
<!-- 页面主体左侧 -->	
	<div class="main_left">
<!-- 商品分类区 -->	
		<div class="cate">
			<div class="cate_head_left"></div>
			<div class="cate_head_text"><h2>商品分类</h2></div>
			<div class="cate_head_main"></div>
			<div class="cate_head_right"></div>
			<div class="cate_body">
				<!-- 使用自定义商品类别列表标签 -->
				<e:category/> 				
			</div>
		</div>
<!-- 栏间留空 -->	
		<div class="split"></div>		
<!-- 促销打折区 -->	
		<div class="prom">
			<div class="prom_head_left"></div>
			<div class="prom_head_text"><h2>促销打折</h2></div>
			<div class="prom_head_main"></div>
			<div class="prom_head_right"></div>
			<div class="prom_body">
				<!-- 使用自定义商品列表标签 -->
				<e:merlist baseurl="<%=basepath%>" size="4" listtype="2"/> 			
			</div>
		</div>			
	</div>
<!-- 页面主体右侧 -->	
	<div class="main_right">
		<div class="merinfo">
			<div class="baseinfo">
				<s:if test="picture!=null">
					<%
						//对商品图片的宽度与高度进行范围控制,以免撑破整个页面
						String filename=request.getRealPath(((Merchandise)request.getAttribute("model")).getPicture()).replaceAll("\\\\","/");
						Map map = Tools.getPicWidthHeight(filename); 
						String height_width ="height='240'";
						if (map!=null){
							int width = Integer.valueOf(map.get("width").toString());
							int height = Integer.valueOf(map.get("height").toString());
							if (width>=height){//横向图片,控制宽度即可
								height_width ="width='240'";
							}else{//竖向图片,控制高度即可
								height_width ="height='240'";
							}
						}						
					%>
					<img src="<%=basepath%>/<s:property value="picture"/>" <%=height_width%> style="float:left;margin:10px;"/>									
				</s:if>
				<s:else>
					<img src="<%=basepath%>/images/noimages.gif"/>" height="240" style="float:left;margin:10px;"/>
				</s:else>							
				<span class="merfield">商品名称:</span> ${merName}<br/>
				<span class="merfield">商品型号:</span> ${merModel}<br/>
				<span class="merfield">市场价格:</span> <s:property value="@com.eportal.util.Tools@formatCcurrency(#request.price)"/>元<br/>
				<span class="merfield">会员价格:</span> 
				<s:if test="special==1">
					<s:property value="@com.eportal.util.Tools@formatCcurrency(#request.sprice)"/>元<br/>
				</s:if>	
				<s:else>
					<%
		        		//计算会员价,会员价为最低优惠会员价
		        		double tmpprice = 0;
		        		Merchandise mer = (Merchandise)request.getAttribute("model");
		        		MemberLevelService memberLevelService = (MemberLevelService)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("memberLevelService");
						tmpprice = mer.getPrice()*(100-memberLevelService.getInitMemberlevel().getFavourable().intValue())/100;
					%>
					<%=Tools.formatCcurrency(tmpprice)%>元<br/>
				</s:else>	
				<span class="merfield">促销打折:</span> <s:property value="%{#special==1?'有':'无'}" escape="false"/><br/>
				<span class="merfield">生产厂家:</span> ${manufacturer}<br/>
				<span class="merfield">出厂日期:</span> <s:property value="@com.eportal.util.Tools@formatDate(#request.leaveFactoryDate)"/><br/>	
				<span class="merfield">商品视频:</span> 
				<s:if test="video!=null">
					<img src="<%=basepath%>/images/play.gif" style="vertical-align:middle;cursor:pointer;" onclick="playflv()"/><br/>
				</s:if>
				<s:else>无<br/></s:else>
				<div class="merfield1">我要购买: <img src="<%=basepath%>/images/icon_buy.gif" style="vertical-align:middle;cursor:pointer" onclick='buy(${id})'/></div>											
		    </div>
			<div class="otherinfo">
				<span class="merfield">商品描述:</span><br/>
				<s:property escape="false" value="@com.eportal.util.Tools@unescape(#request.merDesc)"/>		
			</div>		
		</div>
	</div>		
<!-- 栏间留空 -->	
	<div class="split"></div>	
<%@include file="../common/foot.jsp"%>
</div>
<!-- 放置带遮罩的FLV在线播放器 -->
<span id="flvspan" style="display:none">
	<e:msgdialog basepath="<%=basepath%>" title="在线视频播放" height="1020" top="140" boxwidth="460" tmpid="flv">
		<!-- FLV在线播放器 -->
		<e:flvplayer flvFilename="${video}" picFilename="${picture}"/>
	</e:msgdialog>
</span>
<script language='javascript'>
	//选购商品
	function buy(merid){
		if (!loginStatus)
			alert('对不起,您尚未登录,请先登录后再选购商品,谢谢合作!');
		else
			window.location='<%=basepath%>/webs/addToCart.action?merId='+merid;
	} 
	//播放flv视频
	function playflv(){
		document.getElementById('flvspan').style.display='inline';
		document.getElementById('maskflv').style.display='inline';
		document.getElementById('msgpromptflv').style.display='inline';
	}	
	//关闭带遮罩的网页对话框
	closemaskflv();
</script>
</body>
</html>
