<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<footer>
<hr>
<div id="copy">All contents Copyright 2011 FunWeb 2011 FunWeb 
Inc. all rights reserved<br>
<a href="questionForm.do">문의 메일</a></div>
<div id="count">
오늘의 방문자 수 : <%=session.getAttribute("todayCount") %><br>
총 방문자 수 : <%=session.getAttribute("totalCount") %> </div>
<div id="social"><img src="../images/facebook.gif" width="33" 
height="33" alt="Facebook">
<img src="../images/twitter.gif" width="34" height="34"
alt="Twitter"></div>
</footer>