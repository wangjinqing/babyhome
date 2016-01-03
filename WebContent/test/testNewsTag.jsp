<%@ page contentType="text/html; charset=gbk"%>
<%@include file="../common/web_head.jsp"%>
<%@ taglib prefix="e" uri="/eportal"%>
<html>
<head>
<title>自定义文本新闻列表标签测试页面</title>
<style type="text/css">
	*{font-family:"宋体",arial;margin:0;padding:0;font-size:14px;color:#000;line-height:24px;}
	body{margin:20px;}
	li{list-style-type:none; vertical-align:middle;}
	img{vertical-align:middle;border:0;}
	ul{clear:both;}
	a:link,a:visited{color:#00f;text-decoration:none;}
	a:hover{color:#F00;text-decoration:underline;}
	a:active{color:#00f;}	
	.container1{width:520px;text-align:center; padding:0;}
	.container1 a{color:#000;font-family:黑体;font-weight:500;font-size:18px;line-height:30px;}	
	.container2{width:520px;text-align:left; padding:0;}
	.container2 li{width:50%; float:left; text-align:left; margin:0;}
	.container2 a{text-decoration:none;}
	.container3{width:300px;}
	.container3 a{text-decoration:underline;}
	.container4{width:300px;}
	.container4 li{height:24px;line-height:24px;}
	.container4 img{margin-right:6px;}
	.container5{width:600px;}
	.container5 li{width:50%; float:left;height:24px;line-height:24px;}
	.container5 img{margin-right:6px;}
	.container6{width:440px;}
	.container6 a{text-decoration:none;}	
	.container6 li{border-bottom:1px dashed gray;height:24px;line-height:24px;}
	.newslist_title{width:300px;float:left;}	
	.newslist_date{width:140px;float:left;text-align:right;}
	.container7{width:280px;}
	.container7 li{width:50%; float:left; text-align:left; margin:0;}
	.container7 a{font-size:12px;text-decoration:underline;}				
</style>
</head>
<body>
<!-- 头条文本新闻 -->
<div class="container1">
	<e:textnews section="SCKX" newstype="1" number="1" split="0" titlelen="15" baseurl="<%=basepath%>"/> 	
</div>
<!-- 最新文本新闻 -->
<div class="container2">
	<e:textnews section="SCKX" newstype="0" number="8" prex="0" split="1" titlelen="15" baseurl="<%=basepath%>"/> 
</div><hr/>
<div class="container3">
	<e:textnews section="SCKX" newstype="0" number="8" prex="0" titlelen="18" baseurl="<%=basepath%>"/> 
</div><hr/>
<div class="container4">
	<e:textnews section="SCKX" newstype="0" number="8" prex="../images/prex_.jpg" titlelen="18" baseurl="<%=basepath%>"/> 
</div><hr/>
<div class="container5">
	<e:textnews section="SCKX" newstype="0" number="8" prex="../images/prex_.jpg" titlelen="18" baseurl="<%=basepath%>"/> 
</div><hr/>
<div class="container4">
	<e:textnews section="SCKX" newstype="0" number="8" prex="../images/hotnews.gif" titlelen="18" baseurl="<%=basepath%>"/> 
</div><hr/>
<div class="container5">
	<e:textnews section="SCKX" newstype="0" number="8" prex="../images/hotnews.gif" titlelen="18" baseurl="<%=basepath%>"/> 
</div><hr/>
<div class="container6">
	<e:textnews section="SCKX" newstype="0" number="8" prex="0" titlelen="20" baseurl="<%=basepath%>" dateFormat="yyyy-MM-dd"/> 
</div><hr/>
<!-- 最新图片新闻 -->
<div class="container7">
	<e:picnews section="SCKX" newstype="0" hastitle="1" number="2" titlelen="10" width="100" height="80" baseurl="<%=basepath%>"/> 
</div><hr/>
<div class="container7">
	<e:picnews section="SCKX" newstype="0" hastitle="0" number="2" titlelen="10" width="100" height="80" baseurl="<%=basepath%>"/> 
</div><hr/>
<div class="container3">
	<e:picnews section="SCKX" newstype="0" hastitle="1" number="2" titlelen="15" width="150" height="100" baseurl="<%=basepath%>"/> 
</div><hr/>
<!-- 幻灯新闻 -->
<div class="container3">
	<e:slidenews section="SCKX" number="5" titlelen="17" width="240" height="180" baseurl="<%=basepath%>" slideno="1"/> 
</div><hr/>
<div class="container3">
	<e:slidenews section="SCKX" number="6" titlelen="20" width="300" height="200" baseurl="<%=basepath%>" slideno="2"/> 
</div><hr/>
<!-- 相关新闻 -->
与"中国"相关的新闻列表:<br/>
<div class="container2">
	<e:aboutnews keywords="中国" currentId="1" number="10" prex="0" titlelen="16" baseurl="<%=basepath%>"/> 
</div>
</body>
</html>