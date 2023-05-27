<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/recipel.css" /> 

<div id="recipel_manage"></div>
<div id="recipel_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="recipel_manage_tool.edit();">个性DIY制作处理</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="recipel_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="recipel_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="recipel_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="recipel_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="recipelQueryForm" method="post">
			上传用户：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			处理状态：<input type="text" class="textbox" id="handState" name="handState" style="width:110px" />
			上传时间：<input type="text" id="addTime" name="addTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="recipel_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="recipelEditDiv">
	<form id="recipelEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">个性DIY制作id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="recipel_recipelId_edit" name="recipel.recipelId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">个性DIY制作照片:</span>
			<span class="inputControl">
				<img id="recipel_recipelPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="recipel_recipelPhoto" name="recipel.recipelPhoto"/>
				<input id="recipelPhotoFile" name="recipelPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">上传用户:</span>
			<span class="inputControl">
				<input class="textbox"  id="recipel_userObj_user_name_edit" name="recipel.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">个性DIY制作备注:</span>
			<span class="inputControl">
				<textarea id="recipel_recipelMemo_edit" name="recipel.recipelMemo" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">处理状态:</span>
			<span class="inputControl">
				<select id="recipel_handState_edit" name="recipel.handState"> 
					<option value="待处理">待处理</option>
					<option value="已处理">已处理</option>
				</select>
			</span>

		</div>
		<div>
			<span class="label">上传时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="recipel_addTime_edit" name="recipel.addTime" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Recipel/js/recipel_manage.js"></script> 
