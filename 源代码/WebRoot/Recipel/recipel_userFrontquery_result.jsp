<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Recipel" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Recipel> recipelList = (List<Recipel>)request.getAttribute("recipelList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String handState = (String)request.getAttribute("handState"); //处理状态查询关键字
    String addTime = (String)request.getAttribute("addTime"); //上传时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>个性DIY制作查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<style>
.showFields1 {
    height: 24px;
    font-size: 12px;
    font-weight: 100;
    line-height: 35px;
    text-align: center;
    color: #f9877d;
</style>
<body style="margin-top:90px;background-color:#B6DDE5;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-12 wow fadeInLeft">
		<div style="  margin-top:40px; margin-bottom:40px;">
			
  			<div style="text-align:center;color:#FF5252 ; font-size: 30px;">蛋糕</div>
  			<div style="text-align:center;color:#FF5252 ; font-size: 30px;">~~~~~</div>
		</div>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<recipelList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		Recipel recipel = recipelList.get(i); //获取到个性DIY制作对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>Recipel/<%=recipel.getRecipelId() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=recipel.getRecipelPhoto()%>" style="width:268px;height:268px;"/></a>
			     <div class="showFields">
			     
			     	<div class="field showFields1">
	            		个性DIY制作备注:<%=recipel.getRecipelMemo() %>
			     	</div>
			     	<div class="field showFields1">
	            		处理状态:<%=recipel.getHandState() %>
			     	</div>
			     	<div class="field showFields1">
	            		上传时间:<%=recipel.getAddTime() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>Recipel/<%=recipel.getRecipelId() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="recipelEdit('<%=recipel.getRecipelId() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="recipelDelete('<%=recipel.getRecipelId() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

			<div class="row">
				<div class="col-md-12">
					<nav class="pull-left">
						<ul class="pagination">
							<li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
							<%
								int startPage = currentPage - 5;
								int endPage = currentPage + 5;
								if(startPage < 1) startPage=1;
								if(endPage > totalPage) endPage = totalPage;
								for(int i=startPage;i<=endPage;i++) {
							%>
							<li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
							<%  } %> 
							<li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						</ul>
					</nav>
					<div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
				</div>
			</div>
		</div>
	</div>

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>个性DIY制作查询</h1>
		</div>
		<form name="recipelQueryForm" id="recipelQueryForm" action="<%=basePath %>Recipel/userFrontlist" class="mar_t15">
            <div class="form-group" style="display:none;">
            	<label for="userObj_user_name">上传用户：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="handState">处理状态:</label>
				<input type="text" id="handState" name="handState" value="<%=handState %>" class="form-control" placeholder="请输入处理状态">
			</div>
			<div class="form-group">
				<label for="addTime">上传时间:</label>
				<input type="text" id="addTime" name="addTime" class="form-control"  placeholder="请选择上传时间" value="<%=addTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="recipelEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;个性DIY制作信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#recipelEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxRecipelModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.recipelQueryForm.currentPage.value = currentPage;
    document.recipelQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.recipelQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.recipelQueryForm.currentPage.value = pageValue;
    documentrecipelQueryForm.submit();
}

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
				$('#recipelEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除个性DIY制作信息*/
function recipelDelete(recipelId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Recipel/deletes",
			data : {
				recipelIds : recipelId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#recipelQueryForm").submit();
					//location.href= basePath + "Recipel/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

