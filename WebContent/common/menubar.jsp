<%@ page contentType="text/html; charset=gbk"%>
<!--Logo区-->
<div>
	<img src="<%=basepath%>/images/ad1.gif" style="height:60px;width:100%;"/>
</div>
<!-- 栏间留空 -->	
<div class="split"></div>	
<!--搜索与注册登录区-->	
<div class="search">
	<div class="search_left">
	</div>
	<div class="search_main">
<!--注册登录区-->		
         <div class="logo_left login">
			<img src="<%=basepath%>/images/logo.gif" style="height:50px;width:160px;"/>
		</div>	
		<div class="login" style="display: none;">
			<div class="login_left"></div>
			<div class="login_main">			 	
					<s:form action="/webs/loginMember.action" id="loginform" target="_self" style="display:none">
						用户名：<s:textfield name="loginName" id="loginName" size="16"/>
						密码：<s:password name="loginPwd" id="loginPwd" size="16"/>
						<input type="image" src="<%=basepath%>/images/login.jpg" onclick="checkForm(); return false;"/>
						&nbsp;&nbsp;<a href="<%=basepath%>/webs/reg.jsp" target="_self">注册新会员</a>
					</s:form>					
					<span class="actionMessage" id="logined_span"></span>
					<script language='javascript'>
						//定义一个变量用于存放XMLHttpRequest对象
						var xmlHttp;
						//定义一个变量用于存放登录状态,默认为未登录
						var loginStatus=false; 
						
						//该函数用于创建一个XMLHttpRequest对象
						function createXMLHttpRequest() {
							if (window.ActiveXObject) {
								xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
							} 
							else if (window.XMLHttpRequest) {
								xmlHttp = new XMLHttpRequest();
							}
						}
						
						//这是一个启动AJAX异步通信的方法
						function checkLogined(){
							var now = new Date();
							//创建一个XMLHttpRequest对象
							createXMLHttpRequest();
							//将状态触发器绑定到一个函数
							xmlHttp.onreadystatechange = processResponse;
							//通过GET方法向指定的URL建立服务器的调用,加个临时参数，以便标识一个全新的请求
							xmlHttp.open("GET", "<%=basepath%>/webs/isLogined.action?tmp="+now.getTime());
							//发送请求
							xmlHttp.send(null);
						}
						
						//这是一用来处理状态改变的函数
						function processResponse(){
							//定义一个变量用于存放从服务器返回的响应结果
							var responseContext;
							if(xmlHttp.readyState == 4) { //如果响应完成
								if(xmlHttp.status == 200) {//如果返回成功
									//取出服务器的响应内容
									responseContext = xmlHttp.responseText;
									if (responseContext.indexOf("Not Logined!")!=-1){//未登录
										document.getElementById("loginform").style.display="inline";
									}else{//已登录
										loginStatus=true; 
										document.getElementById("logined_span").innerHTML=responseContext;
									}
								}
							}
						}
						
						//通过异步通信检查当前用户的登录状态
						checkLogined();
													
						//表单验证
						function checkForm(){
							if (document.getElementById('loginName').value==''){
								alert('对不起,登录用户名不能为空!');
							}else if (document.getElementById('loginPwd').value==''){
								alert('对不起,登录密码不能为空!');
							}else{
								//提交表单
								loginform.submit();
							}
						}
						
						//修改注册资料
						function editMember(){
							if (!loginStatus)
								alert('对不起,您尚未登录,请登录后再修改注册资料,谢谢合作!');
							else
								window.location='<%=basepath%>/webs/editReg.jsp?tmp='+(new Date()).getTime();
						}

						//响应"搜索"按钮
						function search(){
							var p1 = document.getElementById("searchtype").value;
							var p2 = document.getElementById("keyword").value;
							if (p2==''){
								alert('对不起,请先输入关键字然后再搜索,谢谢合作!');
							}else{
								if (p1=='newmer' || p1=='prommer'){//搜索所有商品
									window.location='<%=basepath%>/webs/searchMer.jsp?searchtype='+p1+'&keyword='+encodeURIComponent(p2);
								}else if (p1=='news'){//搜索商城资讯
									window.location='<%=basepath%>/webs/searchNews.jsp?keyword='+encodeURIComponent(p2);
								}
										
							}
						}						
					</script>
			</div>
			<div class="login_right"></div>				
		</div>
<!--搜索区-->
		<div class="sou" style="margin-left:300px;">
			<div class="sou_left"></div>
			<div class="sou_main" >
				类型：<select id="searchtype" name="searchtype">
				<s:if test="#session.searchtype!=null && #session.searchtype.equals('newmer')">
					<option value="newmer" selected="true">所有商品</option>
				</s:if>
				<s:else>
					<option value="newmer" selected="true">所有商品</option>
				</s:else>
				<s:if test="#session.searchtype!=null && #session.searchtype.equals('prommer')">
					<option value="prommer" selected="true">促销商品</option>
				</s:if>
				<s:else>
					<option value="prommer">促销商品</option>
				</s:else>				
				<s:if test="#session.searchtype!=null && #session.searchtype.equals('news')">
					<option value="news" selected="true">商城资讯</option>
				</s:if>
				<s:else>
					<option value="news">商城资讯</option>
				</s:else>		
				</select>
				&nbsp;关键字：<input type="text" id="keyword" name="keyword" size=28 value="${keyword}"/>
			</div>
			<div class="sou_right">
				<input type="image" src="<%=basepath%>/images/search_right.jpg" name="submit" onclick="search()"/>
			</div>					
		</div>						
	</div>
	<div class="search_right"></div>
</div>