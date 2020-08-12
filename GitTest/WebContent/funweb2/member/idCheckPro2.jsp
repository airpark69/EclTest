<%@ page import="member.*" %>
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
request.setCharacterEncoding("utf-8");
String id = request.getParameter("userId");

MemberDAO mdao = new MemberDAO();
MemberBean mb = mdao.getMember(id);

if(mb.getId().equals("null")){
	session.setAttribute("dubCheck", true);
	session.setAttribute("startCheck", true);
	System.out.println("아이디 사용 가능!");
	%>
	아이디 사용 가능!
	<% 
}
else{
	session.setAttribute("startCheck", true);
	session.setAttribute("dubCheck", false);
	System.out.println("아이디 사용 불가!");
	%>
	아이디 사용 불가!
	<%
	
// 	response.sendRedirect("IdCheckForm.do?userId=" + id);
}
%>

</body>
</html>