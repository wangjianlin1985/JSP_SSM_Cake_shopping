<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/recharge.css" /> 

<div id="recharge_manage"></div>
<div id="recharge_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="recharge_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="recharge_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="recharge_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="recharge_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="recharge_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="rechargeQueryForm" method="post">
			充值用户：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			充值时间：<input type="text" id="rechargeTime" name="rechargeTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="recharge_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="rechargeEditDiv">
	<form id="rechargeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">充值id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="recharge_rechargeId_edit" name="recharge.rechargeId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">充值用户:</span>
			<span class="inputControl">
				<input class="textbox"  id="recharge_userObj_user_name_edit" name="recharge.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">充值金额:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="recharge_rechargeMoney_edit" name="recharge.rechargeMoney" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">充值备注:</span>
			<span class="inputControl">
				<textarea id="recharge_rechargeMemo_edit" name="recharge.rechargeMemo" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">充值时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="recharge_rechargeTime_edit" name="recharge.rechargeTime" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Recharge/js/recharge_manage.js"></script> 
