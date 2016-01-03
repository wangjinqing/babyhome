<%@ page contentType="text/html; charset=gbk"%>
<%@include file="../common/web_head.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"  xml:lang="zh-CN" lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>会员注册-<s:text name="website_name"/></title>
<base target="_blank" />
<meta name="Keywords" content="电子商务,电子商城,在线购物,网上购物" />
<meta name="Description" content="电子商务门户ePortal免费提供电子商城在线购物、商品展示、订单管理、商讯搜索等常见的电子商务功能!" />
<meta name="robots" content="index, follow" />
<meta name="googlebot" content="index, follow" />
<link href="<%=basepath%>/css/style.css" rel="stylesheet" type="text/css" />
</head>

<body>
<!--DIV页面主容器-->
<div class="container">
<%@include file="../common/menubar.jsp"%>
<!-- 栏间留空 -->	
	<div class="split"></div>
<!--位置导航区-->	
	<div class="nav">
		<div class="nav_left"></div>
		<div class="nav_main">
			您现在的位置：<a href="<%=basepath%>/webs/index.jsp">首页</a> >> 会员注册</div>
		<div class="nav_now">
			<%@include file="../common/jsdate.jsp"%>	
		</div>
		<div class="nav_right"></div>
	</div>
<!-- 栏间留空 -->	
	<div class="split"></div>
<!-- 页面主体左侧 -->	
	<div class="main_left">
<!-- 商品分类区 -->	
		<div class="cate">
			<div class="cate_head_left"></div>
			<div class="cate_head_text"><h2>商品分类</h2></div>
			<div class="cate_head_main"></div>
			<div class="cate_head_right"></div>
			<div class="cate_body">
				<!-- 使用自定义商品类别列表标签 -->
				<e:category/>  				
			</div>
		</div>
<!-- 栏间留空 -->	
		<div class="split"></div>		
<!-- 促销打折区 -->	
		<div class="prom">
			<div class="prom_head_left"></div>
			<div class="prom_head_text"><h2>促销打折</h2></div>
			<div class="prom_head_main"></div>
			<div class="prom_head_right"></div>
			<div class="prom_body">
				<!-- 使用自定义商品列表标签 -->
				<e:merlist baseurl="<%=basepath%>" size="4" listtype="2"/> 		
			</div>
		</div>			
	</div>
<!-- 页面主体右侧 -->	
	<div class="main_right">
<!-- 会员注册区 -->	
		<div class="cart">
			<div class="mer_head_left"></div>
			<div class="mer_head_text"><h2>会员注册</h2></div>
			<div class="mer_head_main"></div>
			<div class="mer_head_right"></div>
			<div class="cart_body">
				<br/>
					<s:form action="/webs/regMember.action" id="regform" target="_self">
					<table width="95%" align="center" border="0" cellpadding="0" cellspacing="1" bgcolor="#FFFFFF">
					  <tr bgcolor="#F7F3F7" height="29">
						<td align="right" width="220">登录账号：</td>
						<td><s:textfield name="loginName" size="40"/>&nbsp;<span class='redtext'>*</span></td>
					  </tr>
					  <tr bgcolor="#F7F3F7" height="29">
						<td align="right">登录密码：</td>
						<td><s:password name="loginPwd" size="40"/>&nbsp;<span class='redtext'>*</span></td>
					  </tr>
					  <tr bgcolor="#F7F3F7" height="29">
						<td align="right">核对密码：</td>
						<td><s:password name="againPwd" size="40"/>&nbsp;<span class='redtext'>*</span></td>
					  </tr>
					  <tr bgcolor="#F7F3F7" height="29">
						<td align="right">真实姓名：</td>
						<td><s:textfield name="memberName" size="40"/></td>
					  </tr>
					  <tr bgcolor="#F7F3F7" height="29">
						<td align="right">联系电话：</td>
						<td><s:textfield name="phone" size="40"/></td>
					  </tr>
					  <tr bgcolor="#F7F3F7" height="29">
						<td align="right">联系地址：</td>
						<td><s:textfield name="address" size="40"/></td>
					  </tr>
					  <tr bgcolor="#F7F3F7" height="29">
						<td align="right">邮政编码：</td>
						<td><s:textfield name="zip" size="40"/></td>
					  </tr>
					  <tr bgcolor="#F7F3F7" height="29">
						<td align="right">电子邮箱：</td>
						<td><s:textfield name="email" size="40"/></td>
					  </tr>
					  <tr>
						<td height="40" colspan="2" align="center">
							<s:submit type="image" src="../images/submit.gif"/>&nbsp;&nbsp;
							<input type="image" src="../images/reset.gif"  onclick="regform.reset(); return false;"/>
						</td>
					  </tr>
					</table>
				</s:form>				
			</div>
		</div>
<!-- 最新商品区 -->	
		<div class="cartmer">
			<div class="mer_head_left"></div>
			<div class="mer_head_text"><h2>最新上架</h2></div>
			<div class="mer_head_main"></div>
			<div class="mer_head_right"></div>
			<div class="cartmer_body">
				<!-- 使用自定义商品列表标签 -->
				<e:merlist baseurl="<%=basepath%>" size="10" listtype="1" picWidth="94"/> 
			</div>
		</div>		
	</div>		
<!-- 栏间留空 -->	
	<div class="split"></div>	
<!-- 页脚区 -->			
<%@include file="../common/foot.jsp"%>					
</div>
<!-- 输出表单提示信息 -->
<s:if test="hasFieldErrors()">
	<!-- 使用自定义带遮罩网页对话框标签 -->
	<e:msgdialog basepath="<%=basepath%>" height="1020" top="140">
		<s:fielderror/>
	</e:msgdialog>
</s:if>
<s:if test="hasActionMessages()">
	<!-- 使用自定义带遮罩网页对话框标签 -->
	<e:msgdialog basepath="<%=basepath%>" height="1020" top="140">
		<s:actionmessage/>
	</e:msgdialog>
</s:if>	
</body>
</html>
