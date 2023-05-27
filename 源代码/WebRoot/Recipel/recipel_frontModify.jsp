<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Recipel" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    Recipel recipel = (Recipel)request.getAttribute("recipel");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改个性DIY制作信息</TITLE>
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
  		<li class="active">个性DIY制作信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="recipelEditForm" id="recipelEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="recipel_recipelId_edit" class="col-md-3 text-right">个性DIY制作id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="recipel_recipelId_edit" name="recipel.recipelId" class="form-control" placeholder="请输入个性DIY制作id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="recipel_recipelPhoto_edit" class="col-md-3 text-right">个性DIY制作照片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="recipel_recipelPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="recipel_recipelPhoto" name="recipel.recipelPhoto"/>
			    <input id="recipelPhotoFile" name="recipelPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="recipel_userObj_user_name_edit" class="col-md-3 text-right">上传用户:</label>
		  	 <div class="col-md-9">
			    <select id="recipel_userObj_user_name_edit" name="recipel.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="recipel_recipelMemo_edit" class="col-md-3 text-right">个性DIY制作备注:</label>
		  	 <div class="col-md-9">
			    <textarea id="recipel_recipelMemo_edit" name="recipel.recipelMemo" rows="8" class="form-control" placeholder="请输入个性DIY制作备注"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="recipel_handState_edit" class="col-md-3 text-right">处理状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="recipel_handState_edit" name="recipel.handState" class="form-control" placeholder="请输入处理状态">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="recipel_addTime_edit" class="col-md-3 text-right">上传时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date recipel_addTime_edit col-md-12" data-link-field="recipel_addTime_edit">
                    <input class="form-control" id="recipel_addTime_edit" name="recipel.addTime" size="16" type="text" value="" placeholder="请选择上传时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxRecipelModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#recipelEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改个性DIY制作界面并初始化数据*/
function recipelEdit(recipelId) {
	$.ajax({
		url :  basePath + "Recipel/" + recipelId + "/update",
		type : "get",
		dataType: "json",
		success : function (recipel, response, status) {
			if (recipel) {
				$("#recipel_recipelId_edit").val(recipel.recipelId);
				$("#recipel_recipelPhoto").val(recipel.recipelPhoto);
				$("#recipel_recipelPhotoImg").attr("src", basePath +　recipel.recipelPhoto);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#recipel_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#recipel_userObj_user_name_edit").html(html);
		        		$("#recipel_userObj_user_name_edit").val(recipel.userObjPri);
					}
				});
				$("#recipel_recipelMemo_edit").val(recipel.recipelMemo);
				$("#recipel_handState_edit").val(recipel.handState);
				$("#recipel_addTime_edit").val(recipel.addTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交个性DIY制作信息表单给服务器端修改*/
function ajaxRecipelModify() {
	$.ajax({
		url :  basePath + "Recipel/" + $("#recipel_recipelId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#recipelEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#recipelQueryForm").submit();
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
    /*上传时间组件*/
    $('.recipel_addTime_edit').datetimepicker({
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
    recipelEdit("<%=request.getParameter("recipelId")%>");
 })
 </script> 
</body>
</html>

