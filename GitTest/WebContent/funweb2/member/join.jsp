<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="../js/jquery-3.5.1.js"></script>
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
 <%
 session.setAttribute("startCheck", false);
 session.setAttribute("dubCheck", false);
 %>
 
 <script type="text/javascript">
    
        // 회원가입 화면의 입력값들을 검사한다.
        $(document).ready(function() {
		$('#join').submit(function(){
			var id=$('#id').val();
			var pass=$('#pass').val();

//          id가 비어있으면  "아이디입력하세요" 포커스 focus()
			if(id==''){
				//alert('아이디입력하세요');
				$('#div_id').html('아이디 입력하세요');
				$('#id').focus();
				// submit기능을 중지
				return false;
			}
//          pass가 비어있으면  "비밀번호입력하세요" 포커스 focus()
			if(pass==''){
				$('#div_pass').html('비밀번호 입력하세요');
				$('#pass').focus();
				// submit기능을 중지
				return false;
			}
			
			var name = $('#name').val();
			
			if(name == ''){
				$('#div_name').html('이름 입력하세요');
				$('#name').focus();
				// submit기능을 중지
				return false;
			}
			// 성별 선택안하면 "성별선택하세요" 포커스 
			// $('#man').is(":checked") => true/false
// 			alert($('#man').is(":checked"));
			if($('#man').is(":checked")==false && $('#woman').is(":checked")==false){
				alert('성별선택하세요');
				$('#man').focus();
				// submit기능을 중지
				return false;
			}
		});
		
		
		$('.dup').click(function(){
			$.ajax('idCheckPro2.jsp',
					{
			data:{
				userId:$('#id').val()
			},
			success:function(returndata){
				$('#div_id').html(returndata);
			}
					})
		});
	});
        
        
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
            
            if(form.email.value != form.email2.value){
                alert("메일 주소를 동일하게 입력하세요.");
                form.email2.focus();
                return false;
            }
            
            
            
            return true;
        }
        
        // 취소 버튼 클릭시 첫화면으로 이동
        function goFirstForm() {
            location.href="main.do";
        }    
        
        // 아이디 중복체크 화면open
        function openIdChk(){
            window.name = "parentForm";
            window.open("IdCheckForm.do?userId=" + document.userInfo.id.value,
                    "chkForm", "width=500, height=300, resizable = no, scrollbars = no");   
         
        }
 
        // 아이디 입력창에 값 입력시 hidden에 idUncheck를 세팅한다.
        // 이렇게 하는 이유는 중복체크 후 다시 아이디 창이 새로운 아이디를 입력했을 때
        // 다시 중복체크를 하도록 한다.
        function inputIdChk(){
            document.userInfo.idDuplication.value ="idUncheck";
        }
        
</script>
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
<form action="joinPro.do" method="post" id="join" name="userInfo">
<fieldset>
<legend>Basic Info</legend>
<label>User ID</label>
<input type="text" name="id" id="id" class="id" maxlength="20" onkeydown="inputIdChk()">
<input type="button" value="중복 체크" class="dup"><div id="div_id" style="float: right; width: 40%; color: red;"></div><br>
<input type="hidden" name="idDuplication" value="idCheck">
<label>Password</label>
<input type="password" name="pass" id="pass" maxlength="50"><div id="div_pass" style="float: right; width: 40%; color: red;"></div><br>
<label>Retype Password</label>
<input type="password" name="pass2" maxlength="50"><br>
<label>Name</label>
<input type="text" name="name" id="name" maxlength="10"><div id="div_name" style="float: right; width: 40%; color: red;"></div><br>
<label>E-Mail</label>
<input type="email" name="email" maxlength="40"><br>
<label>Retype E-Mail</label>
<input type="email" name="email2" maxlength="40"><br>
</fieldset>

<fieldset>
<legend>Optional</legend>
<label>Address</label>
<input type="text" id="sample4_postcode" name="postcodeAddress" placeholder="우편번호">
<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
<input type="text" id="sample4_roadAddress" name="roadAddress" placeholder="도로명주소">
<input type="text" id="sample4_jibunAddress" name="jibunAddress" placeholder="지번주소">
<span id="guide" style="color:#999;display:none"></span>
<input type="text" id="sample4_detailAddress" name="detailAddress" placeholder="상세주소">
<input type="text" id="sample4_extraAddress" name="extraAddress" placeholder="참고항목">

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
<input type="text" name="phone" maxlength="40"><br>
<label>Mobile Phone Number</label>
<input type="text" name="mobile" maxlength="40"><br>
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