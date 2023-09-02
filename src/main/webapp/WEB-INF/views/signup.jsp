<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet">

<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
<script type="text/javascript"
	src="/resources/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<script>
   let isCheck;

   function checkId(mode) {
      if(document.signup_form.id.value == "") {
         alert("중복검사 전에 아이디를 입력 해 주세요");         
         return;
      }
      
      if(mode)
         checkId_Async();
      else
         checkId_Sync();
   }
   
   function checkId_Sync() {
      const form = document.signup_form;
      
      const xhr = new XMLHttpRequest();
      
      xhr.open("GET", "checkId/" + form.id.value, false);
      
      xhr.send();
      
      const result = xhr.responseText;
      console.log("[동기] 응답: " + result);
      
      if(result == "OK") {
         isCheck = form.id.value;
         alert("[동기] 사용 가능한 아이디 입니다");
      } else
         alert("[동기] 이미 사용중인 아이디 입니다");
   }
   
   function checkId_Async() {
      const form = document.signup_form;
      
      const xhr = new XMLHttpRequest();
      
      xhr.onreadystatechange = function() {
         console.log(xhr.readyState);
         
         if(xhr.readyState == XMLHttpRequest.DONE) {
            if(xhr.status == 200) {
               const result = xhr.responseText;
               console.log("[비동기] 응답: " + result);
               
               if(result == "OK") {
                  isCheck = form.id.value;
                  alert("[비동기] 사용 가능한 아이디 입니다");
               } else
                  alert("[비동기] 이미 사용중인 아이디 입니다");
            }
         }
      };
      
      xhr.open("GET", "checkId/" + form.id.value, true);
      
      xhr.send();
   }

   function signup() {
      const form = document.signup_form;
      
      if(isCheck != form.id.value) {
         alert("아이디 중복 검사를 하셔야 합니다");
         return;
      }
      
      if(form.id.value == "") {
         alert("아이디를 입력 해 주세요");
         form.id.focus();
         return;
      }
      
      if(form.passwd.value == "") {
         alert("비밀번호를 입력 해 주세요");
         form.passwd.focus();
         return;
      }
      
      if(form.passwd_valid.value == "") {
         alert("비밀번호 확인을 입력 해 주세요");
         form.passwd_valid.focus();
         return;
      }
      
      if(form.passwd.value != form.passwd_valid.value) {
         alert("비밀번호가 일치하지 않습니다");
         form.passwd.focus();
         return;
      }
      
      if(form.name.value == "") {
         alert("이름을 입력 해 주세요");
         form.name.focus();
         return;
      }
      
      form.submit();
   }
</script>
</head>
<body>
      <div>
         <h3>회원가입</h3>
      </div>
      <div>
		<button type="button" class="btn btn-sm btn-primary"
		data-bs-toggle="modal" data-bs-target="#SignUpModal">회원가입</button>
	  </div>
	  
	  <div class="modal fade" id="SignUpModal" tabindex="-1">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5">SIGNUP</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>		
     	 <div>
         <form name="signup_form" method="post">    
              
            <div class="form_group">
               <label>아이디:</label>
               <input type="text" name="id" placeholder="아이디를 입력해 주세요">
               <button type="button" onclick="checkId(false)">[동기] 중복확인</button>
               <button type="button" onclick="checkId(true)">[비동기] 중복확인</button>
            </div>
            
            <div class="form_group">
               <label>비밀번호:</label>
               <input type="password" name="passwd">
            </div>
            
            <div class="form_group">
               <label>비밀번호 확인:</label>
               <input type="password" name="passwd_valid">
            </div>
            
            <div class="form_group">
               <label>이름:</label>
               <input type="text" name="name" placeholder="이름을 입력해 주세요">
            </div>
            
            <div class="form_group">
               <label>E-mail:</label>
               <input type="text" name="email" placeholder="이메일을 입력해 주세요">
            </div>
            
            <div class="form-group mt-3">
               <button type="button" onclick="signup()">가입하기</button>
               <a href="/"><button type="button">취소</button></a>
            </div>
         </form>         
      </div>
				<div class="modal-footer">
					<button type="button" class="btn btn-sm btn-secondary"
						data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>