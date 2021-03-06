package com.eportal.tld;

import java.io.*;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import org.springframework.web.context.support.WebApplicationContextUtils;
import com.eportal.DAO.*;
import com.eportal.util.*;

/** 文本新闻列表分页控制自定义标签类 */
public class TextnewsPageTag extends SimpleTagSupport{
	BaseDAO dao = null; 	//数据库DAO接口
	String hql= null;
	String newstype="4";	//新闻类型:0-最新新闻 1-头条新闻 2-热点新闻 3-精彩推荐 4-所有类型
	String section;	 		//新闻栏目编号,多个栏目编号中间用号码分隔,如:I_001,I_002
	String url = "";		//分页调用的URL,此项为必填项
	int pageNo = 1;			//页号
	int pageSize=24;      	//每页新闻条数,,默认值24
	int pageTotal=1;      	//总页数
	int prePageNo = 1;		//上一页页号	
	int nextPageNo = 1;		//下一页页号

	/** 标签体处理 */
    public void doTag() throws JspException, IOException{
    	//使用WebApplicationContextUtils工具类获取Spring IOC容器中的dao实例
    	dao = (BaseDAOImpl)WebApplicationContextUtils.getRequiredWebApplicationContext(((PageContext)getJspContext()).getServletContext()).getBean("dao");    	
    	//构造统计新闻记录数的HQL语句
    	if (newstype.equals("4")){//所有类型
			hql="select count(*) from News as a where a.status=1 and a.newscolumns.columnCode in("+Tools.formatString(section)+")";			
		}else{//指定类型
			hql="select count(*) from News as a where a.status=1 and a.newscolumns.columnCode in("+Tools.formatString(section)+") and a.newsType="+newstype;			
		}		
		StringBuffer sb=new StringBuffer();
		//统计满足条件的新闻条数
		int total=dao.countQuery(hql);
		//计算总页数
		if (total>0){
			pageTotal = total / pageSize;
			if ((total%pageSize)>0)pageTotal++;
		}
		//计算上一页
		if (pageNo>1){
			prePageNo = pageNo-1;
		}else{
			prePageNo = 1;
		}
		//计算下一页
		if (pageNo<pageTotal){
			nextPageNo = pageNo+1;
		}else{
			nextPageNo = pageTotal;
		}
		//构造出url
		if (url.indexOf("?")!=-1){
			url = url+"&";
		}else{
			url = url+"?";
		}
		sb.append("<div>当前第["+pageNo+"/"+pageTotal+"]页 [<a target='_self' href='"+url+"pageNo=1'>首页</a>] ");
		//第一页时,"上一页"链接无效
		if (pageNo==1){
			sb.append("[上一页] ");
		}else{
			sb.append("[<a target='_self' href='"+url+"pageNo="+prePageNo+"'>上一页</a>] ");
		}
		//最末页时,"下一页"链接无效
		if (pageNo==pageTotal){
			sb.append("[下一页] ");
		}else{
			sb.append("[<a target='_self' href='"+url+"pageNo="+nextPageNo+"'>下一页</a>] ");
		}
		sb.append("[<a target='_self' href='"+url+"pageNo="+pageTotal+"'>尾页</a>]</div>");
    	//输出处理结果到页面上
    	getJspContext().getOut().println(sb); 
	}
	
	public String getNewstype() {
		return newstype;
	}

	public void setNewstype(String newstype) {
		this.newstype = newstype;
	}

	public String getSection() {
		return section;
	}

	public void setSection(String section) {
		this.section = section;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getPageTotal() {
		return pageTotal;
	}

	public void setPageTotal(int pageTotal) {
		this.pageTotal = pageTotal;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

}
