<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="board.*"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.File"%>
<%@page import="java.awt.Graphics2D"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.media.jai.JAI"%>
<%@page import="javax.media.jai.RenderedOp"%>
<%@page import="java.awt.image.renderable.ParameterBlock"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	ServletContext context = request.getServletContext();
String imagePath = context.getRealPath("/upload");
int size = 1 * 1024 * 1024 * 10;
String filename = "";
MultipartRequest multi = null;
try {
	multi = new MultipartRequest(request, imagePath, size, "utf-8", new DefaultFileRenamePolicy());

	Enumeration files = multi.getFileNames();
	String file = (String) files.nextElement();
	filename = multi.getFilesystemName(file);
} catch (Exception e) {
	e.printStackTrace();
}

// 썸네일 제작 과정

if(filename != null){

String ext = filename.substring(filename.length() - 3);

if (ext.equals("jpg") || ext.equals("png")) {

	ParameterBlock pb = new ParameterBlock();
	pb.add(imagePath + "/" + filename);
	RenderedOp rOp = JAI.create("fileload", pb);

	BufferedImage bi = rOp.getAsBufferedImage();
	BufferedImage thumb = new BufferedImage(100, 100, BufferedImage.TYPE_INT_RGB);
	Graphics2D g = thumb.createGraphics();
	g.drawImage(bi, 0, 0, 100, 100, null);

	imagePath = context.getRealPath("/image");
	File file = new File(imagePath + "/sm_" + filename);
	ImageIO.write(thumb, "jpg", file);
}
}
// 썸네일 제작 끝
%>
<jsp:useBean id="bb" class="board.BoardBean" />
<%
	Timestamp reg_date = new Timestamp(System.currentTimeMillis());
int type = Integer.parseInt(multi.getParameter("type"));
bb.setName(multi.getParameter("name"));
bb.setContent(multi.getParameter("content"));
bb.setDate(reg_date);
// 이건 다르다. file명은 getParameter가 아님.
bb.setFile(multi.getFilesystemName("file"));
//
bb.setPass(multi.getParameter("pass"));
bb.setReadcount(1);
bb.setSubject(multi.getParameter("subject"));
bb.setRep_lev(0);
bb.setRep_ref(0);
bb.setRep_seq(0);

if(type == 0){
	BoardDAO bdao = new BoardDAO();
	bdao.insertBoard(bb);
	%>
	<script type="text/javascript">
		alert("글쓰기 완료");
		location.href = "notice.bo";
	</script>
	<%
	
}else if(type == 1){
	GalleryDAO gdao = new GalleryDAO();
	gdao.insertGallery(bb);
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