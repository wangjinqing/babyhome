<%@ page contentType="text/html; charset=gbk"%>
<%@include file="../common/web_head.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"  xml:lang="zh-CN" lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>查看订单详情-<s:text name="website_name"/></title>
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
			您现在的位置：<a href="<%=basepath%>/webs/index.jsp">首页</a> >> 查看订单详情</div>
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
<!-- 订单详情区 -->	
		<div class="cart">
			<div class="mer_head_left"></div>
			<div class="mer_head_text"><h2>查看订单详情</h2></div>
			<div class="mer_head_main"></div>
			<div class="mer_head_right"></div>
			<div class="addorder_body">
				<s:if test="#session.member==null">
					<center>
						<br/><img hspace="5" src="<%=basepath%>/images/sorry.gif" />
						<br/><span class="errorMessage"><s:text name="orders_add_notlogin"/></span>					
					</center>
				</s:if>
				<s:else>
					<br/>
					<table width="94%" border="0" cellpadding="0" cellspacing="0" bgcolor="#F7F3F7" align="center">
					  <tr height="50" >
						<td colspan="2" class="titleText" align="center">订单基本信息</td>		
					  </tr>
					  <tr height="30" bgcolor="#FFFFFF">
						<td width="146" align="right" class="blackbold">订单编号：</td>
						<td><s:property value="orderNo"/></td>							
					  </tr>
					  <tr height="30" bgcolor="#F7F3F7">
						<td width="146" align="right" class="blackbold">收&nbsp;货&nbsp;人：</td>
						<td><s:property value="member.memberName"/></td>							
					  </tr>
					  <tr height="30" bgcolor="#FFFFFF">
						<td width="146" align="right" class="blackbold">联系电话：</td>
						<td><s:property value="member.phone"/></td>							
					  </tr>
					  <tr height="30" bgcolor="#F7F3F7">
						<td width="146" align="right" class="blackbold">收货地址：</td>
						<td><s:property value="member.address"/></td>							
					  </tr>
					  <tr height="30" bgcolor="#FFFFFF">
						<td width="146" align="right" class="blackbold">邮政编码：</td>
						<td><s:property value="member.zip"/></td>							
					  </tr>
					  <tr height="30" bgcolor="#F7F3F7">
						<td width="146" align="right" class="blackbold">下单日期：</td>
						<td><s:property value="@com.eportal.util.Tools@formatDate(#request.orderDate)"/></td>							
					  </tr>
					  <tr height="30" bgcolor="#FFFFFF">
						<td width="146" align="right" class="blackbold">订单状态：</td>
						<td>
							<s:if test="orderStatus==1">已下单,未受理</s:if>
							<s:elseif test="orderStatus==2">已受理,未处理</s:elseif>
							<s:elseif test="orderStatus==3">已处理,未结单</s:elseif>
							<s:elseif test="orderStatus==4">已结单</s:elseif>							
						</td>							
					  </tr>					  					  
					  <tr height="50">
						<td colspan="2" class="titleText" align="center">订单商品清单</td>		
					  </tr>					    					  
					</table>
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
					  <tr>
						<td></td>
					  </tr>
					  <tr>
						<td align="center">
							<table cellspacing="1" cellpadding="0" width="94%" border="0" bgcolor="#F7F3F7">
							  <tr height="30" class="blackbold" align="center">
								<td>商品名称</td>
								<td>市场价</td>
								<td>会员价</td>
								<td>数量</td>
								<td>金额</td>
							  </tr>
							  <s:iterator value="selList" id="row" status="st">
							  	<s:if test="#st.odd"><!-- 奇数行,背景为白色 -->
							  		<tr class="text" align="center" bgcolor="#FFFFFF" height="30">
							  	</s:if>
							  	<s:else><!-- 偶数行,背景为浅灰色 -->
							  		<tr class="text" align="center" bgcolor="#F7F3F7" height="30">
							  	</s:else>
									<td>
										&nbsp;<a href="<%=basepath%>${row.merchandise.htmlPath}" target="_blank"> 
										  <span class="blueText">${row.merchandise.merName}</span>
										</a>							</td>
									<td><s:property value="@com.eportal.util.Tools@formatCcurrency(#row.merchandise.price)"/></td>
									<td><s:property value="@com.eportal.util.Tools@formatCcurrency(#row.price)"/></td>
									<td><s:property value="#row.number"/></td>
									<td><s:property value="@com.eportal.util.Tools@formatCcurrency(#row.money)"/></td>
								  </tr>						  	
							  </s:iterator>							  						  						  
							  <tr align="center" height="30">
								<td colspan="5" class="blackbold"><img hspace="5" src="<%=basepath%>/images/me03.gif" align="absmiddle" /> 
									订单总金额:<s:property value="@com.eportal.util.Tools@formatCcurrency(#request.cart.money)"/>(不包括配送费用)							</td>
							  </tr>		
							</table>
						</td>
					  </tr>
					  <tr align="center">
						<td><br/>
							<img style="cursor:pointer" onClick="window.location='loadAllOrders.action';" src="<%=basepath%>/images/return.gif"  border="0"/></td>
					  </tr>
					</table>
				</s:else>				
			</div>
		</div>
	</div>
<!-- 栏间留空 -->	
	<div class="split"></div>	
<!-- 页脚区 -->			
	<%@include file="../common/foot.jsp"%>						
</div>
</body>
</html>
