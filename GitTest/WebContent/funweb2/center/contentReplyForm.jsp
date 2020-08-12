<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
 <%
 int type = Integer.parseInt(request.getParameter("type"));
 String id = (String)session.getAttribute("id");
 if(id == null){
	 response.sendRedirect("login.do");
 }
 
 BoardBean bb = (BoardBean)session.getAttribute("board");
 
 int num = bb.getNum();
 
 %>
 
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="notice.bo">자유게시판</a></li>
<li><a href="gallery.bo">갤러리 게시판</a></li>
<li><a href="#">Driver Download</a></li>
<li><a href="#">Service Policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<article>
<div>
<form action="contentReplyPro.bo" method="post" enctype="multipart/form-data" id="write">
<input type="hidden" name="rep_ref" value="<%=bb.getRep_ref() %>">
<input type="hidden" name="rep_lev" value="<%=bb.getRep_lev() %>">
<input type="hidden" name="rep_seq" value="<%=bb.getRep_seq() %>">
<input type="hidden" name="type" value="<%=type %>">
<table border="1">
<tr><td align="center">글쓴이</td><td><input type="text" name="name" value="<%=id%>" class="top" readonly="readonly"></td></tr>
<tr><td align="center">비밀번호</td><td><input type="password" name="pass" class="top"></td></tr>
<tr><td align="center">제목</td><td><input type="text" name="subject" class="top"></td></tr>
<tr><td align="center">파일</td><td><input type="file" name="file"></td></tr>
<tr><td align="center">내용</td>
    <td><textarea rows="20" cols="70" name="content"></textarea></td></tr>
<tr><td colspan="2" align="right">
<div id="buttons"><input type="submit" value="글쓰기" class="submit"></div></td></tr>
</table>
</form>
</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>