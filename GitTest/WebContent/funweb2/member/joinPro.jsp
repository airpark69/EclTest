<%@page import="java.sql.Timestamp"%>
<%@ page import="member.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
request.setCharacterEncoding("utf-8");
Timestamp reg_date = new Timestamp(System.currentTimeMillis());
%>

<jsp:useBean id="mb" class="member.MemberBean"/>
<jsp:setProperty property="*" name="mb"/>

<%
mb.setReg_date(reg_date);
MemberDAO mdao = new MemberDAO();
mdao.insertMember(mb);

%>

<script type="text/javascript">
alert("회원가입 완료!");
location.href="main.do";
</script>


</head>
<body>

</body>
</html>