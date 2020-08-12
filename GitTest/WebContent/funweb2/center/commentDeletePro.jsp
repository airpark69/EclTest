<%@page import="java.util.HashMap"%>
<%@page import="board.GalleryDAO"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
BoardBean bb = new BoardBean();

int num = Integer.parseInt(request.getParameter("num"));
int ref = Integer.parseInt(request.getParameter("ref"));

bb.setNum(num);
bb.setRep_ref(ref);

int type = Integer.parseInt(request.getParameter("type"));

if(type == 0){
	BoardDAO bdao = new BoardDAO();
	bdao.deleteComment(bb);
}else if(type == 1){
	GalleryDAO gdao = new GalleryDAO();
	gdao.deleteComment(bb);
}

HashMap listopt = (HashMap)session.getAttribute("listOpt");
int currentPage = (int)listopt.get("pageNum");

%>

</head>
<body>
<script type="text/javascript">
alert("댓글 삭제 완료");
location.href="content.bo?num=<%=bb.getRep_ref()%>&pageNum=<%=currentPage %>";
</script>


</body>
</html>