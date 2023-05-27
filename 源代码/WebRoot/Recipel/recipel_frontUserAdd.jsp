<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>个性DIY制作添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:90px;background-color:#B6DDE5;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-12 wow fadeInLeft">
		<div style="  margin-top:40px; margin-bottom:40px;">
			
  			<div style="text-align:center;color:#FF5252 ; font-size: 30px;">个性DIY制作</div>
  			<div style="text-align:center;color:#FF5252 ; font-size: 30px;">~~~~~</div>
		</div>
		<div class="row">
			<div class="col-md-12">
		      	<form class="form-horizontal" name="recipelAddForm" id="recipelAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
				  	 <label for="recipel_recipelPhoto" class="col-md-2 text-right">个性DIY制作照片:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="recipel_recipelPhotoImg" border="0px"/><br/>
					    <input type="hidden" id="recipel_recipelPhoto" name="recipel.recipelPhoto"/>
					    <input id="recipelPhotoFile" name="recipelPhotoFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group" style="display:none;">
				  	 <label for="recipel_userObj_user_name" class="col-md-2 text-right">上传用户:</label>
				  	 <div class="col-md-8">
					    <select id="recipel_userObj_user_name" name="recipel.userObj.user_name" class="form-control">
					    </select>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="recipel_recipelMemo" class="col-md-2 text-right">个性DIY制作备注:</label>
				  	 <div class="col-md-8">
					    <textarea id="recipel_recipelMemo" name="recipel.recipelMemo" rows="8" class="form-control" placeholder="请输入个性DIY制作备注"></textarea>
					 </div>
				  </div>
				  <div class="form-group" style="display:none;">
				  	 <label for="recipel_handState" class="col-md-2 text-right">处理状态:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="recipel_handState" name="recipel.handState" class="form-control" placeholder="请输入处理状态">
					 </div>
				  </div>
				  <div class="form-group" style="display:none;">
				  	 <label for="recipel_addTimeDiv" class="col-md-2 text-right">上传时间:</label>
				  	 <div class="col-md-8">
		                <div id="recipel_addTimeDiv" class="input-group date recipel_addTime col-md-12" data-link-field="recipel_addTime">
		                    <input class="form-control" id="recipel_addTime" name="recipel.addTime" size="16" type="text" value="" placeholder="请选择上传时间" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2"></span>
		             <span onclick="ajaxRecipelAdd();" class="btn btn-primary bottom5 top5">提交个性DIY制作</span>
		          </div> 
		          <style>#recipelAddForm .form-group {margin-left:50px;}  </style>  
				</form> 
			</div>
			<div class="col-md-2"></div> 
	    </div>
	</div>
</div>
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加个性DIY制作信息
	function ajaxRecipelAdd() { 
		//提交之前先验证表单
		$("#recipelAddForm").data('bootstrapValidator').validate();
		if(!$("#recipelAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Recipel/userAdd",
			dataType : "json" , 
			data: new FormData($("#recipelAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#recipelAddForm").find("input").val("");
					$("#recipelAddForm").find("textarea").val("");
				} else {
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
	//验证个性DIY制作添加表单字段
	$('#recipelAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
		 
		}
	}); 
	//初始化上传用户下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#recipel_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#recipel_userObj_user_name").html(html);
    	}
	});
	//上传时间组件
	$('#recipel_addTimeDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd hh:ii:ss',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#recipelAddForm').data('bootstrapValidator').updateStatus('recipel.addTime', 'NOT_VALIDATED',null).validateField('recipel.addTime');
	});
})
</script>
</body>
</html>
