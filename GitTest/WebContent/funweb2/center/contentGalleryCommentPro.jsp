<%@page import="java.util.HashMap"%>
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

GalleryDAO bdao = new GalleryDAO();
bdao.insertComment(bb);
System.out.println(bb.getRep_ref());
bdao.updateGallery(bb.getRep_ref(), 1);

HashMap listopt = (HashMap)session.getAttribute("listOpt");
int currentPage = (int)listopt.get("pageNum");
%>

</head>
<body>

<script type="text/javascript">
alert("댓글 작성 완료");
location.href="contentGallery.bo?num=<%=bb.getRep_ref()%>&pageNum=<%=currentPage %>";
</script>


</body>
</html>