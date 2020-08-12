<%@page import="java.util.HashMap"%>
<%@page import="board.BoardDAO"%>
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
<li><a href="#">Notice</a></li>
<li><a href="#">Public News</a></li>
<li><a href="#">Driver Download</a></li>
<li><a href="#">Service Policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<%
request.setCharacterEncoding("utf-8");
%>
<!-- 게시판 -->
<jsp:useBean id="bb" class="board.BoardBean"/>
<jsp:setProperty property="*" name="bb"/>
<%
BoardDAO bdao = new BoardDAO();
bb = bdao.getBoard(bb.getNum());

HashMap listOpt = (HashMap)session.getAttribute("listOpt");

StringBuffer sb = new StringBuffer();
sb.append("?");
int pageNum = (int)listOpt.get("pageNum");
sb.append("pageNum=");
sb.append(pageNum);
String opt = (String)listOpt.get("opt");
String condition = (String)listOpt.get("condition");
if(opt != null){
	sb.append("&" + "opt=" + opt);
}

if(condition != null){
	sb.append("&" + "condition=" + condition);
}
%>

<script type="text/javascript">
 
 function goToNotice() {
	location.href="notice.bo<%=sb.toString() %>";
}
 
 
 </script>

<article>
<div>
<form action="contentUpdatePro.bo" method="post" id="write">
<input type="hidden" name="num" value="<%=bb.getNum()%>">
<table border="1">
<tr><td align="center">글쓴이</td><td><%=bb.getName() %></td>
<td>조회수</td><td><%=bb.getReadcount() %></td></tr>
<tr><td align="center">날짜</td><td><%=bb.getDate() %></td></tr>
<tr><td align="center">제목</td><td><%=bb.getSubject() %></td></tr>
<tr><td align="center">내용</td>
    <td><textarea rows="20" cols="70" name="content"><%=bb.getContent() %></textarea></td></tr>
<tr><td colspan="2" align="right">
<div id="buttons">패스워드 : <input type="password" name="pass"><input type="submit" value="수정" class="submit"><input type="button" value="목록" onclick="goToNotice()"></div></td></tr>
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