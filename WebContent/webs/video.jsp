<%@ page contentType="text/html; charset=gbk"%>
<%@include file="../common/web_head.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"  xml:lang="zh-CN" lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>视频购物-<s:text name="website_name"/></title>
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
			您现在的位置：<a href="<%=basepath%>/webs/index.jsp">首页</a> >> 视频购物
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
<!-- 视频播放区 -->	
		<div class="video">
			<div id="flvcontainer"><a href="http://www.macromedia.com/go/getflashplayer">请下载Flash播放器</a>播放该视频!</div>
			<script type="text/javascript" src="<%=basepath%>/js/swfobject.js"></script>
			<script type="text/javascript">
				var so = new SWFObject('<%=basepath%>/js/mediaplayer.swf','mpl','440','310','7');
				so.addParam('allowfullscreen','true');
				so.addParam('allowscriptaccess','sameDomain');
				so.addVariable('width','440');
				so.addVariable('height','310');
				so.addVariable('file','<%=basepath%>/images/test.flv');
				so.addVariable("image","<%=basepath%>/images/cover.jpg");
				so.write("flvcontainer");
				
				//播放指定的flv文件
				function playFlv(pic,flv){
					so.addVariable('file',flv);
					so.addVariable("image",pic);
					so.addVariable('autostart','true');
					so.write("flvcontainer");					
				}					
			</script>		
		</div>
<!-- 最新商城快讯区 -->	
		<div class="news">
			<div class="news_head_left"></div>
			<div class="news_head_text"><h2>商城快讯</h2></div>
			<div class="news_head_main"></div>
			<div class="news_head_right"></div>
			<div class="videonews_body">
				<!-- 使用自定义文本新闻列表标签 -->
				<e:textnews section="SCKX" newstype="0" number="10" prex="0" titlelen="16" baseurl="<%=basepath%>"/>				
			</div>
		</div>
<!-- 栏间留空 -->	
		<div class="split"></div>
<!-- 视频商品区 -->	
		<div class="videolist">
			<div class="mer_head_left"></div>
			<div class="mer_head_text"><h2>视频专区</h2></div>
			<div class="mer_head_main"></div>
			<div class="mer_head_right"></div>
			<div class="videolist_body">
				<!-- 使用自定义视频商品列表标签 -->
				<e:videolist baseurl="<%=basepath%>"/>								
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
