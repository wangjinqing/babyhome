<%@ page contentType="text/html; charset=gbk"%>
<!--Logo��-->
<div>
	<img src="<%=basepath%>/images/ad1.gif" style="height:60px;width:100%;"/>
</div>
<!-- �������� -->	
<div class="split"></div>	
<!--������ע���¼��-->	
<div class="search">
	<div class="search_left">
	</div>
	<div class="search_main">
<!--ע���¼��-->		
         <div class="logo_left login">
			<img src="<%=basepath%>/images/logo.gif" style="height:50px;width:160px;"/>
		</div>	
		<div class="login" style="display: none;">
			<div class="login_left"></div>
			<div class="login_main">			 	
					<s:form action="/webs/loginMember.action" id="loginform" target="_self" style="display:none">
						�û�����<s:textfield name="loginName" id="loginName" size="16"/>
						���룺<s:password name="loginPwd" id="loginPwd" size="16"/>
						<input type="image" src="<%=basepath%>/images/login.jpg" onclick="checkForm(); return false;"/>
						&nbsp;&nbsp;<a href="<%=basepath%>/webs/reg.jsp" target="_self">ע���»�Ա</a>
					</s:form>					
					<span class="actionMessage" id="logined_span"></span>
					<script language='javascript'>
						//����һ���������ڴ��XMLHttpRequest����
						var xmlHttp;
						//����һ���������ڴ�ŵ�¼״̬,Ĭ��Ϊδ��¼
						var loginStatus=false; 
						
						//�ú������ڴ���һ��XMLHttpRequest����
						function createXMLHttpRequest() {
							if (window.ActiveXObject) {
								xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
							} 
							else if (window.XMLHttpRequest) {
								xmlHttp = new XMLHttpRequest();
							}
						}
						
						//����һ������AJAX�첽ͨ�ŵķ���
						function checkLogined(){
							var now = new Date();
							//����һ��XMLHttpRequest����
							createXMLHttpRequest();
							//��״̬�������󶨵�һ������
							xmlHttp.onreadystatechange = processResponse;
							//ͨ��GET������ָ����URL�����������ĵ���,�Ӹ���ʱ�������Ա��ʶһ��ȫ�µ�����
							xmlHttp.open("GET", "<%=basepath%>/webs/isLogined.action?tmp="+now.getTime());
							//��������
							xmlHttp.send(null);
						}
						
						//����һ��������״̬�ı�ĺ���
						function processResponse(){
							//����һ���������ڴ�Ŵӷ��������ص���Ӧ���
							var responseContext;
							if(xmlHttp.readyState == 4) { //�����Ӧ���
								if(xmlHttp.status == 200) {//������سɹ�
									//ȡ������������Ӧ����
									responseContext = xmlHttp.responseText;
									if (responseContext.indexOf("Not Logined!")!=-1){//δ��¼
										document.getElementById("loginform").style.display="inline";
									}else{//�ѵ�¼
										loginStatus=true; 
										document.getElementById("logined_span").innerHTML=responseContext;
									}
								}
							}
						}
						
						//ͨ���첽ͨ�ż�鵱ǰ�û��ĵ�¼״̬
						checkLogined();
													
						//����֤
						function checkForm(){
							if (document.getElementById('loginName').value==''){
								alert('�Բ���,��¼�û�������Ϊ��!');
							}else if (document.getElementById('loginPwd').value==''){
								alert('�Բ���,��¼���벻��Ϊ��!');
							}else{
								//�ύ��
								loginform.submit();
							}
						}
						
						//�޸�ע������
						function editMember(){
							if (!loginStatus)
								alert('�Բ���,����δ��¼,���¼�����޸�ע������,лл����!');
							else
								window.location='<%=basepath%>/webs/editReg.jsp?tmp='+(new Date()).getTime();
						}

						//��Ӧ"����"��ť
						function search(){
							var p1 = document.getElementById("searchtype").value;
							var p2 = document.getElementById("keyword").value;
							if (p2==''){
								alert('�Բ���,��������ؼ���Ȼ��������,лл����!');
							}else{
								if (p1=='newmer' || p1=='prommer'){//����������Ʒ
									window.location='<%=basepath%>/webs/searchMer.jsp?searchtype='+p1+'&keyword='+encodeURIComponent(p2);
								}else if (p1=='news'){//�����̳���Ѷ
									window.location='<%=basepath%>/webs/searchNews.jsp?keyword='+encodeURIComponent(p2);
								}
										
							}
						}						
					</script>
			</div>
			<div class="login_right"></div>				
		</div>
<!--������-->
		<div class="sou" style="margin-left:300px;">
			<div class="sou_left"></div>
			<div class="sou_main" >
				���ͣ�<select id="searchtype" name="searchtype">
				<s:if test="#session.searchtype!=null && #session.searchtype.equals('newmer')">
					<option value="newmer" selected="true">������Ʒ</option>
				</s:if>
				<s:else>
					<option value="newmer" selected="true">������Ʒ</option>
				</s:else>
				<s:if test="#session.searchtype!=null && #session.searchtype.equals('prommer')">
					<option value="prommer" selected="true">������Ʒ</option>
				</s:if>
				<s:else>
					<option value="prommer">������Ʒ</option>
				</s:else>				
				<s:if test="#session.searchtype!=null && #session.searchtype.equals('news')">
					<option value="news" selected="true">�̳���Ѷ</option>
				</s:if>
				<s:else>
					<option value="news">�̳���Ѷ</option>
				</s:else>		
				</select>
				&nbsp;�ؼ��֣�<input type="text" id="keyword" name="keyword" size=28 value="${keyword}"/>
			</div>
			<div class="sou_right">
				<input type="image" src="<%=basepath%>/images/search_right.jpg" name="submit" onclick="search()"/>
			</div>					
		</div>						
	</div>
	<div class="search_right"></div>
</div>