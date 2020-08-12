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

BoardDAO bdao = new BoardDAO();
int check = bdao.userCheck(bb.getNum(), bb.getPass());

if(check == 1){

BoardBean tempbb = bdao.getBoard(bb.getNum());
tempbb.setContent(bb.getContent());
tempbb.setDate(reg_date);

bdao.updateBoard(tempbb);
}else{
	%>
	<script type="text/javascript">
	alert("비밀번호 틀림!");
	history.back();
	</script>
	<%
}
%>

</head>
<body>

<script type="text/javascript">
alert("수정 완료");
location.href="notice.bo";
</script>


</body>
</html>