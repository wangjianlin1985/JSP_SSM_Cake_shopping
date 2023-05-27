$(function () {
	$.ajax({
		url : "Recharge/" + $("#recharge_rechargeId_edit").val() + "/update",
		type : "get",
		data : {
			//rechargeId : $("#recharge_rechargeId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (recharge, response, status) {
			$.messager.progress("close");
			if (recharge) { 
				$("#recharge_rechargeId_edit").val(recharge.rechargeId);
				$("#recharge_rechargeId_edit").validatebox({
					required : true,
					missingMessage : "请输入充值id",
					editable: false
				});
				$("#recharge_userObj_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#recharge_userObj_user_name_edit").combobox("select", recharge.userObjPri);
						//var data = $("#recharge_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#recharge_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#recharge_rechargeMoney_edit").val(recharge.rechargeMoney);
				$("#recharge_rechargeMoney_edit").validatebox({
					required : true,
					validType : "number",
					missingMessage : "请输入充值金额",
					invalidMessage : "充值金额输入不对",
				});
				$("#recharge_rechargeMemo_edit").val(recharge.rechargeMemo);
				$("#recharge_rechargeTime_edit").datetimebox({
					value: recharge.rechargeTime,
					required: true,
					showSeconds: true,
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#rechargeModifyButton").click(function(){ 
		if ($("#rechargeEditForm").form("validate")) {
			$("#rechargeEditForm").form({
			    url:"Recharge/" +  $("#recharge_rechargeId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#rechargeEditForm").form("validate"))  {
	                	$.messager.progress({
							text : "正在提交数据中...",
						});
	                	return true;
	                } else {
	                    return false;
	                }
			    },
			    success:function(data){
			    	$.messager.progress("close");
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#rechargeEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
