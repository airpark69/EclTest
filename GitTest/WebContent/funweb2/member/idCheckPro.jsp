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
	response.sendRedirect("IdCheckForm.do?userId=" + id);
}
else{
	session.setAttribute("startCheck", true);
	session.setAttribute("dubCheck", false);
	%>
	<script type="text/javascript">
	alert("사용할 수 없는 아이디입니다.");
	location.href = "IdCheckForm.do?userId=" + "<%=id%>";
	</script>
	<% 
	
// 	response.sendRedirect("IdCheckForm.do?userId=" + id);
}
%>

</body>
</html>