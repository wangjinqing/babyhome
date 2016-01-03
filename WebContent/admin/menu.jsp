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
 	
	//��Ӧ�˵������¼�
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
	
	//����˵�����
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
		//�����ʱ����,��ʶ����һ��ȫ�µ�����
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
	
	//��Ӧ�˵�չ���¼�
	function treeNodeExpanded(arg) {
	    alert('id['+arg.source.widgetId+'], name['+ arg.source.title+ '] expanded');
	}
	
	//��Ӧ�˵������¼�
	function treeNodeCollapsed(arg) {
	    alert('id['+arg.source.widgetId+'], name['+ arg.source.title+ '] collapsed');
	}
	
	//ע��˵��¼�����
	dojo.addOnLoad(function(){
	    root = dojo.widget.byId('adminctrl');
	    dojo.event.topic.subscribe(root.eventNames.titleClick, treeNodeSelected);
	});
	
	//չ�����в˵���
	function expandAll(){
       for(var i=0; i<root.children.length; i++) {
          var child = root.children[i];
          dojo.lang.forEach(child.getDescendants(),function(node) {node.expand(); });
       }
	}
</script>
</head>
<body style="padding:10px;">
<ss:tree label="<b>ɽ��ɽ������̨����</b>" id="adminctrl" showRootGrid="true" showGrid="true">
    <ss:treenode label="<img src='../images/icon_newscolumn.gif'/>���Ź���" id="news_column">
        <ss:treenode label="<img src='../images/icon_column.gif'/>������Ŀ����" id="column"/>
        <ss:treenode label="<img src='../images/icon_news.gif'/>���Ź���" id="news"/>
    </ss:treenode>
    <ss:treenode label="<img src='../images/icon_crawl.gif'/>���Ųɼ�" id="crawl"/>
    <ss:treenode label="<img src='../images/icon_member.gif'/>��Ա����" id="memeber_level">
    	<ss:treenode label="<img src='../images/icon_level.gif'/>��Ա�������" id="memeberLevel"/>
    	<ss:treenode label="<img src='../images/icon_member.gif'/>��Ա����" id="memeber"/>    
    </ss:treenode>
    <ss:treenode label="<img src='../images/icon_catemer.gif'/>��Ʒ����" id="cate_mer">
        <ss:treenode label="<img src='../images/icon_cate.gif'/>��Ʒ����" id="cate"/>
        <ss:treenode label="<img src='../images/icon_mer.gif'/>��Ʒ����" id="mer"/>
        <%--<ss:treenode label="<img src='../images/pdf.gif'/>�����ƷPDF����" id="mer_pdf"/>
        <ss:treenode label="<img src='../images/xls.gif'/>�����ƷExcel����" id="mer_xls"/>
        <ss:treenode label="<img src='../images/htm.gif'/>�����ƷHTML����" id="mer_html"/>                        
    --%></ss:treenode>
    <ss:treenode label="<img src='../images/icon_order.gif'/>��������" id="order"/>
    <ss:treenode label="<img src='../images/icon_trafic.gif'/>����ͳ��" id="ip_pv">
        <ss:treenode label="<img src='../images/icon_ip.gif'/>IPͳ��" id="ip"/>
        <ss:treenode label="<img src='../images/icon_pv.gif'/>PVͳ��" id="pv"/>
    </ss:treenode>    
    <ss:treenode label="<img src='../images/icon_admin.gif'/>ϵͳ�û�����" id="admin"/>
    <ss:treenode label="<img src='../images/icon_exit.gif'/>��ȫ�˳�" id="exit"/>    
</ss:tree>
<br/>
</body>
<script type="text/javascript">
	//չ�����в˵���
	window.setTimeout("expandAll();",2000);
</script>
</html>