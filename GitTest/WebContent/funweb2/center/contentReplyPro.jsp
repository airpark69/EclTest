<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.sql.Timestamp"%>
<%@ page import="board.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	// request.setCharacterEncoding("utf-8");
String uploadPath = request.getRealPath("/upload");

System.out.println(uploadPath);

int maxSize = 10 * 1024 * 1024;

//한글 "utf-8"
//동일이름변경 DefaultFileRenamePolicy()
MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());
%>
<jsp:useBean id="bb" class="board.BoardBean" />
<%
	Timestamp reg_date = new Timestamp(System.currentTimeMillis());

int type = Integer.parseInt(multi.getParameter("type"));
int lev = Integer.parseInt(multi.getParameter("rep_lev"));
int ref = Integer.parseInt(multi.getParameter("rep_ref"));
int seq = Integer.parseInt(multi.getParameter("rep_seq"));
bb.setRep_lev(lev);
bb.setRep_ref(ref);
bb.setRep_seq(seq);

if (type == 0) {
	BoardDAO bdao = new BoardDAO();
	bdao.updateRep_seq(bb);

	bb.setName(multi.getParameter("name"));
	bb.setContent(multi.getParameter("content"));
	bb.setDate(reg_date);
	// 이건 다르다. file명은 getParameter가 아님.
	bb.setFile(multi.getFilesystemName("file"));
	//
	bb.setPass(multi.getParameter("pass"));
	bb.setReadcount(1);
	bb.setSubject(multi.getParameter("subject"));

	bb.setRep_ref(ref);
	bb.setRep_lev(lev + 1);
	bb.setRep_seq(seq + 1);

	bdao.insertBoard(bb);
%>

<script type="text/javascript">
	alert("글쓰기 완료");
	location.href = "notice.bo";
</script>

<%
	} else if (type == 1) {
	GalleryDAO bdao = new GalleryDAO();
	bdao.updateRep_seq(bb);

	bb.setName(multi.getParameter("name"));
	bb.setContent(multi.getParameter("content"));
	bb.setDate(reg_date);
	// 이건 다르다. file명은 getParameter가 아님.
	bb.setFile(multi.getFilesystemName("file"));
	//
	bb.setPass(multi.getParameter("pass"));
	bb.setReadcount(1);
	bb.setSubject(multi.getParameter("subject"));

	bb.setRep_ref(ref);
	bb.setRep_lev(lev + 1);
	bb.setRep_seq(seq + 1);

	bdao.insertGallery(bb);
%>
<script type="text/javascript">
	alert("글쓰기 완료");
	location.href = "gallery.bo";
</script>
<%
	}
%>

</head>
<body>



</body>
</html>