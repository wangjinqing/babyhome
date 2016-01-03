package com.eportal.struts.action;

import java.util.*;
import java.net.*;
import org.apache.struts2.ServletActionContext;

import com.eportal.bean.PageList;
import com.eportal.service.*;
import com.opensymphony.xwork2.ActionSupport;

/** 流量统计控制器 */
@SuppressWarnings("serial")
public class TrafficAction extends ActionSupport{
	/** 通过依赖注入TrafficService组件实例 */
	TrafficService service;

	private List result;//查询结果列表
	private String where =null;//查询HQL条件
	
	/**访问记录分页的参数*/
	private int pageCount = 0; //总页数
	private int pageNo = 1; //当前页号
	private int count = 0; //总记录数
	private int pageSize = 50; //每页记录数	
	
	/** 处理IP统计请求 */
	public String browseIP(){
		String queryHQL = "select a.ip,max(a.area),max(a.visitDate),count(a.ip) from Traffic as a ";
		String countHQL = "select count(distinct a.ip) from Traffic as a ";
		where = ServletActionContext.getRequest().getParameter("where");
		if(where!=null){
			try {
				where=URLDecoder.decode(where,"UTF-8");
			} catch (Exception e) {}
			queryHQL = queryHQL+where;
			countHQL = countHQL+where;
		}
		queryHQL=queryHQL+" group by a.ip order by a.id desc";
		//进行分页处理		
		count = service.countIP(countHQL);
		if (ServletActionContext.getRequest().getParameter("page")!=null){
			//接受DisplayTag组件传递的页号参数page
			pageNo = Integer.parseInt(ServletActionContext.getRequest().getParameter("page"));
		}		
		List tempresult = service.browseTraffic(queryHQL,pageNo,pageSize);
		//对查询结果进行重新封装
		Iterator it = tempresult.iterator();
		Object[] obj = null;
		Map row = null;
		result = new ArrayList();
		while(it.hasNext()){
			obj = (Object[])it.next();
			row = new HashMap();
			row.put("ip", obj[0]);
			row.put("area", obj[1]);			
			row.put("visitDate", obj[2]);
			row.put("times", obj[3]);
			result.add(row);
		}
		//封装分页数据
		PageList pageList = new PageList();
		pageList.setPageNumber(pageNo);//设置当前页数
		pageList.setFullListSize(count);//设置总记录数
		pageList.setList(result);//设置当前页列表
		pageList.setObjectsPerPage(pageSize);//设置每页记录数
		//在request对象中保存分页数据
		ServletActionContext.getRequest().setAttribute("pageList", pageList);			
		return SUCCESS;
	}
	
	/** 处理PV统计请求 */
	public String browsePV(){
		String queryHQL = "from Traffic as a ";
		String countHQL = "select count(*) from Traffic as a ";
		where = ServletActionContext.getRequest().getParameter("where");
		if(where!=null){
			try {
				where=URLDecoder.decode(where,"UTF-8");
			} catch (Exception e) {}
			queryHQL = queryHQL+where;
			countHQL = countHQL+where;			
		}
		queryHQL=queryHQL+" order by a.id desc";
		//进行分页处理		
		count = service.countPV(countHQL);
		if (ServletActionContext.getRequest().getParameter("page")!=null){
			//接受DisplayTag组件传递的页号参数page
			pageNo = Integer.parseInt(ServletActionContext.getRequest().getParameter("page"));
		}
		result = service.browseTraffic(queryHQL,pageNo,pageSize);
		//封装分页数据
		PageList pageList = new PageList();
		pageList.setPageNumber(pageNo);//设置当前页数
		pageList.setFullListSize(count);//设置总记录数
		pageList.setList(result);//设置当前页列表
		pageList.setObjectsPerPage(pageSize);//设置每页记录数
		//在request对象中保存分页数据
		ServletActionContext.getRequest().setAttribute("pageList", pageList);			
		return SUCCESS;
	}	

	public TrafficService getService() {
		return service;
	}

	public void setService(TrafficService service) {
		this.service = service;
	}

	public List getResult() {
		return result;
	}

	public void setResult(List result) {
		this.result = result;
	}

	public String getWhere() {
		return where;
	}

	public void setWhere(String where) {
		this.where = where;
	}
}