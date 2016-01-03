package com.eportal.struts.action;
import java.io.*;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import com.opensymphony.xwork2.ActionSupport;
/** 上传文件处理控制器 */
@SuppressWarnings("serial")
public class UploadAction extends ActionSupport{
	//上传文件类型 image表示图片(gif,jpg,png,bmp)文件,flash表示swf文件
	String type = "image";
	/** 上传文件的属性 */
	private File upload;	//上传的文件
	private String uploadContentType;	//上传文件的类型
	private String uploadFileName;		//上传文件的文件名	
	/** 处理CKeditor编辑器中的上传文件请求 */
	public String execute(){
		PrintWriter out = null;
		//创建一个StringBuffer对象存放返回给CKeditor的提示信息
		StringBuffer sb = new StringBuffer();
		String errMsg = "对不起，文件上传失败！";
		try {
			//取得最底层的HttpServletResponse对象
			HttpServletResponse response = ServletActionContext.getResponse();
			out = response.getWriter();
			response.setCharacterEncoding("UTF-8");
			sb.append("<script type=\"text/javascript\">\n");
			//取得UserFiles文件夹对应的物理路径
			String basePath=ServletActionContext.getServletContext().getRealPath("/upload").replaceAll("\\\\", "/");
			File saveDir = new File(basePath);
			if(!saveDir.exists())saveDir.mkdirs();
			//处理上传文件
			if (uploadFileName==null||uploadFileName.trim().length()<1){
				//未选择上传文件时的错误提示信息
				errMsg = "对不起，文件不能为空,请选择文件然后上传！";
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
							//图片格式不正确时的错误提示信息
							errMsg = "对不起，图片格式不正确,请重新选择正确的图片文件！";
							errMsg =  new String(errMsg.getBytes(),"iso8859-1");
							sb.append("window.parent.CKEDITOR.tools.callFunction(1,'','"+errMsg+"');\n");							
						}else{
							FileUtils.copyFile(upload, new File(saveDir, tempFilename));
							//上传成功后返回文件的引用地址
							sb.append("window.parent.CKEDITOR.tools.callFunction(1,'"+ServletActionContext.getServletContext().getContextPath()+"/upload/"+tempFilename+"');\n");							
						}
					}else if(type.equals("flash")){
						if (!"swf".equals(extName)){
							//Flash文件不正确时的错误提示信息
							errMsg = "对不起，Flash文件不正确,请重新选择正确的Flash文件！";
							errMsg =  new String(errMsg.getBytes(),"iso8859-1");
							sb.append("window.parent.CKEDITOR.tools.callFunction(1,'','"+errMsg+"');\n");							
						}else{
							FileUtils.copyFile(upload, new File(saveDir, tempFilename));
							//上传成功后返回文件的引用地址
							sb.append("window.parent.CKEDITOR.tools.callFunction(1,'"+ServletActionContext.getServletContext().getContextPath()+"/upload/"+tempFilename+"');\n");							
						}
					}else{
						//文件格式不正确时的错误提示信息
						errMsg = "对不起，文件格式不正确,请重新选择正确的文件！";
						errMsg =  new String(errMsg.getBytes(),"iso8859-1");
						sb.append("window.parent.CKEDITOR.tools.callFunction(1,'','"+errMsg+"');\n");						
					}
				}else{
					//文件格式不正确时的错误提示信息
					errMsg = "对不起，文件格式不正确,请重新选择正确的文件！";
					errMsg =  new String(errMsg.getBytes(),"iso8859-1");
					sb.append("window.parent.CKEDITOR.tools.callFunction(1,'','"+errMsg+"');\n");					
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
			//文件上传失败时的错误提示信息
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
