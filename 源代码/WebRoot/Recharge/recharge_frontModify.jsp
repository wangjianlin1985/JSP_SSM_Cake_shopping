<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Recharge" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    Recharge recharge = (Recharge)request.getAttribute("recharge");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改充值信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">充值信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="rechargeEditForm" id="rechargeEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="recharge_rechargeId_edit" class="col-md-3 text-right">充值id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="recharge_rechargeId_edit" name="recharge.rechargeId" class="form-control" placeholder="请输入充值id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="recharge_userObj_user_name_edit" class="col-md-3 text-right">充值用户:</label>
		  	 <div class="col-md-9">
			    <select id="recharge_userObj_user_name_edit" name="recharge.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="recharge_rechargeMoney_edit" class="col-md-3 text-right">充值金额:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="recharge_rechargeMoney_edit" name="recharge.rechargeMoney" class="form-control" placeholder="请输入充值金额">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="recharge_rechargeMemo_edit" class="col-md-3 text-right">充值备注:</label>
		  	 <div class="col-md-9">
			    <textarea id="recharge_rechargeMemo_edit" name="recharge.rechargeMemo" rows="8" class="form-control" placeholder="请输入充值备注"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="recharge_rechargeTime_edit" class="col-md-3 text-right">充值时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date recharge_rechargeTime_edit col-md-12" data-link-field="recharge_rechargeTime_edit">
                    <input class="form-control" id="recharge_rechargeTime_edit" name="recharge.rechargeTime" size="16" type="text" value="" placeholder="请选择充值时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxRechargeModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#rechargeEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改充值界面并初始化数据*/
function rechargeEdit(rechargeId) {
	$.ajax({
		url :  basePath + "Recharge/" + rechargeId + "/update",
		type : "get",
		dataType: "json",
		success : function (recharge, response, status) {
			if (recharge) {
				$("#recharge_rechargeId_edit").val(recharge.rechargeId);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#recharge_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#recharge_userObj_user_name_edit").html(html);
		        		$("#recharge_userObj_user_name_edit").val(recharge.userObjPri);
					}
				});
				$("#recharge_rechargeMoney_edit").val(recharge.rechargeMoney);
				$("#recharge_rechargeMemo_edit").val(recharge.rechargeMemo);
				$("#recharge_rechargeTime_edit").val(recharge.rechargeTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交充值信息表单给服务器端修改*/
function ajaxRechargeModify() {
	$.ajax({
		url :  basePath + "Recharge/" + $("#recharge_rechargeId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#rechargeEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#rechargeQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    /*充值时间组件*/
    $('.recharge_rechargeTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    rechargeEdit("<%=request.getParameter("rechargeId")%>");
 })
 </script> 
</body>
</html>

