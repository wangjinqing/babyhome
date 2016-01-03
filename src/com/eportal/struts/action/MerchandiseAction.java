package com.eportal.struts.action;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Pattern;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts2.ServletActionContext;
import com.eportal.ORM.*;
import com.eportal.bean.PageList;
import com.eportal.service.*;
import com.eportal.util.*;
import com.opensymphony.xwork2.*;

/** ��Ʒ��������� */
@SuppressWarnings("serial")
public class MerchandiseAction extends ActionSupport implements ModelDriven<Merchandise>{
	/** ͨ������ע��MerchandiseServiceImpl��CategoryServiceImpl���ʵ�� */
	MerchandiseService service;
	CategoryService cateService;
	
	/** ��Ʒ�������������г��õĲ���ֵ */
	private String actionMsg;	//Action�䴫�ݵ���Ϣ����
	private List<Merchandise> merList;//��Ʒ�б�
	private String categoryId;	//��������ID
	private List<DoubleSelectNode> doubleSelectNodes;//������Ʒ�����б�
	private String category1;	//��ǰѡ�еĵ�һ����Ʒ����
	private String category2;	//��ǰѡ�еĵڶ�����Ʒ����
	
	/** ��Ʒ�б��ҳ�Ĳ���  */
	private int pageCount = 0; //��ҳ��
	private int pageNo = 1; //��ǰҳ��
	private int count = 0; //�ܼ�¼��
	private int pageSize = 15; //ÿҳ��¼��		
	
	/** �ϴ�ͼƬ�ļ������� */
	private File pic;	//�ϴ���ͼƬ�ļ�
	private File vd;	//�ϴ�����Ƶ�ļ�	
	private String picContentType;	//�ϴ�ͼƬ�ļ�������
	private String picFileName;		//�ϴ�ͼƬ�ļ����ļ���
	private String vdContentType;	//�ϴ���Ƶ�ļ�������
	private String vdFileName;		//�ϴ���Ƶ�ļ����ļ���
	
	/** JasperReport��������������Զ��� */
	List<Merchandise> ds_merList; //����ds_merList����װ��������Ʒ����
	String reportMan; //����reportMan������ű����˲���ֵ
	String reportDate; //����reportDate������ű������ڲ���ֵ
	String reportFormat = "HTML"; //����reportFormat������ű����ʽ����ֵ(�磺PDF��HTML��XML��CSV��XLS)
	
	//����ģ������
	private Merchandise model=new Merchandise();//���ڷ�װ��Ʒ����ģ��
	public Merchandise getModel() {
		return model;
	}
	
	/** ���������Ʒ���� */
	@SuppressWarnings("unchecked")
	public String browseMerchandise(){
		if(actionMsg!=null&&ServletActionContext.getRequest().getParameter("page")==null){
			actionMsg = java.net.URLDecoder.decode(actionMsg);
			addActionMessage(actionMsg);
		}
		//���з�ҳ����		
		count = service.countMerchandise();
		if (ServletActionContext.getRequest().getParameter("page")!=null){
			pageNo = Integer.parseInt(ServletActionContext.getRequest().getParameter("page"));
		}		
		merList = service.browseMerchandise(pageNo,pageSize);//����ҵ���߼����ȡ��ָ��ҳ����Ʒ�б�
		//��װ��ҳ����
		PageList pageList = new PageList();
		pageList.setPageNumber(pageNo);//���õ�ǰҳ��
		pageList.setFullListSize(count);//�����ܼ�¼��
		pageList.setList(merList);//���õ�ǰҳ�б�
		pageList.setObjectsPerPage(pageSize);//����ÿҳ��¼��
		//��request�����б����ҳ����
		ServletActionContext.getRequest().setAttribute("pageList", pageList);			
		
		return SUCCESS;
	}
	
