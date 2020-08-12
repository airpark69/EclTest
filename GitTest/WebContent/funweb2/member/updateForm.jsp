<%@ page import="member.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<title>회원정보 수정</title>

 <script type="text/javascript">
    
        // 회원가입 화면의 입력값들을 검사한다.
        function checkValue()
        {
            var form = document.userInfo;
        
            if(!form.id.value){
                alert("아이디를 입력하세요.");
                form.id.focus();
                return false;
            }
            
            if(form.idDuplication.value != "idCheck"){
                alert("아이디 중복체크를 해주세요.");
                return false;
            }
            // 패스워드부터 만들면 됨.
            if(!form.pass.value){
                alert("비밀번호를 입력하세요.");
                form.pass.focus();
                return false;
            }
            
            // 비밀번호와 비밀번호 확인에 입력된 값이 동일한지 확인
            if(form.pass.value != form.pass2.value){
                alert("비밀번호를 동일하게 입력하세요.");
                form.pass2.focus();
                return false;
            }    
            
            if(!form.name.value){
                alert("이름을 입력하세요.");
                form.name.focus();
                return false;
            }
            
            if(!form.email.value){
                alert("메일 주소를 입력하세요.");
                form.email.focus();
                return false;
            }
            
            
            
            return true;
        }
        
        // 취소 버튼 클릭시 첫화면으로 이동
        function goFirstForm() {
            location.href="main.do";
        }    
        
 
</script>
<%
String id = (String)session.getAttribute("id");

MemberDAO mdao = new MemberDAO();

MemberBean mb = mdao.getMember(id);
// 내일 업데이트 폼 -> 디자인 변경하고 -> 어드레스값 변환
%>
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="#">Join us</a></li>
<li><a href="#">Privacy policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>Join Us</h1>
<form action="updatePro.do" method="post" id="join" name="userInfo" onsubmit="return checkValue()">
<fieldset>
<legend>Basic Info</legend>
<label>User ID</label>
<input type="text" name="id" class="id" value="<%=mb.getId()%>" readonly="readonly"><br>
<label>Password</label>
<input type="password" name="pass" maxlength="50"><br>
<label>Retype Password</label>
<input type="password" name="pass2" maxlength="50"><br>
<label>Name</label>
<input type="text" name="name" value="<%=mb.getName() %>" maxlength="10"><br>
<label>E-Mail</label>
<input type="email" name="email" value="<%=mb.getEmail() %>" maxlength="40"><br>
</fieldset>

<fieldset>
<legend>Optional</legend>
<label>Address</label>
<input type="text" id="sample4_postcode" name="postcodeAddress" placeholder="우편번호" value="<%=mb.getPostcodeAddress() %>">
<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
<input type="text" id="sample4_roadAddress" name="roadAddress" placeholder="도로명주소" value="<%=mb.getRoadAddress() %>">
<input type="text" id="sample4_jibunAddress" name="jibunAddress" placeholder="지번주소" value="<%=mb.getJibunAddress() %>">
<span id="guide" style="color:#999;display:none"></span>
<input type="text" id="sample4_detailAddress" name="detailAddress" placeholder="상세주소" value="<%=mb.getDetailAddress() %>">
<input type="text" id="sample4_extraAddress" name="extraAddress" placeholder="참고항목" value="<%=mb.getExtraAddress() %>">

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>

<label>Phone Number</label>
<input type="text" name="phone" value="<%=mb.getPhone() %>" maxlength="40"><br>
<label>Mobile Phone Number</label>
<input type="text" name="mobile" value="<%=mb.getMobile() %>" maxlength="40"><br>
</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="Submit" class="submit">
<input type="button" value="Cancel" class="cancel" onclick="goFirstForm()">
</div>
</form>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>