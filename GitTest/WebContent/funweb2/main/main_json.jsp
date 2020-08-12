<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="member.MemberBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
JSONArray boardList=new JSONArray();

for(int x = 0; x < pageBoardList.size(); x++){
	bb = (BoardBean)pageBoardList.get(x);
	JSONObject mb=new JSONObject();
	
	mb.put("num", bb.getNum());
	mb.put("subject", bb.getSubject());
	mb.put("name", bb.getName());
	mb.put("date", sdf.format(bb.getDate()));
	mb.put("readcount", bb.getReadcount());
	
	boardList.add(mb);
}

%>

<%=boardList %>