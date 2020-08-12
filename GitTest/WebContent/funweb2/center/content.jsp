<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
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
				<li><a href="notice.bo">자유게시판</a></li>
				<li><a href="gallery.bo">갤러리 게시판</a></li>
				<li><a href="#">Driver Download</a></li>
				<li><a href="#">Service Policy</a></li>
			</ul>
		</nav>
		<!-- 왼쪽메뉴 -->

		<!-- 게시판 -->
		<jsp:useBean id="bb" class="board.BoardBean" />
		<jsp:setProperty property="*" name="bb" />
		<%
			String id = null;
		id = (String) session.getAttribute("id");
		BoardDAO bdao = new BoardDAO();
		bb = bdao.getBoard(bb.getNum());
		bb.setReadcount(bb.getReadcount() + 1);
		bdao.updateBoard(bb);
		session.setAttribute("board", bb);

		HashMap listOpt = (HashMap) session.getAttribute("listOpt");

		StringBuffer sb = new StringBuffer();
		sb.append("?");
		int pageNum = (int) listOpt.get("pageNum");
		sb.append("pageNum=");
		sb.append(pageNum);
		String opt = (String) listOpt.get("opt");
		String condition = (String) listOpt.get("condition");
		if (opt != null) {
			sb.append("&" + "opt=" + opt);
		}

		if (condition != null) {
			sb.append("&" + "condition=" + condition);
		}
		%>

		<script type="text/javascript">
 
 function deleteContent() {
	location.href="contentDeleteForm.bo?num=<%=bb.getNum()%>&type=0";
}
 
 
 function goToNotice() {
	location.href="notice.bo<%=sb.toString()%>";
			}

			function replyContent() {
				location.href = "contentReplyForm.bo?type=0";
			}
		</script>

		<article>
			<div>
				<form action="contentUpdateForm.bo" method="post" id="write">
					<input type="hidden" name="num" value="<%=bb.getNum()%>">
					<table border="1">
						<tr>
							<td align="center">글쓴이</td>
							<td><%=bb.getName()%></td>
							<td>조회수</td>
							<td><%=bb.getReadcount()%></td>
						</tr>
						<tr>
							<td align="center">날짜</td>
							<td><%=bb.getDate()%></td>
						</tr>
						<tr>
							<td align="center">제목</td>
							<td><%=bb.getSubject()%></td>
						</tr>
						<%
							if (bb.getFile() != null) {
						%>
						<tr>
							<td align="center">파일</td>
							<td><a href="../../upload/<%=bb.getFile()%>"><%=bb.getFile()%></a><img
								src="../../upload/<%=bb.getFile()%>" /></td>
						</tr>
						<tr>
							<td align="center">파일 다운</td>
							<td><a href="file_down.jsp?file_name=<%=bb.getFile()%>">다운로드</a></td>
						</tr>

						<%
							}
						%>
						<tr>
							<td align="center">내용</td>
							<td><textarea rows="20" cols="70" name="content"
									readonly="readonly"><%=bb.getContent()%></textarea></td>
						</tr>
						<tr>
							<td colspan="2" align="right">
								<div id="buttons">
									<%
										if (id != null) {
										if (id.equals(bb.getName())) {
											// 뉴스값 수정
											bdao.updateBoard(bb.getNum(), 0);
											//
									%>
									<input type="submit" value="수정" class="submit"><input
										type="button" value="삭제" onclick="deleteContent()">
									<%
										}
									%>
									<input type="button" value="답글" onclick="replyContent()">
									<%
										}
									%>
									<input type="button" value="목록" onclick="goToNotice()">
								</div>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</article>

		<!-- 댓글 -->
		<!-- ~~개의 댓글 -->
		<%
			ArrayList commentList = bdao.getCommentList(bb.getNum());
		int commentCount = commentList.size();

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date currentDate = new Timestamp(System.currentTimeMillis());

		BoardBean cb = new BoardBean();
		%>



		<article>
			<h3><%=commentCount%>개의 댓글
			</h3>
			<div>
				<table border="1">
					<%
						for (int i = 0; i < commentCount; i++) {
						cb = (BoardBean) commentList.get(i);

						if (id != null) {
							if (id.equals(bb.getName())) {
						if (cb.getNews() == 1) {
							bdao.updateNewComment(cb);
						}
							}
						}

						Date commentDate = cb.getDate();
						long caldate = currentDate.getTime() - commentDate.getTime();

						long diffdate = Math.abs(caldate / (24 * 60 * 60 * 1000));

						String dateStr = diffdate + "일 전";

						if (diffdate == 0) { // 시간
							diffdate = Math.abs(caldate / (60 * 60 * 1000));
							dateStr = diffdate + "시간 전";
						}

						if (diffdate == 0) { // 분
							diffdate = Math.abs(caldate / (60 * 1000));
							dateStr = diffdate + "분 전";
						}

						if (diffdate == 0) { // 초
							diffdate = Math.abs(caldate / (1000));
							dateStr = diffdate + "초 전";
						}
					%>
					<tr>
						<td align="center">글쓴이</td>
						<td><%=cb.getName()%></td>
					<tr>
						<td align="center">날짜</td>
						<td><%=dateStr%></td>
					</tr>
					<tr>
						<td align="center">내용</td>
						<td><textarea rows="5" cols="70" name="content"
								readonly="readonly"><%=cb.getContent()%></textarea></td>
					</tr>
					<tr>
						<td colspan="2" align="right">
							<div id="buttons">
								<%
									if (id != null) {
									if (id.equals(cb.getName())) {
								%>
								<input type="submit" value="수정" class="submit">
								<a href="commentDeletePro.bo?ref=<%=bb.getNum()%>&num=<%=cb.getNum()%>&type=0"><input type="button" value="삭제"></a>
								<%
									}
								%>
								<input type="button" value="답글" onclick="#">
								<%
									}
								%>
								<%
									}
								%>
							</div>
				</table>
			</div>
		</article>



		<!-- 댓글 작성 -->
		<%
			if (id != null) {
		%>
		<article>
			<div>
				<form action="contentCommentPro.bo" method="post" id="write">
					<input type="hidden" name="rep_ref" value="<%=bb.getNum()%>">
					<input type="hidden" name="name" value="<%=id%>">
					<table border="1">
						<tr>
							<td><textarea rows="5" cols="70" name="content"></textarea></td>
						</tr>
						<tr>
							<td colspan="2" align="right">
								<div id="buttons">

									<input type="submit" value="등록" class="submit"> <input
										type="button" value="취소" onclick="deleteContent()">
								</div>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</article>
		<%
			}
		%>
		<!-- 댓글 -->
		<!-- 게시판 -->
		<!-- 본문들어가는 곳 -->
		<div class="clear"></div>
		<!-- 푸터들어가는 곳 -->
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
		<!-- 푸터들어가는 곳 -->
	</div>
</body>
</html>