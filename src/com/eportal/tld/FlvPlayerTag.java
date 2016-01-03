package com.eportal.tld;

import java.io.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

/** FLV���߲������Զ����ǩ�� */
public class FlvPlayerTag extends SimpleTagSupport {

	String width = "400"; //���������,��λ:����,Ĭ��400
	String height = "300";//�������߶�,��λ:����,Ĭ��300
	String flvFilename;	  //FLV�ļ���
	String picFilename="/images/cover.jpg";	  //����������ͼƬ�ļ�,Ĭ��Ϊimages�µ�cover.jpg	
	
	/** ��ǩ�崦�� */
    public void doTag() throws JspException, IOException{
    	String basePath = ((HttpServletRequest)((PageContext)getJspContext()).getRequest()).getContextPath();
    	
    	//����FLV���߲�����
    	StringBuffer sb = new StringBuffer();
    	sb.append("<center><div id='flvcontainer'>��<a href='http://www.macromedia.com/go/getflashplayer'>����Flash������</a>���Ŵ�ӰƬ!</div></center>\n");
    	sb.append("<script type='text/javascript' src='"+basePath+"/js/swfobject.js'></script>\n");
    	sb.append("<script type='text/javascript'>\n");
    	sb.append("	var so = new SWFObject('"+basePath+"/js/mediaplayer.swf','mpl','"+width+"','"+height+"','7');\n");
    	sb.append("	so.addParam('allowfullscreen','true');\n");
    	sb.append("	so.addParam('allowscriptaccess','sameDomain');\n");
    	sb.append("	so.addVariable('width','"+width+"');\n");
    	sb.append("	so.addVariable('height','"+height+"');\n");
    	sb.append("	so.addVariable('file','"+basePath+flvFilename+"');\n");
    	sb.append("	so.addVariable('image','"+basePath+picFilename+"');\n");
    	sb.append("	so.write('flvcontainer');	\n");
    	sb.append("</script>\n");
    	//�����������ҳ����
    	getJspContext().getOut().println(sb);    	
    }

	public String getWidth() {
		return width;
	}

	public void setWidth(String width) {
		this.width = width;
	}

	public String getHeight() {
		return height;
	}

	public void setHeight(String height) {
		this.height = height;
	}

	public String getFlvFilename() {
		return flvFilename;
	}

	public void setFlvFilename(String flvFilename) {
		this.flvFilename = flvFilename;
	}

	public String getPicFilename() {
		return picFilename;
	}

	public void setPicFilename(String picFilename) {
		this.picFilename = picFilename;
	}
}
