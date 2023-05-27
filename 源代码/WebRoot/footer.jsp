<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<style>
<!--

-->
.szone-rule {
    width: 100%;
    background-color: #71c0e1;
        
}
.dl{
width: 580px;
    margin: 0 auto;
    padding: 30px 0;
    color: #fff;
}
</style>
<!--footer-->
<footer>
    <div class="container szone-rule">
        <div class="row dl">
            <div class="col-md-12 ">
            	<a href="http://www.baidu.com" target=_blank style="color:#FFFFFF;">蛋糕销售</a> | 
				<a href="http://www.baidu.com"style="color:#FFFFFF;">特价蛋糕</a> | 
				<a href="http://www.baidu.com"style="color:#FFFFFF;">全国配送</a> | 
				
				<a href="<%=basePath%>login.jsp"style="color:#FFFFFF;">后台登录</a>
            </div>
        </div>
    </div>
</footer>
<!--footer--> 

 


 