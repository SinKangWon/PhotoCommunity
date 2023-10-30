<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Detail</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
<script type="text/javascript" src="/resources/js/bootstrap.bundle.min.js"></script>
<script src="/resources/js/bootstrap.min.js"></script>
  <style>
  footer {
	background: #555;
	color: #fff;
	text-align: center;
	padding: 1%;
}
  #carouselExampleIndicators{
    width: 600px;
    height: 600px;
    margin-left: 2%;
    margin-top: -7%;
    margin-bottom: -10%;
  }
  .carousel-inner{
      width: 100%;
      height: 100%;
  }
  .title
  { margin-left: 2%;
  	margin-top: 1%;
  }
  .almanglee
  {margin-left:35%;
  margin-top: 0%;
  }
  .tag{
  margin-top: 10%;
  margin-left: 2%;
  margin-bottom: 7.8%;
  }
  </style>
</head>
<body>
<header>
		<nav class="navbar navbar-dark bg-dark">
			<div class="container-fluid">
				<a class="navbar-brand" href="/">PhotoCommunity</a>

				<button class="btn" type="button" data-bs-toggle="offcanvas"
					data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">
					<span class="navbar-toggler-icon"></span>
				</button>

			</div>
		</nav>
</header>
	<h1 class="title">제목: ${item.title}</h1>
	<div class="almanglee" style="margin-bottom: 60px">
			<div>내용: ${item.contents}</div>
			
			<div>작성자: ${item.memberName}</div>
			
			<div>작성일: <fmt:formatDate value="${item.regDate}" pattern="yyyy년 MM월 dd일"/></div>
			
			<div>지역: ${item.latLngName}</div>
	</div>
	<div class="offcanvas offcanvas-end" data-bs-backdrop="false"
		tabindex="-1" id="offcanvasRight"
		aria-labelledby="offcanvasRightLabel">
		<div class="offcanvas-header">
			<h5 class="offcanvas-title" id="offcanvasRightLabel">Menu</h5>
			<button type="button" class="btn-close" data-bs-dismiss="offcanvas"
				aria-label="Close"></button>
		</div>
	
		<div class="offcanvas-body">
			<c:if test="${sessionScope.member == null}">
				<!-- Button trigger modal -->
				<div>
					<button type="button" class="btn btn-sm btn-dark"
						data-bs-toggle="modal" data-bs-target="#loginModal">로그인</button>
					<button type="button" class="btn btn-sm btn-dark"
						data-bs-toggle="modal" data-bs-target="#SignUpModal">회원가입</button>
				</div>
			</c:if>
			
			<c:if test="${sessionScope.member != null}">
				<div>
					<div>${sessionScope.member.name}
						<a class="btn btn-dark btn-sm" href="add">게시물 등록</a>
					</div>

				</div>
				<div>
					<a class="btn btn-dark btn-sm" href="logout">로그아웃</a>
				</div>
			</c:if>
		</div>
	</div>
	<div>
  <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="true">
    <div class="carousel-indicators">
      <c:forEach var="attach" items="${item.attachs}" varStatus="status">
					<button type="button" data-bs-target="#carousel"
						data-bs-slide-to="${status.index}"
						class="${status.index == 0 ? 'active' : ''}" aria-current="true"
						aria-label="Slide 1"></button>
				</c:forEach>
    </div> 
    <div class="carousel-inner">
      <c:forEach var="attach" items="${item.attachs}" varStatus="status">
        <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
          <img src="/upload/${attach.filename}" class="d-block w-100">
        </div>
      </c:forEach>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Next</span>
    </button>
  </div>
  <div class="tag">태그:${item.tag}</div>
  </div>
  <!-- side menu modal  -->
  <div class="modal fade" id="loginModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5">LOGIN</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div>
					<form method="post" action="/login">
						<div class="input-group input-group-sm mb-3">
							<span class="input-group-text" id="inputGroup-sizing-sm">ID :</span>
							<input type="text" name="id" class="form-control"
								aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-default">
						</div>

						<div class="input-group input-group-sm mb-3">
							<span class="input-group-text" id="inputGroup-sizing-sm">PW:</span><input type="password" name="passwd"
								class="form-control"
								aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-default">
						</div>

						<div class="form-group mt-3">
							<button class="btn btn-sm btn-outline-dark">로그인</button>
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
	<!-- signup modal  -->
	<div class="modal fade" id="SignUpModal" tabindex="-1">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5">SIGNUP</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div>
					<form name="signup_form" method="post" action="signup">

						<div class="input-group input-group-sm mb-3">
							<span class="input-group-text" id="inputGroup-sizing-sm">아이디:</span>
							<input type="text" name="id" placeholder="아이디를 입력해 주세요"
								class="form-control" aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-default">
							<button type="button" class="btn btn-sm btn-outline-dark"
								onclick="checkId(true)">중복확인</button>
						</div>

						<div class="input-group input-group-sm mb-3">
							<span class="input-group-text" id="inputGroup-sizing-sm">비밀번호:</span>
							<input type="password" name="passwd" class="form-control"
								aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-default">
						</div>

						<div class="input-group input-group-sm mb-3">
							<span class="input-group-text" id="inputGroup-sizing-sm">비밀번호
								확인:</span> <input type="password" name="passwd_valid"
								class="form-control" aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-default">
						</div>

						<div class="input-group input-group-sm mb-3">
							<span class="input-group-text" id="inputGroup-sizing-sm">이름:</span>
							<input type="text" name="name" placeholder="이름을 입력해 주세요"
								class="form-control" aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-default">
						</div>

						<div class="input-group input-group-sm mb-3">
							<span class="input-group-text" id="inputGroup-sizing-sm">Email</span>
							<input type="text" name="email" placeholder="이메일을 입력해 주세요"
								class="form-control" aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-default">
						</div>

						<div class="form-group mt-3">
							<button class="btn btn-sm btn-outline-dark" type="button"
								onclick="signup()">가입하기</button>
							<a href="/"><button class="btn btn-sm btn-outline-dark"
									type="button">취소</button></a>
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
<footer>Copyright(c) KangWon Shin ALL right reserved.</footer>
</html>