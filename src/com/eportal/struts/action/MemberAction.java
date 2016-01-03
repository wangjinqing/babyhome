package com.eportal.struts.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts2.ServletActionContext;

import com.eportal.ORM.Member;
import com.eportal.ORM.Memberlevel;
import com.eportal.service.MemberLevelService;
import com.eportal.service.MemberService;
import com.eportal.util.MD5;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

/** ע���Ա��������� */
@SuppressWarnings("serial")
public class MemberAction extends ActionSupport implements ModelDriven<Member>{
	/** ͨ������ע��MemberService��MemberLevelService���ʵ�� */
	MemberService service;
	MemberLevelService memberLevelService;
	
	/** ע���Ա�������������г��õĲ���ֵ */
	private String actionMsg;	//Action�䴫�ݵ���Ϣ����
	private List<Member> memberList;//ע���Ա�б�
	private List<Memberlevel> memberLevelList;//��Ա�����б� 
	private String memeberLevel;	//������Ա����
	
	//����ģ������
	private Member model=new Member();//���ڷ�װ��Ա����ģ��
	public Member getModel() {
		return model;
	}
	
	/** �����¼���� */
	public String login(){
		//����ҵ���߼�������л�Ա��¼��֤
		Member tempMember = service.memberLogin(model.getLoginName(), MD5.MD5Encode(model.getLoginPwd()));
		if(tempMember!=null){
			//��session�б��浱ǰ��Աʵ��
			ServletActionContext.getRequest().getSession().setAttribute("member",tempMember);
			//�������¼ʱ�估��¼����
			tempMember.setLastDate(new Date());
			tempMember.setLoginTimes(tempMember.getLoginTimes().intValue()+1);
			service.saveOrUpdateMember(tempMember);//����ҵ���߼�������»�Ա����
			return INPUT;
		}else{
			addActionError(getText("login_fail"));
			return INPUT;				
		}
	}
	