	/** ����������Ʒ���� */
	public String addMerchandise(){
		try {
			model.setHtmlPath("/html/mer/"+Tools.getRndFilename()+".html");
			//����Ʒ���ݽ���Escape����
			model.setMerDesc(Tools.escape(model.getMerDesc().trim()));			
			//������Ʒ���ϴ�ͼƬ�ļ�
			if (getPicFileName()!=null && getPicFileName().trim().length()>0){
				String tempfilename = Tools.getRndFilename()+Tools.getFileExtName(getPicFileName());
				String filename = ServletActionContext.getServletContext().getRealPath("/upload").replaceAll("\\\\", "/")+"/"+tempfilename;
				FileOutputStream fos = new FileOutputStream(filename);
				FileInputStream fis = new FileInputStream(getPic());
				byte[] buf = new byte[1024];
				int len = 0;
				while((len=fis.read(buf))>0){
					fos.write(buf,0,len);
				}
				if (fis!=null)fis.close();
				if (fos!=null)fos.close();
				model.setPicture("/upload/"+tempfilename);
			}
			//������Ʒ���ϴ���Ƶ�ļ�
			if (getVdFileName()!=null && getVdFileName().trim().length()>0){
				String tempfilename = Tools.getRndFilename()+Tools.getFileExtName(getVdFileName());
				String filename =ServletActionContext.getServletContext().getRealPath("/upload/flv").replaceAll("\\\\", "/")+"/"+tempfilename;
				FileOutputStream fos = new FileOutputStream(filename);
				FileInputStream fis = new FileInputStream(getVd());
				byte[] buf = new byte[1024];
				int len = 0;
				while((len=fis.read(buf))>0){
					fos.write(buf,0,len);
				}
				if (fis!=null)fis.close();
				if (fos!=null)fos.close();
				//ֻ����flv���ļ���,����Ҫ����·��
				model.setVideo("/upload/flv/"+tempfilename);
			}			
			
			//������Ӧ����Ʒ����
			if (category2!=null){
				//����ҵ���߼����װ��ָ������Ʒ���
				model.setCategory(cateService.loadCategory(Integer.valueOf(category2)));
			}else if(category1!=null){
				//����ҵ���߼����װ��ָ������Ʒ���
				model.setCategory(cateService.loadCategory(Integer.valueOf(category1)));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}		
		if (service.saveOrUpdateMerchandise(model)){//����ҵ���߼����������������Ʒ
			addActionMessage(getText("mer_add_succ"));
		}else{
			addActionMessage(getText("mer_add_fail"));
		}
		//������Ʒ���༶������
		createDoubleSelect();		
		return SUCCESS;
	}
	
	/** ����ɾ����Ʒ���� */
	public String delMerchandise(){
		if (model.getId()!=null){
			if (service.delMerchandise(model.getId())){//����ҵ���߼����ɾ��ָ������Ʒ
				actionMsg = getText("mer_del_succ");
			}else{
				actionMsg = getText("mer_del_fail");
			}			
		}else{
			actionMsg = getText("mer_del_fail");
		}
		actionMsg = java.net.URLEncoder.encode(actionMsg);
		return "toBrowseMerchandise";
	}
	
	/** ����鿴��Ʒ���� */
	public String viewMerchandise(){
		if (model.getId()!=null){
			//����ҵ���߼����װ��ָ������Ʒ
			Merchandise tempMerchandise = service.loadMerchandise(model.getId());
			if (tempMerchandise!=null){
				try {
					//���ٸ���Դ�����е��������Ե�Ŀ�������
					BeanUtils.copyProperties(model, tempMerchandise);
				} catch (Exception e) {
					e.printStackTrace();
				}
				Category tmpCate=tempMerchandise.getCategory();
				//ȡ��������Ŀ��ǰֵ
				if (tmpCate.getCategory()!=null){
					category2 = tmpCate.getId().toString();
					category1 = tmpCate.getCategory().getId().toString();
				}else{
					category1 = tmpCate.getId().toString();
				}
				//������Ʒ���༶������
				createDoubleSelect();
				return SUCCESS;
			}else{
				actionMsg = getText("mer_view_fail");
				actionMsg = java.net.URLEncoder.encode(actionMsg);
				return "toBrowseMerchandise";
			}	
		}else{
			actionMsg = getText("mer_view_fail");
			actionMsg = java.net.URLEncoder.encode(actionMsg);
			return "toBrowseMerchandise";
		}		
	}
	
	/** ����װ����Ʒ���� */
	public String editMerchandise(){
		if (model.getId()!=null){
			//����ҵ���߼����װ��ָ������Ʒ
			Merchandise tempMerchandise = service.loadMerchandise(model.getId());
			if (tempMerchandise!=null){
				try {
					//���ٸ���Դ�����е��������Ե�Ŀ�������
					BeanUtils.copyProperties(model, tempMerchandise);
				} catch (Exception e) {
					e.printStackTrace();
				}
				Category tmpCate=tempMerchandise.getCategory();
				//ȡ��������Ŀ��ǰֵ
				if (tmpCate.getCategory()!=null){
					category2 = tmpCate.getId().toString();
					category1 = tmpCate.getCategory().getId().toString();
				}else{
					category1 = tmpCate.getId().toString();
				}
				//������Ʒ���༶������
				createDoubleSelect();
				return SUCCESS;
			}else{
				actionMsg = getText("mer_view_fail");
				actionMsg = java.net.URLEncoder.encode(actionMsg);
				return "toBrowseMerchandise";
			}	
		}else{
			actionMsg = getText("mer_view_fail");
			actionMsg = java.net.URLEncoder.encode(actionMsg);
			return "toBrowseMerchandise";
		}			
	}
	
	/** ���������Ʒ���� */
	public String updateMerchandise(){
		//����ҵ���߼����װ��ָ������Ʒ
		Merchandise tempMerchandise = service.loadMerchandise(model.getId());
		try {
			//���������ֶε�ԭʼֵ
			model.setHtmlPath(tempMerchandise.getHtmlPath());
			model.setPicture(tempMerchandise.getPicture());
			model.setVideo(tempMerchandise.getVideo());
			
			//����Ʒ���ݽ���Escape����
			model.setMerDesc(Tools.escape(model.getMerDesc().trim()));			
			//������Ʒ���ϴ�ͼƬ�ļ�
			if (getPicFileName()!=null && getPicFileName().trim().length()>0){
				String tempfilename = Tools.getRndFilename()+Tools.getFileExtName(getPicFileName());
				String filename = ServletActionContext.getServletContext().getRealPath("/upload").replaceAll("\\\\", "/")+"/"+tempfilename;
				FileOutputStream fos = new FileOutputStream(filename);
				FileInputStream fis = new FileInputStream(getPic());
				byte[] buf = new byte[1024];
				int len = 0;
				while((len=fis.read(buf))>0){
					fos.write(buf,0,len);
				}
				if (fis!=null)fis.close();
				if (fos!=null)fos.close();
				model.setPicture("/upload/"+tempfilename);
			}
			//������Ʒ���ϴ���Ƶ�ļ�
			if (getVdFileName()!=null && getVdFileName().trim().length()>0){
				String tempfilename = Tools.getRndFilename()+Tools.getFileExtName(getVdFileName());
				String filename =ServletActionContext.getServletContext().getRealPath("/upload/flv").replaceAll("\\\\", "/")+"/"+tempfilename;
				FileOutputStream fos = new FileOutputStream(filename);
				FileInputStream fis = new FileInputStream(getVd());
				byte[] buf = new byte[1024];
				int len = 0;
				while((len=fis.read(buf))>0){
					fos.write(buf,0,len);
				}
				if (fis!=null)fis.close();
				if (fos!=null)fos.close();
				model.setVideo("/upload/flv/"+tempfilename);
			}			
			
			//������Ӧ����Ʒ����
			if (category2!=null){
				//����ҵ���߼����װ��ָ������Ʒ���
				model.setCategory(cateService.loadCategory(Integer.valueOf(category2)));
			}else if(category1!=null){
				//����ҵ���߼����װ��ָ������Ʒ���
				model.setCategory(cateService.loadCategory(Integer.valueOf(category1)));
			}
			
			//����Ʒ��Ϊ"δ����"
			model.setStatus(0);			
		} catch (Exception e) {
			e.printStackTrace();
		}		
		if (service.saveOrUpdateMerchandise(model)){//����ҵ���߼��������ָ������Ʒ
			addActionMessage(getText("mer_edit_succ"));
		}else{
			addActionMessage(getText("mer_edit_fail"));
		}
		//������Ʒ���༶������
		createDoubleSelect();		
		return INPUT;		
	}
	
	/** ������Ʒ���༶�������б����� */
	public String preAddMerchandise(){
		//������Ʒ���༶������
		createDoubleSelect();
		return SUCCESS;		
	}
	
	/** ������Ʒ���༶������ */
	private void createDoubleSelect(){
		doubleSelectNodes=new ArrayList<DoubleSelectNode>();
		DoubleSelectNode node = null;
		DoubleSelectNode tempnode = null;
		List<DoubleSelectNode> nodes = null;
		List<Category> cateList = cateService.listCategory();
		List<Category> childCateList = null;
		Category cate = null;
		Category child_cate = null;
		Iterator<Category> it = cateList.iterator();
		Iterator<Category> it1 = null;
		while(it.hasNext()){
			cate = it.next();
			node = new DoubleSelectNode();
			node.setName(cate.getCateName().trim());
			node.setValue(cate.getId().toString());
			childCateList = cateService.listChildCategory(cate);
			it1 = childCateList.iterator();
			nodes = new ArrayList<DoubleSelectNode>();
			while(it1.hasNext()){
				child_cate = it1.next();
				tempnode = new DoubleSelectNode();
				tempnode.setName(child_cate.getCateName().trim());
				tempnode.setValue(child_cate.getId().toString());
				nodes.add(tempnode);
			}
			node.setSubNodes(nodes);
			doubleSelectNodes.add(node);
		}		
	}
	
	/** ����ָ����Ʒ */
	public String publisMerchandise(){
		if (model.getId()!=null){
			Merchandise mer = service.loadMerchandise(model.getId());
			if (mer!=null){
				HttpServletRequest request = ServletActionContext.getRequest();
				String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();				
				String url=basePath+"/admin/viewMerchandise.action?id="+mer.getId();
				//������̬ҳ��������ʵ��
				HtmlGenerator hg = new HtmlGenerator(basePath);
				//�����ɾ�̬ҳ��
				if (hg.createHtmlPage(url, request.getRealPath(mer.getHtmlPath()))){
					actionMsg = getText("mer_publish_succ");
					//������Ʒ��ǳ��ѷ���
					mer.setStatus(1);					
				}else{
					actionMsg = getText("mer_publish_fail");
					//������Ʒ��ǳ�δ����
					mer.setStatus(0);					
				}
				service.saveOrUpdateMerchandise(mer);	
			}		
		}
		actionMsg = java.net.URLEncoder.encode(actionMsg);
		return "toBrowseMerchandise";		
	}
	
	/** ���JasperReport���� */
	public String report(){
		ds_merList = service.browseMerchandise();
		Admin admin = (Admin)ServletActionContext.getRequest().getSession().getAttribute("admin");
		if (admin!=null){
			reportMan = admin.getLoginName();
		}
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		reportDate = sf.format(new Date());
		if (ServletActionContext.getRequest().getParameter("format")!=null){
			reportFormat = ServletActionContext.getRequest().getParameter("format");
		}
		//ת��JasperReport��ͼ
		return SUCCESS;
	}
	
	/** �ֶ�����������Ʒ�ı���֤ */
	public void validateAddMerchandise(){
		//��Ʒ���Ʊ���
		if (model.getMerName()==null||model.getMerName().trim().length()<1){
			addFieldError("merName",getText("mer_validation_name"));
		}
		//ʹ��������ʽ��֤��Ʒ�г��۸�
		if (model.getPrice()==null || !Pattern.matches("\\d{1,6}(\\.\\d{1,2})?", model.getPrice().toString())){
			addFieldError("price",getText("mer_validation_price"));
		}
		//ʹ��������ʽ��֤��Ʒ�Żݼ۸�
		if (model.getSpecial()==1){
			if (model.getSprice()==null || !Pattern.matches("\\d{1,6}(\\.\\d{1,2})?", model.getSprice().toString())){
				addFieldError("sprice",getText("mer_validation_sprice"));
			}			
		}		
		//��Ʒ�ͺű���
		if (model.getMerModel()==null||model.getMerModel().trim().length()<1){
			addFieldError("merModel",getText("mer_validation_model"));
		}
		//��Ʒ��������
		if (model.getMerDesc()==null||model.getMerDesc().trim().length()<1){
			addFieldError("merDesc",getText("mer_validation_desc"));
		}
		//��Ʒ����ͼƬ�����ϴ�
		if (getPicFileName()==null || getPicFileName().trim().length()==0){
			String[] args = new String[1];
			args[0] = "��ƷͼƬ";				
			addFieldError("picture",getText("mer_validation_pic",args));
		}		
		//���ϴ���ͼƬ�ļ����ͽ�����Ч����֤
		if (getPicFileName()!=null && getPicFileName().trim().length()>0){
			if (!Tools.isEnableUploadType(1, getPicFileName())){
				String[] args = new String[1];
				args[0] = "��ƷͼƬ";				
				addFieldError("picture",getText("upload_picture_invalid",args));
			}
		}
		//���ϴ�����Ƶ�ļ����ͽ�����Ч����֤
		if (getVdFileName()!=null && getVdFileName().trim().length()>0){
			if (!Tools.isEnableUploadType(2, getVdFileName())){
				String[] args = new String[1];
				args[0] = "��Ʒ��Ƶ";
				addFieldError("video",getText("upload_video_invalid",args));
			}
		}		
		//����֤ʧ��
		if (hasFieldErrors()){
			//������Ʒ���༶������
			createDoubleSelect();
		}
	}
	
	/** �ֶ������޸���Ʒ�ı���֤ */
	public void validateUpdateMerchandise(){
		//����������Ʒ�ĵı���֤��������֤�޸���Ʒ�ı�
		validateAddMerchandise();
		//�޸���Ʒ��Ϣʱ����ƷͼƬ���Ǳ����ϴ���
		if (getPicFileName()==null || getPicFileName().trim().length()==0){
			Map errorMap = getFieldErrors();
			errorMap.remove("picture");
			setFieldErrors(errorMap);			
		}
	}	

	public MerchandiseService getService() {
		return service;
	}

	public void setService(MerchandiseService service) {
		this.service = service;
	}

	public String getActionMsg() {
		return actionMsg;
	}

	public void setActionMsg(String actionMsg) {
		this.actionMsg = actionMsg;
	}

	public List<DoubleSelectNode> getDoubleSelectNodes() {
		return doubleSelectNodes;
	}

	public void setDoubleSelectNodes(List<DoubleSelectNode> doubleSelectNodes) {
		this.doubleSelectNodes = doubleSelectNodes;
	}

	public File getPic() {
		return pic;
	}

	public void setPic(File pic) {
		this.pic = pic;
	}

	public String getPicContentType() {
		return picContentType;
	}

	public void setPicContentType(String picContentType) {
		this.picContentType = picContentType;
	}

	public String getPicFileName() {
		return picFileName;
	}

	public void setPicFileName(String picFileName) {
		this.picFileName = picFileName;
	}

	public CategoryService getCateService() {
		return cateService;
	}

	public void setCateService(CategoryService cateService) {
		this.cateService = cateService;
	}

	public List<Merchandise> getMerList() {
		return merList;
	}

	public void setMerList(List<Merchandise> merList) {
		this.merList = merList;
	}

	public File getVd() {
		return vd;
	}

	public void setVd(File vd) {
		this.vd = vd;
	}

	public String getVdContentType() {
		return vdContentType;
	}

	public void setVdContentType(String vdContentType) {
		this.vdContentType = vdContentType;
	}

	public String getVdFileName() {
		return vdFileName;
	}

	public void setVdFileName(String vdFileName) {
		this.vdFileName = vdFileName;
	}

	public String getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}

	public String getCategory1() {
		return category1;
	}

	public void setCategory1(String category1) {
		this.category1 = category1;
	}

	public String getCategory2() {
		return category2;
	}
	public void setCategory2(String category2) {
		this.category2 = category2;
	}
	public String getReportMan() {
		return reportMan;
	}
	public String getReportDate() {
		return reportDate;
	}
	public String getReportFormat() {
		return reportFormat;
	}

	public List<Merchandise> getDs_merList() {
		return ds_merList;
	}
}