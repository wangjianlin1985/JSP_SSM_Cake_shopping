<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/recipel.css" />
<div id="recipel_editDiv">
	<form id="recipelEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">个性DIY制作id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="recipel_recipelId_edit" name="recipel.recipelId" value="<%=request.getParameter("recipelId") %>" style="width:200px" />
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
				<input class="textbox" type="text" id="recipel_handState_edit" name="recipel.handState" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">上传时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="recipel_addTime_edit" name="recipel.addTime" />

			</span>

		</div>
		<div class="operation">
			<a id="recipelModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Recipel/js/recipel_modify.js"></script> 
