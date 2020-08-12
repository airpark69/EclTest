<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">

<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://jsp5shim.googlecode.com/svn/trunk/jsp5.js" type="text/javascript"></script>
<![endif]-->

<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]--> 
<script type="../js/jquery-3.5.1.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('#brown').click(function() {
		$.getJSON('main_json.jsp', function(rdata) {
			$.each(rdata, function(index, item) {
				$('table').append('<tr><td>' + item.num + '</td><td class="left"><a href="content.bo?num="' + item.num + '>'
						+ item.subject + '</a></td><td>' + item.name + '</td><td>' + item.date + '</td><td>' + item.readcount + '</td></tr>');
			});
		});
		
		
		
	});

});



</script>


</head>
<body>
<div id="wrap">
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더파일들어가는 곳 -->
<!-- 메인이미지 들어가는곳 -->
<div class="clear"></div>
<div id="main_img"><img src="../images/main_img.jpg"
 width="971" height="282"></div>
<!-- 메인이미지 들어가는곳 -->
<!-- 메인 콘텐츠 들어가는 곳 -->
<article id="front">
<div id="solution">
<div id="hosting">
<h3>Web Hosting Solution</h3>
<p>Lorem impsun Lorem impsunLorem impsunLorem
 impsunLorem impsunLorem impsunLorem impsunLorem
  impsunLorem impsunLorem impsun....</p>
</div>
<div id="security">
<h3>Web Security Solution</h3>
<p>Lorem impsun Lorem impsunLorem impsunLorem
 impsunLorem impsunLorem impsunLorem impsunLorem
  impsunLorem impsunLorem impsun....</p>
</div>
<div id="payment">
<h3>Web Payment Solution</h3>
<p>Lorem impsun Lorem impsunLorem impsunLorem
 impsunLorem impsunLorem impsunLorem impsunLorem
  impsunLorem impsunLorem impsun....</p>
</div>
</div>
<div class="clear"></div>
<div id="sec_news">
<h3><span class="orange">Security</span> News</h3>
<dl>
<dt>Vivamus id ligula....</dt>
<dd>Proin quis ante Proin quis anteProin 
quis anteProin quis anteProin quis anteProin 
quis ante......</dd>
</dl>
<dl>
<dt>Vivamus id ligula....</dt>
<dd>Proin quis ante Proin quis anteProin 
quis anteProin quis anteProin quis anteProin 
quis ante......</dd>
</dl>
</div>
<div id="news_notice">
<h3 class="brown">News &amp; Notice</h3>
<table>

<%-- <jsp:useBean id="bb" class="board.BoardBean"/> --%>
<%
BoardBean bb = new BoardBean();
String id = (String)session.getAttribute("id");

BoardDAO bdao = new BoardDAO();
int pageSize = 5;

String pageNum = (String)request.getParameter("pageNum");


int currentPage=1;
if (pageNum != null){
	currentPage=Integer.parseInt(pageNum);
}
int startRow = 1 + pageSize * (currentPage - 1);
int endRow = pageSize * currentPage;

ArrayList pageBoardList = (ArrayList)bdao.getBoardList(startRow, pageSize);

int count = pageBoardList.size();
%>


<!-- 게시판 -->
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
	if(bb.getRep_lev() > 0){
		for(int i = 0; i < bb.getRep_lev(); i++){
			%>
			&nbsp;&nbsp;
			<%
		}
		%>
		RE : 
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
</div>
<!-- 메인 콘텐츠 들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>