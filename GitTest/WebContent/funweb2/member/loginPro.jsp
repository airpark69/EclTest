<%@page import="java.util.HashMap"%>
<%@ page import="member.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String lastpage = request.getParameter("lastpage");
if(lastpage.equals("null")){
	lastpage = "main.do";
}else if(lastpage == null){
	lastpage = "main.do";
}
MemberDAO mdao = new MemberDAO();
HashMap<String,Object> listOpt = new HashMap<String, Object>();

listOpt.put("opt", null);
listOpt.put("condition", null);
listOpt.put("startRow", 1);
listOpt.put("pageSize", 10);
listOpt.put("pageNum", 1);
session.setAttribute("listOpt", listOpt);


int check = mdao.userCheck(id, pass);

%>

</head>
<body>

<%
switch(check){
case 1:
	session.setAttribute("id", id);
	%>
	<script type="text/javascript">
	alert("로그인 성공!");
	sessionStorage.setItem("id", "<%=id %>");
	</script>
	<%
	break;
case 0:
	%>
	<script type="text/javascript">
	alert("비밀번호 틀림!");
	</script>
	<%
	break;
case -1:
	%>
	<script type="text/javascript">
	alert("아이디 없음!");
	
	</script>
	<%
	break;
}



%>

<script type="text/javascript">

location.href = "<%=lastpage%>";
</script>

</body>
</html>