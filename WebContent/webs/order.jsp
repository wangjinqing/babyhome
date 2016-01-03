<%@ page contentType="text/html; charset=gbk"%>
<%@include file="../common/web_head.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"  xml:lang="zh-CN" lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>订单管理-<s:text name="website_name"/></title>
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
			您现在的位置：<a href="<%=basepath%>/webs/index.jsp">首页</a> >> 订单管理
		</div>
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
<!-- 订单管理区 -->	
		<div class="cart">
			<div class="mer_head_left"></div>
			<div class="mer_head_text"><h2>订单管理</h2></div>
			<div class="mer_head_main"></div>
			<div class="mer_head_right"></div>
			<div class="order_body">
				<s:if test="#session.member==null">
					<center>
						<br/><img hspace="5" src="<%=basepath%>/images/sorry.gif" />
						<br/><span class="errorMessage"><s:text name="orders_add_notlogin"/></span>					
					</center>
				</s:if>
				<s:else>
					<br/>
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
					  <tr>
						<td></td>
					  </tr>
					  <tr>
						<td align="center">
							<table cellspacing="1" cellpadding="0" width="94%" border="0" bgcolor="#F7F3F7">
							  <tr height="26" class="blackbold" align="center">
								<td>订单编号</td>
								<td>订单金额</td>
								<td>下单日期</td>
								<td>订单状态</td>
								<td>查看</td>
								<td>结单</td>
								<td>撤单</td>
							  </tr>							  
							  <s:iterator value="ordersList" id="row" status="st">
							  	<s:if test="#st.odd"><!-- 奇数行,背景为白色 -->
							  		<tr class="text" align="center" bgcolor="#FFFFFF">
							  	</s:if>
							  	<s:else><!-- 偶数行,背景为浅灰色 -->
							  		<tr class="text" align="center" bgcolor="#F7F3F7">
							  	</s:else>
									<td>&nbsp;${row.orderNo}</td>
									<td><s:property value="@com.eportal.util.Tools@formatCcurrency(#row.cart.money)"/></td>
									<td><s:property value="@com.eportal.util.Tools@formatDate(#row.orderDate)"/></td>
									<td>
										<s:if test="#row.orderStatus==1">已下单,未受理</s:if>
										<s:elseif test="#row.orderStatus==2">已受理,未处理</s:elseif>
										<s:elseif test="#row.orderStatus==3">已处理,未结单</s:elseif>
										<s:elseif test="#row.orderStatus==4">已结单</s:elseif>										
									</td>
									<td><img style="cursor:pointer" onClick="window.location='viewOrders.action?id=${id}';" src="<%=basepath%>/images/view.gif" border="0"/></td>
									<td>
										<s:if test="#row.orderStatus==3">
											<img style="cursor:pointer" onClick="window.location='updateOrdersStatus.action?id=${id}&orderStatus=4';" src="<%=basepath%>/images/edit.gif" border="0"/>
										</s:if>
										<s:else><img src="<%=basepath%>/images/edit1.gif" border="0"/></s:else>
									</td>									
									<td>
										<s:if test="#row.orderStatus==1">
											<img style="cursor:pointer" onClick="window.location='delOrders.action?id=${id}';" src="<%=basepath%>/images/delete_01.gif" border="0"/>
										</s:if>
										<s:else><img src="<%=basepath%>/images/delete_02.gif" border="0"/></s:else>
									</td>
								  </tr>
							  </s:iterator>
							  <s:if test="ordersList==null || ordersList.size<1">
								  <tr height="26" class="blackbold" align="center" bgcolor="#FFFFFF">
									<td colspan="7" class="redtext" align="left">&nbsp;对不起,您目前没有订单存在!</td>
								  </tr>							  	
							  </s:if>							  	
							</table>
						</td>
					  </tr>
					</table>					
				</s:else>
			</div>
		</div>
<!-- 最新商品区 -->	
		<div class="mer">
			<div class="mer_head_left"></div>
			<div class="mer_head_text"><h2>最新上架</h2></div>
			<div class="mer_head_main"></div>
			<div class="mer_head_right"></div>
			<div class="mer_body">
				<!-- 使用自定义商品列表标签 -->
				<e:merlist baseurl="<%=basepath%>" size="10" listtype="1" picWidth="120"/> 
			</div>
		</div>
	</div>		
<!-- 栏间留空 -->	
	<div class="split"></div>	
<!-- 页脚区 -->			
	<%@include file="../common/foot.jsp"%>						
</div>
<!-- 输出提示信息 -->
<s:if test="hasActionMessages()">
	<!-- 使用自定义带遮罩网页对话框标签 -->
	<e:msgdialog basepath="<%=basepath%>" height="1020" top="140">
		<s:actionmessage/>
	</e:msgdialog>
</s:if>					
</body>
</html>
