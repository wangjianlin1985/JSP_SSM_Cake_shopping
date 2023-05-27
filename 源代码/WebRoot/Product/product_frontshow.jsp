<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Product" %>
<%@ page import="com.chengxusheji.po.Comment" %>
<%@ page import="com.chengxusheji.po.ProductClass" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的productClassObj信息
    List<ProductClass> productClassList = (List<ProductClass>)request.getAttribute("productClassList");
    Product product = (Product)request.getAttribute("product");
    List<Comment> commentList = (ArrayList<Comment>)request.getAttribute("commentList");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>查看商品详情</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:90px;background-color:#B6DDE5;"> 
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div style="  margin-top:40px; margin-bottom:40px;">
			
  			<div style="text-align:center;color:#FF5252 ; font-size: 30px;">蛋糕详情</div>
  			<div style="text-align:center;color:#FF5252 ; font-size: 30px;">~~~~~</div>
		</div>

	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">商品名称:</div>
		<div class="col-md-10 col-xs-6"><%=product.getProductName()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">商品图片:</div>
		<div class="col-md-10 col-xs-6"><img class="img-responsive" src="<%=basePath %><%=product.getMainPhoto() %>"  border="0px"/></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">商品库存:</div>
		<div class="col-md-10 col-xs-6"><%=product.getProductNum()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">商品价格:</div>
		<div class="col-md-10 col-xs-6"><%=product.getPrice()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">是否推荐:</div>
		<div class="col-md-10 col-xs-6"><%=product.getRecommandFlag()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">是否个性DIY制作蛋糕:</div>
		<div class="col-md-10 col-xs-6"><%=product.getRecipeFlag()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">商品描述:</div>
		<div class="col-md-10 col-xs-6"><%=product.getProductDesc()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">发布时间:</div>
		<div class="col-md-10 col-xs-6"><%=product.getAddTime()%></div>
	</div>
	
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">评论内容:</div>
		<div class="col-md-10 col-xs-6">
			<textarea id="content" style="width:100%" rows=8></textarea>
		</div>
	</div>
	
	<div class="row bottom15">
		<div class="col-md-2 col-xs-4"></div>
		<div class="col-md-6 col-xs-6">
			<button onclick="userComment();" class="btn btn-primary">发布评论</button>
			<button onclick="cartAdd();" class="btn btn-primary">加入购物车</button>
			<button onclick="history.back();" class="btn btn-info">返回</button>
		</div>
	</div>
	
	
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold"></div>
		<div class="col-md-8 col-xs-7">
			<% for(Comment comment: commentList) { %>
			<div class="row" style="margin-top: 20px;">
				<div class="col-md-2 col-xs-3">
					<div class="row text-center"><img src="<%=basePath %><%=comment.getUserObj().getUserPhoto() %>" style="border: none;width:60px;height:60px;border-radius: 50%;" /></div>
					<div class="row text-center" style="margin: 5px 0px;"><%=comment.getUserObj().getUser_name() %></div>
				</div>
				<div class="col-md-7 col-xs-5"><%=comment.getContent() %></div>
				<div class="col-md-3 col-xs-4" ><%=comment.getCommentTime() %></div>
			</div>
		
			<% } %> 
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
 
 
 function cartAdd() {
	$.ajax({
		url : basePath + "ShopCart/userAdd",
		type : "post",
		data: {
			"shopCart.productObj.productId": <%=product.getProductId() %>, 
		},
		success : function (data, response, status) {
			//var obj = jQuery.parseJSON(data);
			if(data.success){
				alert("购物车添加成功~");
				location.href = basePath + "ShopCart/userFrontlist";
			}else{
				alert(data.message);
			}
		}
	});
}

function userComment() {
	var content = $("#content").val();
	if(content == "") {
		alert("请输入评论内容");
		return;
	}

	$.ajax({
		url : basePath + "Comment/userAdd",
		type : "post",
		data: {
			"comment.productObj.productId": <%=product.getProductId() %>,
			"comment.content": content
		},
		success : function (data, response, status) {
			//var obj = jQuery.parseJSON(data);
			if(data.success){
				alert("评论成功~");
				location.reload();
			}else{
				alert(data.message);
			}
		}
	});
}

 </script> 
</body>
</html>

