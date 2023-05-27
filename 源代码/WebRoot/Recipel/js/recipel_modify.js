$(function () {
	$.ajax({
		url : "Recipel/" + $("#recipel_recipelId_edit").val() + "/update",
		type : "get",
		data : {
			//recipelId : $("#recipel_recipelId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (recipel, response, status) {
			$.messager.progress("close");
			if (recipel) { 
				$("#recipel_recipelId_edit").val(recipel.recipelId);
				$("#recipel_recipelId_edit").validatebox({
					required : true,
					missingMessage : "请输入个性DIY制作id",
					editable: false
				});
				$("#recipel_recipelPhoto").val(recipel.recipelPhoto);
				$("#recipel_recipelPhotoImg").attr("src", recipel.recipelPhoto);
				$("#recipel_userObj_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#recipel_userObj_user_name_edit").combobox("select", recipel.userObjPri);
						//var data = $("#recipel_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#recipel_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#recipel_recipelMemo_edit").val(recipel.recipelMemo);
				$("#recipel_handState_edit").val(recipel.handState);
				$("#recipel_handState_edit").validatebox({
					required : true,
					missingMessage : "请输入处理状态",
				});
				$("#recipel_addTime_edit").datetimebox({
					value: recipel.addTime,
					required: true,
					showSeconds: true,
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#recipelModifyButton").click(function(){ 
		if ($("#recipelEditForm").form("validate")) {
			$("#recipelEditForm").form({
			    url:"Recipel/" +  $("#recipel_recipelId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#recipelEditForm").form("validate"))  {
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
			$("#recipelEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
