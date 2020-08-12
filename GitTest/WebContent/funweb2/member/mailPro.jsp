<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Session"%>
<%@page import="mail.GoogleAuthentication"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
request.setCharacterEncoding("utf-8");
String sender = request.getParameter("sender");
String receiver = request.getParameter("receiver");
String subject = request.getParameter("subject");
String content = request.getParameter("content");
response.setContentType("text/html;charset=UTF-8");
PrintWriter pout = response.getWriter();

try {
	Properties properties = System.getProperties();
	properties.put("mail.smtp.starttls.enable", true);
	properties.put("mail.smtp.host", "smtp.gmail.com");
	properties.put("mail.smtp.auth", "true");
	properties.put("mail.smtp.port", "587");
	Authenticator auth = new GoogleAuthentication();

	Session s = Session.getDefaultInstance(properties, auth);
	Message message = new MimeMessage(s);
	Address sender_address;

	sender_address = new InternetAddress(sender);

	Address receiver_address = new InternetAddress(receiver);
	message.setHeader("content-type", "text/html;charset=UTF-8");
	message.setFrom(sender_address);
	message.addRecipient(Message.RecipientType.TO, receiver_address);
	message.setSubject(subject);
	message.setContent(content, "text/html;charset=UTF-8");
	message.setSentDate(new java.util.Date());
	Transport.send(message);
	out.println("<h3>메일이 정상적으로 전송되었습니다.</h3>");
} catch (Exception e) {
	// TODO Auto-generated catch block
	out.println("SMTP 서버가 잘못 설정되었거나 서비스에 문제가 있소");
	e.printStackTrace();
}

response.sendRedirect("mailForm.jsp");
%>
</head>
<body>



</body>
</html>