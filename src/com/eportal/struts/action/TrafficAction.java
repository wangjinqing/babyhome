package com.eportal.struts.action;

import java.util.*;
import java.net.*;
import org.apache.struts2.ServletActionContext;

import com.eportal.bean.PageList;
import com.eportal.service.*;
import com.opensymphony.xwork2.ActionSupport;

/** ����ͳ�ƿ����� */
@SuppressWarnings("serial")
public class TrafficAction extends ActionSupport{
	/** ͨ������ע��TrafficService���ʵ�� */
	TrafficService service;

	private List result;//��ѯ����б�
	private String where =null;//��ѯHQL����
	
	/**���ʼ�¼��ҳ�Ĳ���*/
	private int pageCount = 0; //��ҳ��
	private int pageNo = 1; //��ǰҳ��
	private int count = 0; //�ܼ�¼��
	private int pageSize = 50; //ÿҳ��¼��	
	
	/** ����IPͳ������ */
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
		//���з�ҳ����		
		count = service.countIP(countHQL);
		if (ServletActionContext.getRequest().getParameter("page")!=null){
			//����DisplayTag������ݵ�ҳ�Ų���page
			pageNo = Integer.parseInt(ServletActionContext.getRequest().getParameter("page"));
		}		
		List tempresult = service.browseTraffic(queryHQL,pageNo,pageSize);
		//�Բ�ѯ����������·�װ
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
		//��װ��ҳ����
		PageList pageList = new PageList();
		pageList.setPageNumber(pageNo);//���õ�ǰҳ��
		pageList.setFullListSize(count);//�����ܼ�¼��
		pageList.setList(result);//���õ�ǰҳ�б�
		pageList.setObjectsPerPage(pageSize);//����ÿҳ��¼��
		//��request�����б����ҳ����
		ServletActionContext.getRequest().setAttribute("pageList", pageList);			
		return SUCCESS;
	}
	
	/** ����PVͳ������ */
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
		//���з�ҳ����		
		count = service.countPV(countHQL);
		if (ServletActionContext.getRequest().getParameter("page")!=null){
			//����DisplayTag������ݵ�ҳ�Ų���page
			pageNo = Integer.parseInt(ServletActionContext.getRequest().getParameter("page"));
		}
		result = service.browseTraffic(queryHQL,pageNo,pageSize);
		//��װ��ҳ����
		PageList pageList = new PageList();
		pageList.setPageNumber(pageNo);//���õ�ǰҳ��
		pageList.setFullListSize(count);//�����ܼ�¼��
		pageList.setList(result);//���õ�ǰҳ�б�
		pageList.setObjectsPerPage(pageSize);//����ÿҳ��¼��
		//��request�����б����ҳ����
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