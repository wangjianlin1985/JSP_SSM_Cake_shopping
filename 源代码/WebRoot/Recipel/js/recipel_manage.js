var recipel_manage_tool = null; 
$(function () { 
	initRecipelManageTool(); //建立Recipel管理对象
	recipel_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#recipel_manage").datagrid({
		url : 'Recipel/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "recipelId",
		sortOrder : "desc",
		toolbar : "#recipel_manage_tool",
		columns : [[
			{
				field : "recipelId",
				title : "个性DIY制作id",
				width : 70,
			},
			{
				field : "recipelPhoto",
				title : "个性DIY制作照片",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "userObj",
				title : "上传用户",
				width : 140,
			},
			{
				field : "recipelMemo",
				title : "个性DIY制作备注",
				width : 140,
			},
			{
				field : "handState",
				title : "处理状态",
				width : 140,
			},
			{
				field : "addTime",
				title : "上传时间",
				width : 140,
			},
		]],
	});

	$("#recipelEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#recipelEditForm").form("validate")) {
					//验证表单 
					if(!$("#recipelEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#recipelEditForm").form({
						    url:"Recipel/" + $("#recipel_recipelId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#recipelEditDiv").dialog("close");
			                        recipel_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#recipelEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#recipelEditDiv").dialog("close");
				$("#recipelEditForm").form("reset"); 
			},
		}],
	});
});

function initRecipelManageTool() {
	recipel_manage_tool = {
		init: function() {
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{user_name:"",name:"不限制"});
					$("#userObj_user_name_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#recipel_manage").datagrid("reload");
		},
		redo : function () {
			$("#recipel_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#recipel_manage").datagrid("options").queryParams;
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["handState"] = $("#handState").val();
			queryParams["addTime"] = $("#addTime").datebox("getValue"); 
			$("#recipel_manage").datagrid("options").queryParams=queryParams; 
			$("#recipel_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#recipelQueryForm").form({
			    url:"Recipel/OutToExcel",
			});
			//提交表单
			$("#recipelQueryForm").submit();
		},
		remove : function () {
			var rows = $("#recipel_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var recipelIds = [];
						for (var i = 0; i < rows.length; i ++) {
							recipelIds.push(rows[i].recipelId);
						}
						$.ajax({
							type : "POST",
							url : "Recipel/deletes",
							data : {
								recipelIds : recipelIds.join(","),
							},
							beforeSend : function () {
								$("#recipel_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#recipel_manage").datagrid("loaded");
									$("#recipel_manage").datagrid("load");
									$("#recipel_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#recipel_manage").datagrid("loaded");
									$("#recipel_manage").datagrid("load");
									$("#recipel_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#recipel_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Recipel/" + rows[0].recipelId +  "/update",
					type : "get",
					data : {
						//recipelId : rows[0].recipelId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (recipel, response, status) {
						$.messager.progress("close");
						if (recipel) { 
							$("#recipelEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
