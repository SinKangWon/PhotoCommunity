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
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=o868k3gux3&submodules=geocoder"></script>
<script type="text/javascript"
	src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=o868k3gux3"></script>
	<script>
		$(function() {

			initMap();

		});

		function initMap() {
			var locArr = new Array(); // 지역을 담는 배열 ( 위도경도 )
			<c:forEach  var="ation" items="${listB}">
			locArr.push({
				coordId : "${ation.coordId}",
				latLngX : "${ation.latLngX}",
				latLngY : "${ation.latLngY}"
			});
			</c:forEach>

			let markers = new Array(); // 마커 정보를 담는 배열

			var map = new naver.maps.Map('map', {
				center : new naver.maps.LatLng(37.552758094502494,
						126.98732600494576), //지도 시작 지점
				zoom : 12
			});
			/* 정보창 */


			for (var i = 0; i < locArr.length; i++) {
				// 지역을 담은 배열의 길이만큼 for문으로 마커와 정보창을 채워주자 !

				//let dataB = locArr[i].coords.split(", ");

				/* let x = dataB[0];
				let y = dataB[1]; */

				var marker = new naver.maps.Marker({
					id : locArr[i].coordId,
					map : map,
					position : new naver.maps.LatLng(locArr[i].latLngX, locArr[i].latLngY)
					//position : new naver.maps.LatLng(locArr[i].coords)
					// 지역구의 위도 경도 넣기
				});
// 				console.log("change1");

// 				console.log(marker.id);
				/* 정보창 */


				/*console.log(locArr[i].id + locArr[i].title);*/

				markers.push(marker); // 생성한 마커를 배열에 담는다.

			}
// 			for (var i = 0, ii = markers.length; i < ii; i++) {
// 			naver.maps.Event.addListener(markers[i], 'click', function(e) {
// 				getClickHandler(i);
// 				alert(markers[i]);
// 				});
// 			}


			function getClickHandler(seq) {


				return function(e) { // 마커를 클릭하는 부분
					var marker = markers[seq]; // 클릭한 마커의 시퀀스로 찾는다.
					console.log(marker.id);

					$(".modal-body").empty();

					const table =$("<table>");
					table.addClass("table");
					$(".modal-body").append(table);


					const thead = $("<thead>");
					$(".modal-body table").append(thead);

					const tr = $("<tr>");
					$(".modal-body thead").append(tr);

					const boardId = $("<th>");
					$(".modal-body tr").append(boardId);
					boardId.text("게시물 번호");

					const boardTitle = $("<th>");
					$(".modal-body tr").append(boardTitle);
					boardTitle.text("제목");

					const boardTag = $("<th>");
					$(".modal-body tr").append(boardTag);
					boardTag.text("테그");

					const boardRegDate = $("<th>");
					$(".modal-body tr").append(boardRegDate);
					boardRegDate.text("작성일");

					const boardWriter = $("<th>");
					$(".modal-body tr").append(boardWriter);
					boardWriter.text("작성자");

					const tbody = $("<tbody>");
					$(".modal-body table").append(tbody);


					$.ajax({
						type:'GET',
						url:'/markerDetail/' + marker.id,
						contentType : "application/json",
						dataType : "json",
						success: result => {
							console.log(result);
							result.forEach(item => {
								const tr = $("<tr>");
								$(".modal-body tbody").append(tr);

								const id = $("<td>");
								$(".modal-body tr").append(id);
								id.text(item.id);

								const title = $("<td>");
								$(".modal-body tr").append(title);
								title.text(item.title);

								const tag = $("<td>");
								$(".modal-body tr").append(tag);
								tag.text(item.tag);

								const regDate = $("<td>");
								$(".modal-body tr").append(regDate);
								regDate.text(item.regDate);


								const memberName = $("<td>");
								$(".modal-body tr").append(memberName);
								memberName.text(item.memberName);

								$("#modal-btn").trigger("click");
							})
						}
					})
				}
			}
			for (var i = 0, ii = markers.length; i < ii; i++) {
				naver.maps.Event.addListener(markers[i], 'click',
						getClickHandler(i)); // 클릭한 마커 핸들러

			}
		}
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