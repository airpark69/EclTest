<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.File"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="board.*" %>
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
 <script>dddddddddddddddddddddddd
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
<li><a href="notice.bo">자유게시판</a></li>
<li><a href="gallery.bo">갤러리 게시판</a></li>
<li><a href="#">Driver Download</a></li>
<li><a href="#">Service Policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<jsp:useBean id="bb" class="board.BoardBean"/>
<%
String id = (String)session.getAttribute("id");

BoardDAO bdao = new BoardDAO();
int pageSize = 10;

String pageNum = (String)request.getParameter("pageNum");

HashMap<String,Object> listOpt = new HashMap<String, Object>();
String opt = (String)request.getParameter("opt");
String condition = (String)request.getParameter("condition");

int currentPage=1;
if (pageNum != null){
	currentPage=Integer.parseInt(pageNum);
}
int startRow = 1 + pageSize * (currentPage - 1);
int endRow = pageSize * currentPage;

//
listOpt.put("opt", opt);
listOpt.put("condition", condition);
listOpt.put("startRow", startRow);
listOpt.put("pageSize", pageSize);
listOpt.put("pageNum", currentPage);

session.setAttribute("listOpt", listOpt);
//

ArrayList pageBoardList = (ArrayList)bdao.getBoardList(startRow, pageSize);

pageBoardList = (ArrayList)bdao.getBoardList(listOpt);
int count = pageBoardList.size();
if(opt == null){
	count = bdao.getBoardCount();
}
%>


<!-- 게시판 -->
<article>
<h1>자유 게시판 [전체 글개수 : <%=count %>]</h1>
<div id="table_search">
<form>
<select name="opt">
<option value="0">제목</option>
<option value="1">내용</option>
<option value="2">글쓴이</option>
</select>
<input type="text" name="condition" size="20">
<input type="submit" value="검색" class="btn">
</form>
</div>
<table id="notice">
<tr><th class="tno">No.</th>
    <th class="ttitle">Title</th>
    <th class="twrite">Writer</th>
    <th class="tdate">Date</th>
    <th class="tread">Read</th></tr>
    
<%
SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");

for(int x = 0; x < pageBoardList.size(); x++){
	bb = (BoardBean)pageBoardList.get(x);
	%>
	<tr><td><%=bb.getNum() %></td><td class="left"><a href="content.bo?num=<%=bb.getNum()%>&pageNum=<%=currentPage %>">
	
	
	<%
	int wid = 0;
	if(bb.getRep_lev() > 0){
		wid = bb.getRep_lev() * 10;
		%>
		<img src="level.gif" width="<%=wid %>" height="15">
		<img src="re.gif">
		[RE] : 
		<%
	}
	
	
	%><%=bb.getSubject() %>
	<%
    ServletContext context = request.getServletContext();
    String imagePath = context.getRealPath("/image");
    if(bb.getFile() != null){
    	File file = new File(imagePath + "/sm_" + bb.getFile());
    	if(file.exists()){
    
    %>
    
    
    
    
    
    
    
    <img src="../../image/sm_<%=bb.getFile()%>"/>
    <%}} %>
	
	</a></td>
    <td><%=bb.getName() %></td><td><%=sdf.format(bb.getDate()) %></td><td><%=bb.getReadcount() %></td></tr>
	<%
}
%> 
</table>
<%if(id != null) {%>
<div id="table_search">
<a href="writeForm.bo?type=0"><input type="button" value="글쓰기"></a>
</div>
<%} %>

<div class="clear"></div>
<div id="page_control">
<%if (currentPage != 1){ %>
	
<a href="notice.bo?pageNum=<%=currentPage - 1%>">Prev</a>

<% }%>
<%
int lastPage = count / pageSize + ((count % pageSize) == 0 ? 0 : 1);

// if((count % pageSize) != 0){
// 	lastPage++;
// }

for(int x = 0; x < lastPage;x++){
	%><a href="notice.bo?pageNum=<%=x+1%>"><%=x+1 %></a>
	
	<%
}

%>
<%if (currentPage != lastPage && lastPage != 0){ %>
	
<a href="notice.bo?pageNum=<%=currentPage + 1%>">Next</a>

<% }%>
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