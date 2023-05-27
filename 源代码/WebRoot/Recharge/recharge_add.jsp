<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/recharge.css" />
<div id="rechargeAddDiv">
	<form id="rechargeAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">充值用户:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="recharge_userObj_user_name" name="recharge.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">充值金额:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="recharge_rechargeMoney" name="recharge.rechargeMoney" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">充值备注:</span>
			<span class="inputControl">
				<textarea id="recharge_rechargeMemo" name="recharge.rechargeMemo" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">充值时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="recharge_rechargeTime" name="recharge.rechargeTime" />

			</span>

		</div>
		<div class="operation">
			<a id="rechargeAddButton" class="easyui-linkbutton">用户充值</a>
			<a id="rechargeClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Recharge/js/recharge_add.js"></script> 