	/** ��AJAX���ʵĵ�¼��֤���� */
	public String isLogined(){
		String result = "Not Logined!";
		try {
			//ȡ�õ�ǰAction��ԭʼPrintWriter����,�Ա�ֱ�������Ӧ���,��������ת��ĳ����ͼ
			HttpServletResponse response = ServletActionContext.getResponse();
			response.setCharacterEncoding("gbk");
			response.setContentType("text/plain");
			PrintWriter out = response.getWriter();
			//�ж��Ƿ��Ѿ���¼
			Member mem = (Member)ServletActionContext.getRequest().getSession().getAttribute("member");
			if (mem!=null){
				result = mem.getMemberlevel().getLevelName()+mem.getLoginName()+"�����ã���ӭ����ePortal�̳�! ��Ŀǰ�Ļ���Ϊ"
						+ mem.getIntegral()+"�֣�<a href='"+ServletActionContext.getServletContext().getContextPath()+"/webs/logoutMember.action' target='_self'><span class='blueText'>��ȫ�˳�</span></a>";
			}
			//ֱ�������Ӧ����
			out.println(result);
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		//����Ҫ��ת��ĳ����ͼ����Ϊ�����Ѿ�����ֱ�ӵ������Ӧ���
		return null;
	}
	
	/** ����ȫ�˳����� */
	public String logout(){
		//��session���Ƴ���ǰ��Աʵ��
		ServletActionContext.getRequest().getSession().removeAttribute("member");
		return INPUT;
	}
	
	/** �������ע���Ա���� */
	public String browseMember(){
		if(actionMsg!=null&&ServletActionContext.getRequest().getParameter("d-16544-p")==null){
			actionMsg = java.net.URLDecoder.decode(actionMsg);
			addActionMessage(actionMsg);
		}
		memberList = service.browseMember();//����ҵ���߼����ȡ��ע���Ա�б�
		return SUCCESS;
	}
	
	/** ��������ע���Ա���� */
	public String addMember(){
		//�������¼����ֶεĳ�ʼֵ
		model.setRegDate(new Date());
		model.setLoginTimes(0);
		
		//�Ե�¼�������MD5����
		model.setLoginPwd(MD5.MD5Encode(model.getLoginPwd().trim()));		
		//���Ա������й���
		if(memeberLevel!=null){
			//����ҵ���߼����װ��ָ���Ļ�Ա����
			Memberlevel tempMemberLevel = memberLevelService.loadMemberlevel(Integer.valueOf(memeberLevel));
			model.setMemberlevel(tempMemberLevel);
			//���͸ü���ĵȶ����
			model.setIntegral(tempMemberLevel.getIntegral());
		}		
		if (service.saveOrUpdateMember(model)){//����ҵ���߼��������������ע���Ա
			addActionMessage(getText("member_add_succ"));
		}else{
			addActionMessage(getText("member_add_fail"));
		}
		//Ϊ��̨��Ա�������Ա���������б�����
		memberLevelList = memberLevelService.browseMemberlevel();		
		return SUCCESS;
	}
	
	/** �����Աע������ */
	public String regMember(){
		//�������¼����ֶεĳ�ʼֵ
		model.setRegDate(new Date());
		model.setLoginTimes(0);
		
		//�Ե�¼�������MD5����
		model.setLoginPwd(MD5.MD5Encode(model.getLoginPwd().trim()));
		//���ó�ʼ��Ա����
		Memberlevel tempMemberLevel = memberLevelService.getInitMemberlevel();
		if(tempMemberLevel!=null){
			model.setMemberlevel(tempMemberLevel);
			//���͸ü���ĵȶ����
			model.setIntegral(tempMemberLevel.getIntegral());
		}
		if (service.saveOrUpdateMember(model)){//����ҵ���߼��������������ע���Ա
			addActionMessage(getText("member_add_succ"));
		}else{
			addActionMessage(getText("member_add_fail"));
		}		
		return INPUT;
	}
	
	/** ����ɾ��ע���Ա���� */
	public String delMember(){
		if (model.getId()!=null){
			if (service.delMember(model.getId())){//����ҵ���߼����ɾ��ָ����ע���Ա
				actionMsg = getText("member_del_succ");
			}else{
				actionMsg = getText("member_del_fail");
			}			
		}else{
			actionMsg = getText("member_del_fail");
		}
		actionMsg = java.net.URLEncoder.encode(actionMsg);
		return "toBrowseMember";
	}
	
	/** ����鿴ע���Ա���� */
	public String viewMember(){
		if (model.getId()!=null){
			//����ҵ���߼����װ��ָ����ע���Ա
			Member tempMember = service.loadMember(model.getId());
			if (tempMember!=null){
				try {
					//���ٸ���Դ�����е��������Ե�Ŀ�������
					BeanUtils.copyProperties(model, tempMember);
				} catch (Exception e) {
					e.printStackTrace();
				}
				//ȡ�û�Ա�����б�
				memberLevelList = memberLevelService.browseMemberlevel();
				//ȡ�õ�ǰ��Ա�ļ���ID
				memeberLevel = tempMember.getMemberlevel().getId().toString();
				return SUCCESS;
			}else{
				actionMsg = getText("member_view_fail");
				actionMsg = java.net.URLEncoder.encode(actionMsg);
				return "toBrowseMember";
			}	
		}else{
			actionMsg = getText("member_view_fail");
			actionMsg = java.net.URLEncoder.encode(actionMsg);
			return "toBrowseMember";
		}		
	}
	
	/** ����װ��ע���Ա���� */
	public String editMember(){
		if (model.getId()!=null){
			//����ҵ���߼����װ��ָ����ע���Ա			
			Member tempMember = service.loadMember(model.getId());
			if (tempMember!=null){
				try {
					//���ٸ���Դ�����е��������Ե�Ŀ�������
					BeanUtils.copyProperties(model, tempMember);
				} catch (Exception e) {
					e.printStackTrace();
				}
				//ȡ�û�Ա�����б�
				memberLevelList = memberLevelService.browseMemberlevel();
				//ȡ�õ�ǰ��Ա�ļ���ID
				memeberLevel = tempMember.getMemberlevel().getId().toString();			
				return SUCCESS;
			}else{
				actionMsg = getText("member_edit_fail");
				actionMsg = java.net.URLEncoder.encode(actionMsg);
				return "toBrowseMember";
			}	
		}else{
			actionMsg = getText("member_edit_fail");
			actionMsg = java.net.URLEncoder.encode(actionMsg);
			return "toBrowseMember";
		}		
	}
	
	/** �������ע���Ա���� */
	public String updateMember(){
		//����ҵ���߼����װ��ָ����ע���Ա
		Member tempMember = service.loadMember(model.getId());
		//�޸Ļ�Աע����Ϣ
		if (model.getAddress()!=null)tempMember.setAddress(model.getAddress());		
		if (model.getEmail()!=null)tempMember.setEmail(model.getEmail());		
		if (model.getLoginName()!=null)tempMember.setLoginName(model.getLoginName());		
		if (model.getMemberName()!=null)tempMember.setMemberName(model.getMemberName());		
		if (model.getPhone()!=null)tempMember.setPhone(model.getPhone());		
		if (model.getZip()!=null)tempMember.setZip(model.getZip());		
		if (model.getIntegral()!=null)tempMember.setIntegral(model.getIntegral());		
		if (model.getLoginPwd()!=null && model.getLoginPwd().trim().length()>0){//��������
			tempMember.setLoginPwd(MD5.MD5Encode(model.getLoginPwd().trim()));

		}
		//���Ա������й���
		if (memeberLevel!=null){
			//����ҵ���߼����װ��ָ���Ļ�Ա����
			Memberlevel tempMemberLevel = memberLevelService.loadMemberlevel(Integer.valueOf(memeberLevel));
			tempMember.setMemberlevel(tempMemberLevel);			
		}
		if (service.saveOrUpdateMember(tempMember)){//����ҵ���߼��������ָ����ע���Ա
			addActionMessage(getText("member_edit_succ"));
		}else{
			addActionMessage(getText("member_edit_fail"));
		}
		//Ϊ��̨��Ա�������Ա���������б�����
		memberLevelList = memberLevelService.browseMemberlevel();		
		//����û�Ա�Ѿ���¼,ͬ���޸�session�еĻ�Ա��Ϣ
		if (ServletActionContext.getRequest().getSession().getAttribute("member")!=null){
			ServletActionContext.getRequest().getSession().setAttribute("member",tempMember);
		}		
		return INPUT;		
	}
	
	/** �����Ա���������б����� */
	public String preAddMember(){
		//Ϊ��̨��Ա�������Ա���������б�����
		memberLevelList = memberLevelService.browseMemberlevel();
		return SUCCESS;		
	}
	
	/** �ֶ���������ע���Ա�ı���֤ */
	public void validateAddMember(){
		//��¼�˺ű���
		if (model.getLoginName()==null||model.getLoginName().trim().length()<1){
			addFieldError("loginname",getText("member_validation_loginName"));
		}else{//��¼�˺��Ƿ��ѱ�ռ��
			if (!service.isEnable(model.getLoginName().trim())){
				addFieldError("loginname",getText("member_validation_exist"));
			}
		}		
		//��¼�������
		if (model.getLoginPwd()==null||model.getLoginPwd().trim().length()<1){
			addFieldError("loginpwd",getText("member_validation_loginPwd"));
		}else{
			//�˶���������������Ƿ�һ��
			String againPwd = ServletActionContext.getRequest().getParameter("againPwd");
			if (againPwd==null || againPwd.trim().length()<1 || !againPwd.trim().equals(model.getLoginPwd())){
				addFieldError("loginpwd",getText("member_validation_checkerr"));
			}				
		}	
		//��ϵ�绰Ϊ�̶��绰���ֻ���ʽ,ʹ��������ʽ������֤
		if (model.getPhone()!=null && model.getPhone().trim().length()>0 && !Pattern.matches("((\\d{3,4})?(\\-)?(\\d{7,8}))|(0?1\\d{10})", model.getPhone().trim())){
			addFieldError("phone",getText("member_validation_phone"));
		}
		//ʹ��������ʽ��֤��������
		if (model.getZip()!=null && model.getZip().trim().length()>0 && !Pattern.matches("\\d{6}", model.getZip().trim())){
			addFieldError("zip",getText("member_validation_zip"));
		}
		//Email�Ϸ�����֤
		if (model.getEmail()!=null && model.getEmail().trim().length()>0 && !Pattern.matches("\\w+(\\.\\w+)*@\\w+(\\.\\w+)+", model.getEmail().trim())){
			addFieldError("email",getText("member_validation_email"));
		}
		//����֤ʧ��
		if (hasFieldErrors()){
			//Ϊ��̨��Ա�������Ա���������б�����
			memberLevelList = memberLevelService.browseMemberlevel();
		}		
	}
	
	/** �ֶ������޸�ע���Ա�ı���֤ */
	public void validateUpdateMember(){
		//��¼�˺ű���
		if (model.getLoginName()==null||model.getLoginName().trim().length()<1){
			addFieldError("loginname",getText("member_validation_loginName"));
		}else{
			Member tempMember = (Member)ServletActionContext.getRequest().getSession().getAttribute("member");
			if (tempMember==null){//��̨�Ļ�Ա�޸�����
				tempMember = service.loadMember(model.getId());//װ�ظû�Աԭʼ����
			}
			if (!tempMember.getLoginName().equals(model.getLoginName())){//����ԭ��¼��
				//��¼�˺��Ƿ��ѱ�ռ��
				if (!service.isEnable(model.getLoginName().trim())){
					addFieldError("loginname",getText("member_validation_exist"));
				}					
			}
		}
		//�˶���������������Ƿ�һ��
		String againPwd = ServletActionContext.getRequest().getParameter("againPwd");
		if (model.getLoginPwd()!=null && !model.getLoginPwd().equals(againPwd)){
			addFieldError("loginpwd",getText("member_validation_checkerr"));
		}		
		//��ϵ�绰Ϊ�̶��绰���ֻ���ʽ,ʹ��������ʽ������֤
		if (model.getPhone()!=null && model.getPhone().trim().length()>0 && !Pattern.matches("((\\d{3,4})?(\\-)?(\\d{7,8}))|(0?1\\d{10})", model.getPhone().trim())){
			addFieldError("phone",getText("member_validation_phone"));
		}
		//ʹ��������ʽ��֤��������
		if (model.getZip()!=null && model.getZip().trim().length()>0 && !Pattern.matches("\\d{6}", model.getZip().trim())){
			addFieldError("zip",getText("member_validation_zip"));
		}
		//Email�Ϸ�����֤
		if (model.getEmail()!=null && model.getEmail().trim().length()>0 && !Pattern.matches("\\w+(\\.\\w+)*@\\w+(\\.\\w+)+", model.getEmail().trim())){
			addFieldError("email",getText("member_validation_email"));
		}
		//����֤ʧ��
		if (hasFieldErrors()){
			//Ϊ��̨��Ա�������Ա���������б�����
			memberLevelList = memberLevelService.browseMemberlevel();
		}
	}	

	/** �ֶ����л�Աע��ı���֤ */
	public void validateRegMember(){
		//��������ע���Ա������֤����ʵ���޸�ע���Ա������֤
		validateAddMember();
	}	
	
	public MemberService getService() {
		return service;
	}
	public void setService(MemberService service) {
		this.service = service;
	}
	public String getActionMsg() {
		return actionMsg;
	}

	public void setActionMsg(String actionMsg) {
		this.actionMsg = actionMsg;
	}
	
	public List<Member> getMemberList() {
		return memberList;
	}
	
	public void setMemberList(List<Member> memberList) {
		this.memberList = memberList;
	}

	public String getMemeberLevel() {
		return memeberLevel;
	}

	public void setMemeberLevel(String memeberLevel) {
		this.memeberLevel = memeberLevel;
	}

	public MemberLevelService getMemberLevelService() {
		return memberLevelService;
	}

	public void setMemberLevelService(MemberLevelService memberLevelService) {
		this.memberLevelService = memberLevelService;
	}

	public List<Memberlevel> getMemberLevelList() {
		return memberLevelList;
	}

	public void setMemberLevelList(List<Memberlevel> memberLevelList) {
		this.memberLevelList = memberLevelList;
	}
}
