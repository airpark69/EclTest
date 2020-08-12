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

%>

<jsp:useBean id="mb" class="member.MemberBean"/>
<jsp:setProperty property="*" name="mb"/>

<%
MemberDAO mdao = new MemberDAO();
int check = mdao.updateMember(mb);

switch(check){
case 1:
	%>
	<script type="text/javascript">
	alert("수정 성공!");
	location.href = "../main/main.jsp";
	</script>
	
	<% 
	break;
case 0:
	%>
	<script type="text/javascript">
	alert("비밀번호 틀림!");
	location.href = "updateForm.jsp";
	</script>
	<% 
	break;
}
%>



</body>
</html>