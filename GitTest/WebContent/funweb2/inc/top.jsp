<%@page import="game.gameDAO"%>
<%@page import="board.NewDAO"%>
<%@page import="board.GalleryDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link href="../css/top.css" rel="stylesheet" type="text/css">
<header>



<script type="text/javascript">
		
		function changeView(value){
			
			if(value == "0") // HOME 버튼 클릭시 첫화면으로 이동
			{
				location.href="main.do";
			}
			else if(value == "1") // 로그인 버튼 클릭시 로그인 화면으로 이동
			{
				location.href="login.do?lastpage=" + document.location.href;
			}
			else if(value == "2") // 회원가입 버튼 클릭시 회원가입 화면으로 이동
			{
				location.href="join.do";
			}
			else if(value == "3") // 로그아웃 버튼 클릭시 로그아웃 처리
			{
				location.href="logout.do";
			}
			else if(value == "4") // 내정보 버튼 클릭시 회원정보 보여주는 화면으로 이동
			{
				location.href="updateForm.do";
			}
		}
		
		function alarmFun() {
			if(alarmText.style.display=='none'){
				alarmText.style.display='block';
				alarm.innerText = '알람 닫기';
			}else{
				alarmText.style.display='none';
				alarm.innerText = '알람';
			}
				
		}
	</script>

<%
String id = (String)session.getAttribute("id");

if(id == null){%>
	<div id="login"><button id="loginBtn" onclick="changeView(1)">로그인</button> | <button id="joinBtn" onclick="changeView(2)">가입</button></div>
	<%
}else{
	NewDAO ndao = NewDAO.getInstance();
	ArrayList<BoardBean> newlist = ndao.getNewComment(id);
	
	gameDAO gdao = gameDAO.getInstance();
	
	int score = gdao.getScore(id);

	
	BoardBean bb = new BoardBean();
	%>
	
	<div id="login"><%=id %>님| 
	<a href="logout.do">:Logout</a>
	<a href="updateForm.do">회원정보수정</a>
	// 게임 최대점수 : <input type="text" name="score" id="score" value="<%=score %>" readonly="readonly">
	<ul><li>
	<%if(newlist.size() == 0){ %>
	<a href="#" id="alarm" style="CURSOR: hand" onclick="alarmFun()">알림</a>
	<%}else{ %>
	<a href="#" id="alarm" style="CURSOR: hand; font-size: 30px; color: red;" onclick="alarmFun()">알림</a>
	<%} %>
	<ul id="alarmText" style="display: none; position: absolute;">
	<%
	for(int i = 0; i < newlist.size(); i++){
		bb = newlist.get(i);
		switch(bb.getBoard_type()){
		case board_Type_notice:
			%>
			<li><a href="content.bo?num=<%=bb.getRep_ref() %>">/<%=bb.getContent() %>/</a></li>
			<%
			break;
		case board_Type_gallery:
			%>
			<li><a href="contentGallery.bo?num=<%=bb.getRep_ref() %>">/<%=bb.getContent() %>/</a></li>
			<%
			break;
		}
	
	
	} %>
	</ul>
	</li></ul>
	</div>
	
	<%
}
%>



<div class="clear"></div>
<!-- 로고들어가는 곳 -->
<div id="logo"><img src="../images/logo.gif" width="265" height="62" alt="Fun Web"></div>
<!-- 로고들어가는 곳 -->
<nav id="top_menu">
<ul>
	<li><a href="#" onclick="changeView(0)">HOME</a></li>
	<li><a href="notice.bo">게시판</a></li>
	<li><a href="../web-desktop/index2.html">게임하기</a></li>
</ul>
</nav>

</header>