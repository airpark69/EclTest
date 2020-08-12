<%@ page import="member.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>아이디 중복 체크</title>
<style type="text/css">
#wrap {
	width: 490px;
	text-align: center;
	margin: 0 auto 0 auto;
}

#chk {
	text-align: center;
}

#cancelBtn {
	visibility: visible;
}

#useBtn {
	visibility: hidden;
}
</style>
<%
	String id = request.getParameter("userId");
%>
<script type="text/javascript">
   
        // 아이디 중복체크
        function idCheck(){
 
            var id = document.getElementById("userId").value;
            
            document.getElementById("cancelBtn").style.visibility='visible';
            document.getElementById("useBtn").style.visibility='hidden';
            document.getElementById("msg").innerHTML ="";
            if (!id) {
                alert("아이디를 입력하지 않았습니다.");
                return false;
            } 
            else if((id < "0" || id > "9") && (id < "A" || id > "Z") && (id < "a" || id > "z")){ 
                alert("한글 및 특수문자는 아이디로 사용하실 수 없습니다.");
                document.getElementById("userId").value = "";
                return false;
            }
            else
            {
            	
                
            }
            
            return true;
        }
        
        function callback(){
            if(httpRequest.readyState == 4){
                // 결과값을 가져온다.
                var resultText = httpRequest.responseText;
                if(resultText == 0){
                    alert("사용할수없는 아이디입니다.");
                    document.getElementById("cancelBtn").style.visibility='visible';
                    document.getElementById("useBtn").style.visibility='hidden';
                    document.getElementById("msg").innerHTML ="";
                } 
                else if(resultText == 1){ 
                    document.getElementById("cancelBtn").style.visibility='hidden';
                    document.getElementById("useBtn").style.visibility='visible';
                    document.getElementById("msg").innerHTML = "사용 가능한 아이디입니다.";
                }
            }
        }
        
        // 사용하기 클릭 시 부모창으로 값 전달 
        function sendCheckValue(){
            // 중복체크 결과인 idCheck 값을 전달한다.
            opener.document.userInfo.idDuplication.value ="idCheck";
            // 회원가입 화면의 ID입력란에 값을 전달
            opener.document.userInfo.id.value = document.getElementById("userId").value;
            
            if (opener != null) {
                opener.chkForm = null;
                self.close();
            }    
        }    
   </script>

</head>
<body>
	<div id="wrap">
		<br> <b><font size="4" color="gray">아이디 중복체크</font></b>
		<hr size="1" width="460">
		<br>
		<div id="chk">
			<form id="checkForm" action="idCheckPro.do"
				onsubmit="return idCheck()">
				<input type="text" name="userId" id="userId" value="<%=id%>">
				<input type="submit" value="중복확인">
			</form>
			<div id="msg"></div>
			<br> <input id="cancelBtn" type="button" value="취소"
				onclick="window.close()"><br> <input id="useBtn"
				type="button" value="사용하기" onclick="sendCheckValue()">
		</div>
	</div>

	<%
		boolean startCheck = (boolean) session.getAttribute("startCheck");
	if (startCheck) {
		session.setAttribute("startCheck", false);
	} else {
		session.setAttribute("dubCheck", false);
	}
	boolean dubCheck = (boolean) session.getAttribute("dubCheck");
	if (dubCheck) {
	%>
	<script type="text/javascript">
	   document.getElementById("cancelBtn").style.visibility='hidden';
       document.getElementById("useBtn").style.visibility='visible';
       document.getElementById("msg").innerHTML = "사용 가능한 아이디입니다.";
	   </script>
	<%
		} else {
	%>
	<script type="text/javascript">
	   document.getElementById("cancelBtn").style.visibility='visible';
       document.getElementById("useBtn").style.visibility='hidden';
       document.getElementById("msg").innerHTML ="";
	   
	   </script>

	<%
		}
	%>

	

</body>
</html>