<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
session.invalidate();
%>
<script type="text/javascript">
sessionStorage.clear();
alert("로그아웃 성공!");
location.href = "main.do";
</script>

</body>
</html>