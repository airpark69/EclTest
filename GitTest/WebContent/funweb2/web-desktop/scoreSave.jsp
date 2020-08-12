<%@page import="game.gameDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<jsp:useBean id="gb" class="game.gameBean" />
<jsp:setProperty property="*" name="gb"/>
<%
	String id = (String) session.getAttribute("id");


if (id == null) {
%>
<script type="text/javascript">
	alert("로그인 후 저장 가능!");
	history.back();
</script>
<%
} else {
	gameDAO gdao = gameDAO.getInstance();

	gdao.insertScore(gb);
%>
<script type="text/javascript">
	alert("저장 완료!");
	location.href = "main.do";
</script>
<%
	}
%>

</head>
<body>
</body>
</html>