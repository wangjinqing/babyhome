<%@ page contentType="text/html; charset=gbk"%>
<%@include file="../common/web_head.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"  xml:lang="zh-CN" lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>${title}-<s:text name="website_name"/></title>
<base target="_blank" />
<meta name="Keywords" content='${keyWords}' />
<meta name="Description" content='${abstract_}' />
<meta name="robots" content="index, follow" />
<meta name="googlebot" content="index, follow" />
<link href="<%=basepath%>/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=basepath%>/js/json.js"></script>
<script type="text/javascript" src="<%=basepath%>/js/prototype-1.4.0.js"></script>
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
			您现在的位置：<a href="<%=basepath%>/webs/index.jsp">首页</a> >> <a href="<%=basepath%>/webs/news.jsp">商城快讯</a> >> 新闻内容
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
		<div class="newsinfo">
			<div class="newsinfo_title">
				<h1>${title}</h1>
				作者：${author}&nbsp;&nbsp;
				来源：${from}&nbsp;&nbsp;
				日期：<s:property value="@com.eportal.util.Tools@formatDate(#request.cdate)"/>&nbsp;&nbsp;
				点击数：<span id="clickcount"></span><br/>
			</div>
			<div id="newsinfo_body">	
				<s:if test="picture!=null">
					<center><img src='<%=basepath%>/${picture}'/></center><br/>		
				</s:if>
				<s:set name="pages" value="@com.eportal.util.Tools@splitContent(#request.content)"/>
				<s:iterator value="pages" id="page" status="st">
					<s:set name="spanid" value="%{'page'+#st.count}"/>
					<s:if test="#st.count==1">
						<span id='${spanid}'>
							<s:property escape="false" value="page"/>
						</span>							
					</s:if>
					<s:else>
						<span id='${spanid}' style="display:none">
							<s:property escape="false" value="page"/>
						</span>						
					</s:else>
				</s:iterator>
			</div>
			<s:if test="#pages.length>1">
				<!-- 新闻内容分页控制 -->	
				<div class="newsinfo_page">[<span class="newsinfo_page_ctl" onclick="firstPage()">首页</span>]&nbsp;&nbsp;[<span class="newsinfo_page_ctl" onclick="prevPage()">上一页</span>]&nbsp;&nbsp;[<span class="newsinfo_page_ctl" onclick="nextPage()">下一页</span>]&nbsp;&nbsp;[<span class="newsinfo_page_ctl" onclick="endPage()">末页</span>]</div>
				<script language="javascript">
					//总页数
					var pageCount = <s:property value="#pages.length"/>;
					//当前页号
					var currentPageNo=1;
					//显示指定页的内容
					function goPage(pageno){
						for(var i=1;i<=pageCount;i++){
							if (i==pageno){
								document.getElementById("page"+i).style.display="inline";
							}else{
								document.getElementById("page"+i).style.display="none";
							}
						}
					}
					//首页
					function firstPage(){
						currentPageNo=1;
						goPage(currentPageNo);
					}
					//末页
					function endPage(){
						currentPageNo=pageCount;
						goPage(currentPageNo);
					}
					//上一页
					function prevPage(){
						if (currentPageNo>1)currentPageNo=currentPageNo-1;
						goPage(currentPageNo);
					}
					//下一页
					function nextPage(){
						if (currentPageNo<pageCount)currentPageNo=currentPageNo+1;
						goPage(currentPageNo);
					}			
				</script>									
			</s:if>
			<div class="about_news">
				<div class="about_news_tile"><h2>相关新闻</h2></div>
				<e:aboutnews keywords="${keyWords}" currentId="${id}" number="6" prex="0" titlelen="16" baseurl="<%=basepath%>"/>
			</div>
		</div>
	</div>		
<!-- 栏间留空 -->	
	<div class="split"></div>	
<%@include file="../common/foot.jsp"%>
</div>
<!-- 使用JS组件Prototype配合JSON插件实现异步点击数加一 -->
<script language="JavaScript">
	//定义异步调用action的函数
	function incClicks(){
		//访问点击数加一的incNewsClicks.action
		var url = '../ajax/incNewsClicks.action';
		//构造请求参数，此处加入tmp参数是为了让服务器知道这是一个新的请求
		var params = 'id=${id}&tmp='+(new Date()).getTime();
		//创建Ajax.Request对象，用于发送异步请求
		var myAjax = new Ajax.Request(
		url,
		{
			//请求方式：get
			method:'get',
			//请求参数
			parameters:params,
			//指定回调函数
			onComplete: processResponse,
			//是否异步发送请求
			asynchronous:true
		});
	}
	//定义异步响应结果的处理函数
    function processResponse(request){    	
    	var obj = JSON.parse(request.responseText);
    	//将加一后的点击数放入clickcount中显示出来
		$("clickcount").innerHTML = obj.jsonClicks;
	}
	//调用incClicks()函数实现点击数加一
	incClicks();	
</script>
</body>	
</html>
