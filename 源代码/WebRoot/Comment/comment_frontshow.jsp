<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Comment" %>
<%@ page import="com.chengxusheji.po.Product" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的productObj信息
    List<Product> productList = (List<Product>)request.getAttribute("productList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    Comment comment = (Comment)request.getAttribute("comment");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>查看评论详情</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:90px;background-color:#B6DDE5;"> 
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div style="  margin-top:40px; margin-bottom:40px;">
			
  			<div style="text-align:center;color:#FF5252 ; font-size: 30px;">评论信息</div>
  			<div style="text-align:center;color:#FF5252 ; font-size: 30px;">~~~~~</div>
		</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">评论id:</div>
		<div class="col-md-10 col-xs-6"><%=comment.getCommentId()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">被评商品:</div>
		<div class="col-md-10 col-xs-6"><%=comment.getProductObj().getProductName() %></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">评论内容:</div>
		<div class="col-md-10 col-xs-6"><%=comment.getContent()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">评论用户:</div>
		<div class="col-md-10 col-xs-6"><%=comment.getUserObj().getName() %></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">评论时间:</div>
		<div class="col-md-10 col-xs-6"><%=comment.getCommentTime()%></div>
	</div>
	<div class="row bottom15">
		<div class="col-md-2 col-xs-4"></div>
		<div class="col-md-6 col-xs-6">
			<button onclick="history.back();" class="btn btn-primary">返回</button>
		</div>
	</div>
</div> 
<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script>
var basePath = "<%=basePath%>";
$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
 })
 </script> 
</body>
</html>

