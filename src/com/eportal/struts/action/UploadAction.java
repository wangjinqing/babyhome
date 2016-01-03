package com.eportal.struts.action;
import java.io.*;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import com.opensymphony.xwork2.ActionSupport;
/** �ϴ��ļ���������� */
@SuppressWarnings("serial")
public class UploadAction extends ActionSupport{
	//�ϴ��ļ����� image��ʾͼƬ(gif,jpg,png,bmp)�ļ�,flash��ʾswf�ļ�
	String type = "image";
	/** �ϴ��ļ������� */
	private File upload;	//�ϴ����ļ�
	private String uploadContentType;	//�ϴ��ļ�������
	private String uploadFileName;		//�ϴ��ļ����ļ���	
	/** ����CKeditor�༭���е��ϴ��ļ����� */
	public String execute(){
		PrintWriter out = null;
		//����һ��StringBuffer�����ŷ��ظ�CKeditor����ʾ��Ϣ
		StringBuffer sb = new StringBuffer();
		String errMsg = "�Բ����ļ��ϴ�ʧ�ܣ�";
		try {
			//ȡ����ײ��HttpServletResponse����
			HttpServletResponse response = ServletActionContext.getResponse();
			out = response.getWriter();
			response.setCharacterEncoding("UTF-8");
			sb.append("<script type=\"text/javascript\">\n");
			//ȡ��UserFiles�ļ��ж�Ӧ������·��
			String basePath=ServletActionContext.getServletContext().getRealPath("/upload").replaceAll("\\\\", "/");
			File saveDir = new File(basePath);
			if(!saveDir.exists())saveDir.mkdirs();
			//�����ϴ��ļ�
			if (uploadFileName==null||uploadFileName.trim().length()<1){
				//δѡ���ϴ��ļ�ʱ�Ĵ�����ʾ��Ϣ
				errMsg = "�Բ����ļ�����Ϊ��,��ѡ���ļ�Ȼ���ϴ���";
				errMsg =  new String(errMsg.getBytes(),"iso8859-1");
				sb.append("window.parent.CKEDITOR.tools.callFunction(1,'','"+errMsg+"');\n");				
			}else{
				String[] tmpNames = uploadFileName.split("\\.");
				String tempFilename = String.valueOf(System.currentTimeMillis());
				String extName = null;
				if (tmpNames!=null && tmpNames.length>1){
					extName = tmpNames[tmpNames.length-1].toLowerCase();
					tempFilename = tempFilename+"."+extName;
					if (type.equals("image")){
						if ("gif,jpg,png,bmp".indexOf(extName)==-1){
							//ͼƬ��ʽ����ȷʱ�Ĵ�����ʾ��Ϣ
							errMsg = "�Բ���ͼƬ��ʽ����ȷ,������ѡ����ȷ��ͼƬ�ļ���";
							errMsg =  new String(errMsg.getBytes(),"iso8859-1");
							sb.append("window.parent.CKEDITOR.tools.callFunction(1,'','"+errMsg+"');\n");							
						}else{
							FileUtils.copyFile(upload, new File(saveDir, tempFilename));
							//�ϴ��ɹ��󷵻��ļ������õ�ַ
							sb.append("window.parent.CKEDITOR.tools.callFunction(1,'"+ServletActionContext.getServletContext().getContextPath()+"/upload/"+tempFilename+"');\n");							
						}
					}else if(type.equals("flash")){
						if (!"swf".equals(extName)){
							//Flash�ļ�����ȷʱ�Ĵ�����ʾ��Ϣ
							errMsg = "�Բ���Flash�ļ�����ȷ,������ѡ����ȷ��Flash�ļ���";
							errMsg =  new String(errMsg.getBytes(),"iso8859-1");
							sb.append("window.parent.CKEDITOR.tools.callFunction(1,'','"+errMsg+"');\n");							
						}else{
							FileUtils.copyFile(upload, new File(saveDir, tempFilename));
							//�ϴ��ɹ��󷵻��ļ������õ�ַ
							sb.append("window.parent.CKEDITOR.tools.callFunction(1,'"+ServletActionContext.getServletContext().getContextPath()+"/upload/"+tempFilename+"');\n");							
						}
					}else{
						//�ļ���ʽ����ȷʱ�Ĵ�����ʾ��Ϣ
						errMsg = "�Բ����ļ���ʽ����ȷ,������ѡ����ȷ���ļ���";
						errMsg =  new String(errMsg.getBytes(),"iso8859-1");
						sb.append("window.parent.CKEDITOR.tools.callFunction(1,'','"+errMsg+"');\n");						
					}
				}else{
					//�ļ���ʽ����ȷʱ�Ĵ�����ʾ��Ϣ
					errMsg = "�Բ����ļ���ʽ����ȷ,������ѡ����ȷ���ļ���";
					errMsg =  new String(errMsg.getBytes(),"iso8859-1");
					sb.append("window.parent.CKEDITOR.tools.callFunction(1,'','"+errMsg+"');\n");					
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
			//�ļ��ϴ�ʧ��ʱ�Ĵ�����ʾ��Ϣ
			try {
				errMsg =  new String(errMsg.getBytes(),"iso8859-1");
			} catch (UnsupportedEncodingException e1) {
				e1.printStackTrace();
			}
			sb.append("window.parent.CKEDITOR.tools.callFunction(1,'','"+errMsg+"');\n");
		}		
		sb.append("</script>\n");
		out.println(sb.toString());
		out.flush();
		out.close();		
		return null;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public File getUpload() {
		return upload;
	}

	public void setUpload(File upload) {
		this.upload = upload;
	}

	public String getUploadContentType() {
		return uploadContentType;
	}

	public void setUploadContentType(String uploadContentType) {
		this.uploadContentType = uploadContentType;
	}

	public String getUploadFileName() {
		return uploadFileName;
	}

	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}

}
