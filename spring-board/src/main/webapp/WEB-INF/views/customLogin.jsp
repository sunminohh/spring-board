<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Bootstrap Admin Theme</title>

    <!-- Bootstrap Core CSS -->
    <link href="resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="resources/dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

</head>

<body>

    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Please Sign In</h3>
                    </div>
                    <div class="panel-body" style="text-align:center;">
                    
                        <form role="form" method="post" action="/login">
                            <fieldset>
                                <img alt="카카오로그인" src="/resources/img/kakao_login_medium_narrow.png" onclick="loginWithKakao()" style="margin-bottom:10px;">
                                <div class="form-group">
                                    <input class="form-control" placeholder="userid" name="username" type="text" autofocus>
                                </div>
                                <div class="form-group">
                                    <input class="form-control" placeholder="Password" name="password" type="password" value="">
                                </div>
                                <div class="checkbox" style="text-align:left;">
                                    <label>
                                        <input name="remember-me" type="checkbox" >Remember Me
                                    </label>
                                </div>
                                <!-- Change this to a button or input when using this as a form -->
                                <a class="btn btn-lg btn-success btn-block">Sign In</a>
                                <a href="/user/register" class="btn btn-lg btn-primary btn-block">Sign Up</a>
                            </fieldset>
                            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
                        </form>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- jQuery -->
    <script src="resources/vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="resources/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="resources/vendor/metisMenu/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="resources/dist/js/sb-admin-2.js"></script>
    
    <script src="https://developers.kakao.com/sdk/js/kakao.min.js" charset="utf-8"></script>
    
    <script type="text/javascript">
    
    $(document).ready(function() {
    	Kakao.init('');
    	Kakao.isInitialized();
    });
    
    function loginWithKakao() {
    	Kakao.Auth.authorize({
    		redirectUri: 'http://localhost:8080/kakao/callback'
    	}); // 등록한 리다이렉트uri 입력
    }
    
    $(".btn-success").on("click", function(e) {
    
    	e.preventDefault();
    	$("form").submit();
    });

    </script>
    
   <c:if test="${param.logout != null }">
    	<script>
    	$(document).ready(function(){
    		alert("로그아웃하였습니다.");
    	});
    	</script>
    </c:if>
</body>

</html>
