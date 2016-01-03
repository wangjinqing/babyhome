<%@ page contentType="text/html; charset=gbk"%>
<%@include file="common/web_head.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"  xml:lang="zh-CN" lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>首页-<s:text name="website_name"/></title>
<base target="_blank" />
<meta name="Keywords" content="电子商务,电子商城,在线购物,网上购物" />
<meta name="Description" content="电子商务门户ePortal免费提供电子商城在线购物、商品展示、订单管理、商讯搜索等常见的电子商务功能!" />
<meta name="robots" content="index, follow" />
<meta name="googlebot" content="index, follow" />
<link href="<%=basepath%>/css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<%@include file="common/navigatebar.jsp"%>	
<!--DIV页面主容器-->
<div class="container">
<%@include file="common/menubar.jsp"%>	
<!-- 栏间留空 -->	
	<div class="split"></div>
<!--位置导航区-->	
	<div class="nav" style="display: none;">
		<div class="nav_left"></div>
		<div class="nav_main">
			您现在的位置：首页
		</div>
		<div class="nav_now">
			<%@include file="common/jsdate.jsp"%>		
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
	   <!--导航菜单区-->
		<div class="menu">
			<ul>	
				<li><a target="_self" href="<%=basepath%>/index.jsp">首&nbsp;&nbsp;页</a></li>
				<li><a target="_self" href="<%=basepath%>/webs/newmer.jsp">新品上架</a></li>
				<li><a target="_self" href="<%=basepath%>/webs/prommer.jsp">促销商品</a></li>
				<li><a target="_self" href="<%=basepath%>/webs/video.jsp">视频购物</a></li>
				<li><a target="_self" href="<%=basepath%>/webs/viewCart.action">购物车管理</a></li>	
				<li><a target="_self" href="<%=basepath%>/webs/loadAllOrders.action">订单管理</a></li>
				<%--<li><a target="_self" href="<%=basepath%>/webs/news.jsp">商城快讯</a></li>
				<li><span onclick="editMember()">修改注册资料</span></li>--%>			
			</ul>	
		</div>
<!-- 幻灯新闻 -->	
		<div class="slide">
			<!-- 使用自定义幻灯新闻标签 -->
			<e:slidenews section="SCKX" number="5" titlelen="30" width="700" height="260" baseurl="<%=basepath%>" slideno="1"/> 
		</div>
<!-- 最新商城快讯区 -->	
		<%--<div class="news">
			<div class="news_head_left"></div>
			<div class="news_head_text"><h2>商城快讯</h2></div>
			<div class="news_head_main"></div>
			<div class="news_head_right"></div>
			<div class="news_body">
				--%><!-- 使用自定义文本新闻列表标签 -->
				<%--<e:textnews section="SCKX" newstype="0" number="9" prex="0" titlelen="16" baseurl="<%=basepath%>"/>		
			</div>
		</div>--%>
<!-- 栏间留空 -->	
		<div class="split"></div>
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
<%@include file="common/foot.jsp"%>
<!-- 输出表单提示信息 -->
<s:if test="hasActionErrors()">
	<!-- 使用自定义带遮罩网页对话框标签 -->
	<e:msgdialog basepath="<%=basepath%>" height="1020" top="140">
		<s:actionerror/>
	</e:msgdialog>
</s:if>				
</div>
</body>
</html>
