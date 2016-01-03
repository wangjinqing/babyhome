<%@ page contentType="text/html; charset=gbk"%>
<%@ taglib prefix="e" uri="/eportal"%> 
<%@include file="../common/admin_head.jsp"%>
<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title><s:text name="admin_title"/></title>
<ss:head/>
<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
<link href="<%=basepath%>/css/admin.css" rel="stylesheet" type="text/css" />
</head>
<body>
<center>
	<div class="titleText"><s:text name="mer_edit"/></div>
	<div class="formDiv">
	  <s:form action="updateMerchandise" enctype="multipart/form-data">
		<table width="100%" align="center" border="0" cellspacing="0" cellpadding="0">		
		  <tr>
		    <td width="60"><s:text name="mer_label_cate"/>:</td>
		    <td  class="doubselect">
		    	<s:doubleselect list="doubleSelectNodes" listKey="value" listValue="name" doubleList="subNodes"  doubleListKey="value" doubleListValue="name" doubleName="category2" doubleId="category2" name="category1" id="category1" value="category1" doubleValue="category2"/>
		    </td>
		    <td width="60"><s:text name="mer_label_name"/>:</td>
		    <td><s:textfield name="merName" size="44"/>&nbsp;<span class="redText">*</span></td>		    
		  </tr>		
		  <tr>
		    <td><s:text name="mer_label_model"/>:</td>
		    <td><s:textfield name="merModel" size="44"/>&nbsp;<span class="redText">*</span></td>
		    <td><s:text name="mer_label_price"/>:</td>
		    <td><s:textfield name="price" size="44"/>&nbsp;<span class="redText">*</span></td>
		  </tr>
		  <tr>
		    <td><s:text name="mer_label_special"/>:</td>
		    <td>
		    	<s:if test="special!=null">
		    		<s:radio name="special" list="#{'0':'否','1':'是'}" listKey="key" listValue="value" onclick="hideShowSprice(this.value)"/>
			    	<s:if test="special==1">
				    	<span id="spriceSpan" style="display:inline;">
			    			<s:text name="mer_label_sprice"/>:				    		
				    		<s:textfield name="sprice" size="23"/>
				    	</span>
			    	</s:if>
			    	<s:else>
				    	<span id="spriceSpan" style="display:none;">
				    		<s:text name="mer_label_sprice"/>:
				    		<s:textfield name="sprice" size="23"/>
				    	</span>		    	
			    	</s:else>		    		
		    	</s:if>
		    	<s:else>
		    		<s:radio name="special" list="#{'0':'否','1':'是'}" listKey="key" listValue="value" value="0" onclick="hideShowSprice(this.value)"/>
			    	<span id="spriceSpan" style="display:none;">
			    		<s:text name="mer_label_sprice"/>:
			    		<s:textfield name="sprice" size="23"/>
			    	</span>			    	
		    	</s:else>	
			</td>
		    <td><s:text name="mer_label_manufacturer"/>:</td>
		    <td>
			    <s:textfield name="manufacturer" size="24"/>
			    <s:text name="mer_label_date"/>:
			    <ss:datetimepicker name="leaveFactoryDate" toggleType="explode" type="date" displayFormat="yyyy-MM-dd"/>
		    </td>
		  </tr>		  
		  <tr>
		    <td><s:text name="mer_label_picture"/>:</td>
		    <td><s:file name="pic" size="35"/></td>
		    <td><s:text name="mer_label_video"/>:</td>
		    <td colspan="3"><s:file name="vd" size="37"/></td>		    
		  </tr>
		  <tr>
		    <td valign="top"><s:text name="mer_label_desc"/>:</td>
		    <td colspan="3" height="500">
				<s:if test="merDesc!=null">
					<s:set name="contentvalue" value="@com.eportal.util.Tools@unescape(#request.merDesc)"/>
				</s:if>
				<textarea cols="80" id="merDesc" name="merDesc" rows="10">
					${contentvalue}
				</textarea>
				<script type="text/javascript">
					CKEDITOR.replace('merDesc',{				
						filebrowserImageUploadUrl : './uploadCKeditor.action?type=image',//图片上传组件路径
						filebrowserFlashUploadUrl : './uploadCKeditor.action?type=flash' //Flash上传组件路径
					});
				</script>							    
			</td>
		  </tr>
		</table>
		<br>
		  <div align="center">
			<s:submit key="label_submit"/>&nbsp;
			<s:reset key="label_reset"/>&nbsp;
			<s:set name="label_return" value="%{getText('label_return')}"/>
		    <input type="button" name="btn_ret" value="${label_return}" onClick="window.location='mer_browseMerchandise.action';">
		  	<s:hidden name="id"/>
		  </div>
		</s:form>	
	</div>
</center>
<br/><br/>
<s:if test="hasFieldErrors()">
	<e:msgdialog basepath="<%=basepath%>">
		<s:fielderror/>
	</e:msgdialog>
</s:if>
<s:if test="hasActionMessages()">
	<e:msgdialog basepath="<%=basepath%>">
		<s:actionmessage/>
	</e:msgdialog>
</s:if>
<script language="javascript">
	function hideShowSprice(v){
		if (v==1){
			document.all.spriceSpan.style.display="inline";
		}else{
			document.all.spriceSpan.style.display="none";
		}
	}
</script>	
</body>
</html>
