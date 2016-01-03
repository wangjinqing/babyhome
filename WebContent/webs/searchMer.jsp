<%@ page contentType="text/html; charset=gbk"%>
<%@include file="../common/web_head.jsp"%>
<%@page import="com.eportal.util.Tools"%>
<%
	int pageNo=1;
	//分页控制
	if (request.getParameter("pageNo")!=null){
		pageNo = Integer.parseInt(request.getParameter("pageNo"));
	}
	//搜索类别
	String searchtype="newmer";
	int listtype = 1;//1-最新商品列表,2-促销商品列表,默认值为1	
	session.setAttribute("searchtype","newmer");//在session中设置当前搜索类型为“所有商品搜索”
	if (request.getParameter("searchtype")!=null){
		searchtype = request.getParameter("searchtype");
		if (searchtype.equals("prommer")){
			listtype = 2;
			session.setAttribute("searchtype","prommer");//在session中设置当前搜索类型为“促销商品搜索”
		}
	}		
	//搜索关键字
	String keyword="";
	String decodeKeyword="";
	if (request.getParameter("keyword")!=null){
		keyword = request.getParameter("keyword");
		decodeKeyword=new String(keyword.getBytes("ISO8859-1"),"UTF-8");
		keyword = java.net.URLEncoder.encode(decodeKeyword,"UTF-8");
	}
	session.setAttribute("keyword",decodeKeyword);//在session中保存当前搜索关键字内容
	//构造供分页标签使用的URL
	String url=basepath+"/webs/searchMer.jsp?searchtype="+searchtype+"&keyword="+keyword;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"  xml:lang="zh-CN" lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>商品搜索结果-<s:text name="website_name"/></title>
<base target="_blank" />
<meta name="Keywords" content="电子商务,电子商城,在线购物,网上购物" />
<meta name="Description" content="电子商务门户ePortal免费提供电子商城在线购物、商品展示、订单管理、商讯搜索等常见的电子商务功能!" />
<meta name="robots" content="index, follow" />
<meta name="googlebot" content="index, follow" />
<link href="<%=basepath%>/css/style.css" rel="stylesheet" type="text/css" />
<script language='javascript'>
	//选购商品
	function buy(merid){
		<s:if test="#session.member==null">
			alert('对不起,您尚未登录,请先登录后再选购商品,谢谢合作!');
		</s:if>
		<s:else>
			window.location='addToCart.action?merId='+merid;
		</s:else>			
	}    	
</script>
</head>

<body>&nbsp; 
<!--DIV页面主容器-->
<div class="container">
<%@include file="../common/menubar.jsp"%>	
<!-- 栏间留空 -->	
	<div class="split"></div>
<!--位置导航区-->	
	<div class="nav">
		<div class="nav_left"></div>
		<div class="nav_main">
			您现在的位置：<a href="<%=basepath%>/webs/index.jsp">首页</a> >> 商品搜索
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
<!-- 最新商品区 -->	
		<div class="merlist">
			<div class="mer_head_left"></div>
			<div class="mer_head_text"><h2>商品搜索结果</h2></div>
			<div class="mer_head_main" style="line-height:26px;">商品名称、商品型号及商品描述中包含关键字“<span class="redtext"><%=decodeKeyword%></span>”的商品列表</div>
			<div class="mer_head_right"></div>
			<div class="merlist_body">
				<!-- 使用自定义商品搜索标签 -->
				<e:searchmer listtype="<%=listtype%>" baseurl="<%=basepath%>" pageNo="<%=pageNo%>" keyword="<%=decodeKeyword%>"/>
				<div class="page_ctrl">
					<!-- 使用自定义商品搜索分页控制标签 -->
					<e:searchmerpage listtype="<%=listtype%>" url="<%=url%>" pageNo="<%=pageNo%>" keyword="<%=decodeKeyword%>"/>
				</div>
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
