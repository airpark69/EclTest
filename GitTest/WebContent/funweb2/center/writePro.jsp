<%@page import="java.sql.Timestamp"%>
<%@ page import="board.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="bb" class="board.BoardBean"/>
<jsp:setProperty property="*" name="bb"/>

<%
Timestamp reg_date = new Timestamp(System.currentTimeMillis());
bb.setDate(reg_date);
bb.setReadcount(1);

BoardDAO bdao = new BoardDAO();
bdao.insertBoard(bb);
%>

</head>
<body>

<script type="text/javascript">
alert("글쓰기 완료");
location.href="../center/notice.jsp";
</script>


</body>
</html>