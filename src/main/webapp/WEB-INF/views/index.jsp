<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>board(기본)</title>
<style>
footer {
	background: #555;
	color: #fff;
	text-align: center;
	padding: 1%;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet">

<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
<script type="text/javascript"
	src="/resources/js/bootstrap.bundle.min.js"></script>
<!-- <script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=o868k3gux3&submodules=geocoder"></script>
 -->	<script type="text/javascript" 
	src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=o868k3gux3"></script>

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
	<div id="map" style="width: 100%; height: 850px;"></div>


	<div id="modal"></div>
	<div style="display: none">
		<button id="modal-btn" type="button" class="btn btn-primary d-hidden"
			data-bs-toggle="modal" data-bs-target="#exampleModal">숨겨진 모달
			버튼</button>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">

		<div class="modal-dialog modal-dialog-centered modal-xl">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">게시물 목록</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>

				<div id="map" style="width: 30px; height: 50px;"></div>
				<div class="modal-body">
					<table class="table">

					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
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
							<span class="input-group-text" id="inputGroup-sizing-sm">Id:</span>
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
		<div class="modal-dialog">
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
	<footer>Copyright(c) KangWon Shin ALL right reserved.</footer>
</body>
</html>