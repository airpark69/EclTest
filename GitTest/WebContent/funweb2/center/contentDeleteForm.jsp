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
 String num = request.getParameter("num");
 int type = Integer.parseInt(request.getParameter("type"));
 %>
 <script type="text/javascript">
 
 function No() {
	history.back();
}
 
 </script>
 
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
<p>글을 삭제 하시겠습니까?</p><br>
<%if(type == 0){ %>
<form action="contentDeletePro.bo">
비밀번호 입력 : <input type="password" name="pass"><input type="hidden" value="<%=num %>" name="num">
<input type="hidden" value="<%=type %>" name="type"><br>
<input type="submit" value="예"><input type="button" value="아니오" onclick="No()">
</form>
<%}else if (type == 1){ %>
<form action="contentDeletePro.bo">
비밀번호 입력 : <input type="password" name="pass"><input type="hidden" value="<%=num %>" name="num">
<input type="hidden" value="<%=type %>" name="type"><br>
<input type="submit" value="예"><input type="button" value="아니오" onclick="No()">
</form>
<%} %>
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