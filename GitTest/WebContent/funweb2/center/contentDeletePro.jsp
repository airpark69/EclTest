<%@page import="board.GalleryDAO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:useBean id="bb" class="board.BoardBean"/>
<jsp:setProperty property="*" name="bb"/>

<%
int type = Integer.parseInt(request.getParameter("type"));
int check = 0;
if(type == 0){
    BoardDAO bdao = new BoardDAO();
    check = bdao.deleteBoard(bb);
}else if(type == 1){
	GalleryDAO bdao = new GalleryDAO();
	check = bdao.deleteGallery(bb);
}



if (check == 1){
	%>
	<script type="text/javascript">
	alert("삭제 완료");
	location.href = "notice.bo";
	</script>
	<%
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

</body>
</html>