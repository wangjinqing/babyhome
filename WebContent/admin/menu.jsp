<%@page contentType="text/html; charset=gbk"%>
<%@include file="../common/admin_head.jsp"%>
<html>
<head>
<title><s:text name="admin_title"/></title>
<ss:head/>
<link href="<%=basepath%>/css/admin.css" rel="stylesheet" type="text/css" />
 <script language="JavaScript" type="text/javascript">
 	var url = "#";
 	var root;
 	
	//响应菜单单击事件
	function treeNodeSelected(arg) {
		var node = dojo.widget.byId(arg.source.widgetId);
		if(node.isFolder){
			if(dojo.widget.byId(arg.source.widgetId).isExpanded){
				dojo.widget.byId(arg.source.widgetId).collapse();
			}else{
				dojo.widget.byId(arg.source.widgetId).expand();
			}		
		}else{
			processSelected(arg.source.widgetId);
		}
	}
	
	//处理菜单导航
	function processSelected(menuid){
		var tmp = (new Date()).getTime();
		if (menuid=='column'){
			url = "/admin/columns_browseColumns.action";
		}else if (menuid=='news'){
			url = "/admin/news_browseNews.action";
		}else if (menuid=='crawl'){
			url = "/admin/rule_browseNewsrule.action";
		}else if (menuid=='memeberLevel'){
			url = "/admin/level_browseMemberlevel.action";
		}else if (menuid=='memeber'){
			url = "/admin/member_browseMember.action";
		}else if (menuid=='cate'){
			url = "/admin/cate_browseCategory.action";
		}else if (menuid=='mer'){
			url = "/admin/mer_browseMerchandise.action";
		}else if (menuid=='mer_pdf'){
			url = "/report/merReport.action?format=PDF";
		}else if (menuid=='mer_xls'){
			url = "/report/merReport.action?format=XLS";
		}else if (menuid=='mer_html'){
			url = "/report/merReport.action?format=HTML";
		}else if (menuid=='order'){
			url = "/admin/orders_browseOrders.action";		
		}else if (menuid=='ip'){
			url = "/admin/browseIP_index.jsp";		
		}else if (menuid=='pv'){
			url = "/admin/browsePV_index.jsp";	
		}else if (menuid=='admin'){
			url = "/admin/admin_browseAdmin.action";	
		}else if (menuid=='exit'){
			url = "/admin/admin_logout.action";	
		}
		//添加临时参数,标识这是一次全新的请求
		if (url.indexOf("?")!=-1){
			url = "<%=basepath%>"+url+"&tmp="+tmp;
		}else{
			url = "<%=basepath%>"+url+"?tmp="+tmp;
		}
		if (menuid=='exit'){
			window.parent.location=url;
		}else{
			window.parent.mainFrame.location=url;
		}		
	}
	
	//响应菜单展开事件
	function treeNodeExpanded(arg) {
	    alert('id['+arg.source.widgetId+'], name['+ arg.source.title+ '] expanded');
	}
	
	//响应菜单收缩事件
	function treeNodeCollapsed(arg) {
	    alert('id['+arg.source.widgetId+'], name['+ arg.source.title+ '] collapsed');
	}
	
	//注册菜单事件处理
	dojo.addOnLoad(function(){
	    root = dojo.widget.byId('adminctrl');
	    dojo.event.topic.subscribe(root.eventNames.titleClick, treeNodeSelected);
	});
	
	//展开所有菜单项
	function expandAll(){
       for(var i=0; i<root.children.length; i++) {
          var child = root.children[i];
          dojo.lang.forEach(child.getDescendants(),function(node) {node.expand(); });
       }
	}
</script>
</head>
<body style="padding:10px;">
<ss:tree label="<b>山民山货网后台管理</b>" id="adminctrl" showRootGrid="true" showGrid="true">
    <ss:treenode label="<img src='../images/icon_newscolumn.gif'/>新闻管理" id="news_column">
        <ss:treenode label="<img src='../images/icon_column.gif'/>新闻栏目管理" id="column"/>
        <ss:treenode label="<img src='../images/icon_news.gif'/>新闻管理" id="news"/>
    </ss:treenode>
    <ss:treenode label="<img src='../images/icon_crawl.gif'/>新闻采集" id="crawl"/>
    <ss:treenode label="<img src='../images/icon_member.gif'/>会员管理" id="memeber_level">
    	<ss:treenode label="<img src='../images/icon_level.gif'/>会员级别管理" id="memeberLevel"/>
    	<ss:treenode label="<img src='../images/icon_member.gif'/>会员管理" id="memeber"/>    
    </ss:treenode>
    <ss:treenode label="<img src='../images/icon_catemer.gif'/>商品管理" id="cate_mer">
        <ss:treenode label="<img src='../images/icon_cate.gif'/>商品分类" id="cate"/>
        <ss:treenode label="<img src='../images/icon_mer.gif'/>商品管理" id="mer"/>
        <%--<ss:treenode label="<img src='../images/pdf.gif'/>库存商品PDF报表" id="mer_pdf"/>
        <ss:treenode label="<img src='../images/xls.gif'/>库存商品Excel报表" id="mer_xls"/>
        <ss:treenode label="<img src='../images/htm.gif'/>库存商品HTML报表" id="mer_html"/>                        
    --%></ss:treenode>
    <ss:treenode label="<img src='../images/icon_order.gif'/>订单管理" id="order"/>
    <ss:treenode label="<img src='../images/icon_trafic.gif'/>流量统计" id="ip_pv">
        <ss:treenode label="<img src='../images/icon_ip.gif'/>IP统计" id="ip"/>
        <ss:treenode label="<img src='../images/icon_pv.gif'/>PV统计" id="pv"/>
    </ss:treenode>    
    <ss:treenode label="<img src='../images/icon_admin.gif'/>系统用户管理" id="admin"/>
    <ss:treenode label="<img src='../images/icon_exit.gif'/>安全退出" id="exit"/>    
</ss:tree>
<br/>
</body>
<script type="text/javascript">
	//展开所有菜单项
	window.setTimeout("expandAll();",2000);
</script>
</html>