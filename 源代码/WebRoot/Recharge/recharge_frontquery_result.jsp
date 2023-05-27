<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Recharge" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Recharge> rechargeList = (List<Recharge>)request.getAttribute("rechargeList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String rechargeTime = (String)request.getAttribute("rechargeTime"); //充值时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>充值查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#rechargeListPanel" aria-controls="rechargeListPanel" role="tab" data-toggle="tab">充值列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Recharge/recharge_frontAdd.jsp" style="display:none;">添加充值</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="rechargeListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>充值id</td><td>充值用户</td><td>充值金额</td><td>充值时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<rechargeList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Recharge recharge = rechargeList.get(i); //获取到充值对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=recharge.getRechargeId() %></td>
 											<td><%=recharge.getUserObj().getName() %></td>
 											<td><%=recharge.getRechargeMoney() %></td>
 											<td><%=recharge.getRechargeTime() %></td>
 											<td>
 												<a href="<%=basePath  %>Recharge/<%=recharge.getRechargeId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="rechargeEdit('<%=recharge.getRechargeId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="rechargeDelete('<%=recharge.getRechargeId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

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
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>充值查询</h1>
		</div>
		<form name="rechargeQueryForm" id="rechargeQueryForm" action="<%=basePath %>Recharge/frontlist" class="mar_t15">
            <div class="form-group">
            	<label for="userObj_user_name">充值用户：</label>
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
				<label for="rechargeTime">充值时间:</label>
				<input type="text" id="rechargeTime" name="rechargeTime" class="form-control"  placeholder="请选择充值时间" value="<%=rechargeTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="rechargeEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;充值信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#rechargeEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxRechargeModify();">提交</button>
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
    document.rechargeQueryForm.currentPage.value = currentPage;
    document.rechargeQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.rechargeQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.rechargeQueryForm.currentPage.value = pageValue;
    documentrechargeQueryForm.submit();
}

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
				$('#rechargeEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除充值信息*/
function rechargeDelete(rechargeId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Recharge/deletes",
			data : {
				rechargeIds : rechargeId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#rechargeQueryForm").submit();
					//location.href= basePath + "Recharge/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

