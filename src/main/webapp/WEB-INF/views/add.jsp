<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<style>
footer {
	background: #555;
	color: #fff;
	text-align: center;
	padding: 1%;
}
</style>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=o868k3gux3&submodules=geocoder"></script>

<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript"
	src="/resources/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="/resources/summernote/summernote-lite.css" rel="stylesheet">
<script src="/resources/summernote/summernote-lite.js"></script>
<script src="/resources/summernote/lang/summernote-ko-KR.js"></script>
<script>
	
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
					data-bs-toggle="modal" data-bs-target="#loginModal">로그인
				</button>
			</div>
		</c:if>

		<c:if test="${sessionScope.member != null}">
			<div>
				<div>${sessionScope.member.name}</div>
			</div>
				<div><a class="btn btn-dark btn-sm" href="logout">로그아웃</a></div>
		</c:if>
		</div>
	</div>
	
	<div class="search">
		<input id="address" type="text" placeholder="주소 검색 후 알림창 복사"> <input
			id="submit" type="button" value="주소검색">
			
		<button type="button" class="btn btn-sm btn-outline-warning"
			data-bs-toggle="modal" data-bs-target="#addModal">등록</button>

	</div>
	<div id="map" style="height: 818px; width:100%;"></div>
	<div>
		</div>
	<div class="modal fade" id="addModal" tabindex="-1">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5">게시물 등록</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div>
					<form method="post" enctype="multipart/form-data">
						<div class="form-group">
							<label class="form-label">주소:</label> <input type="text"
								name="latLngName" class="form-control form-control-sm">
						</div>

						<div class="form-group">
							<label class="form-label">위도:</label> <input type="text"
								name="latLngX" class="form-control form-control-sm">
						</div>
						
						<div class="form-group">
							<label class="form-label">경도:</label> <input type="text"
								name="latLngY" class="form-control form-control-sm">
						</div>
						

						<div class="form-group">
							<label class="form-label">제목:</label> <input type="text"
								name="title" class="form-control form-control-sm">
						</div>

						<div class="form-group">
							<label class="form-label">내용:</label>
							<textarea id="summernote" name="contents"></textarea>
						</div>

						<div class="form-group">
							<label class="form-label">태그:</label> <input type="text"
								name="tag" class="form-control form-control-sm">
						</div>

						<div class="form-group">
							<label>첨부파일:
								<button type="button" id="add"
									class="btn btn-sm btn-primary mt-2 mb-2">추가</button>
							</label>
							<div id="attachs">
								<div class="input-group mb-3">
									<input type="file" name="attach"
										class="form-control form-control-sm">
								</div>
							</div>
						</div>

						<div class="form-group mt-3">
							<button class="btn btn-sm btn-primary">등록</button>
							<a href="list"><button type="button"
									class="btn btn-sm btn-secondary">취소</button></a>
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
	<!-- Modal -->
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
	<footer>Copyright(c) KangWon Shin ALL right reserved.</footer>
</body>
<script>
	//지도를 그려주는 함수 실행
	selectMapList();

	//검색한 주소의 정보를 insertAddress 함수로 넘겨준다.
	function searchAddressToCoordinate(address) {
		naver.maps.Service
				.geocode(
						{
							query : address
						},
						function(status, response) {
							if (status === naver.maps.Service.Status.ERROR) {
								return alert('Something Wrong!');
							}
							if (response.v2.meta.totalCount === 0) {
								return alert('올바른 주소를 입력해주세요.');
							}
							var htmlAddresses = [], item = response.v2.addresses[0], point = new naver.maps.Point(
									item.x, item.y);
							if (item.roadAddress) {
								htmlAddresses.push('[도로명 주소] '
										+ item.roadAddress);
							}
							if (item.jibunAddress) {
								htmlAddresses.push('[지번 주소] '
										+ item.jibunAddress);
							}
							if (item.englishAddress) {
								htmlAddresses.push('[영문명 주소] '
										+ item.englishAddress);
							}

							insertAddress(item.roadAddress, item.x, item.y);

						});
	}

	// 주소 검색의 이벤트
	$('#address').on('keydown', function(e) {
		var keyCode = e.which;
		if (keyCode === 13) { // Enter Key
			searchAddressToCoordinate($('#address').val());
		}
	});
	$('#submit').on('click', function(e) {
		e.preventDefault();
		searchAddressToCoordinate($('#address').val());
	});
	naver.maps.Event.once(map, 'init_stylemap', initGeocoder);

	function initGeocoder() {
		map.addListener('click', function(e) {
			searchCoordinateToAddress(e.coord);
		});

		$('#address').on('keydown', function(e) {
			var keyCode = e.which;

			if (keyCode === 13) { // Enter Key
				searchAddressToCoordinate($('#address').val());
			}
		});

		$('#submit').on('click', function(e) {
			e.preventDefault();

			searchAddressToCoordinate($('#address').val());
		});

		var marker = new naver.maps.Marker({
			position : position,
			map : map
		});

		naver.maps.Event.addListener(map, 'click', function(e) {
			marker.setPosition(e.coord);
		});
		searchAddressToCoordinate('정자동 178-1');
	}

	//검색정보를 테이블로 작성해주고, 지도에 마커를 찍어준다.
	function insertAddress(address, latitude, longitude) {

		$('input[name=latLngName]').attr('value', address);
		$('input[name=latLngName]').attr('readonly', true);
		$('input[name=latLngX]').attr('value',longitude);
		$('input[name=latLngX]').attr('readonly', true);
		$('input[name=latLngY]').attr('value',latitude);
		$('input[name=latLngY]').attr('readonly', true);


		var map = new naver.maps.Map('map', {
			center : new naver.maps.LatLng(longitude, latitude),
			zoom : 14
		});
		var marker = new naver.maps.Marker({
			map : map,
			position : new naver.maps.LatLng(longitude, latitude),
		});
	}

	//지도를 그려주는 함수
	function selectMapList() {

		var map = new naver.maps.Map('map', {
			center : new naver.maps.LatLng(37.3595704, 127.105399),
			zoom : 10
		});
	}

	// 지도를 이동하게 해주는 함수
	function moveMap(len, lat) {
		var mapOptions = {
			center : new naver.maps.LatLng(len, lat),
			zoom : 15,
			mapTypeControl : true
		};
		var map = new naver.maps.Map('map', mapOptions);
		var marker = new naver.maps.Marker({
			position : new naver.maps.LatLng(len, lat),
			map : map
		});
	}

	$(function() {
		$("#summernote").summernote({
			lang : 'ko-KR' // default: 'en-US'
		});

		$("#attachs").on("click", ".delete", function() {
			const div = $(this).closest(".input-group");
			div.remove();
		});

		$("#add").click(function() {
			const div = $("<div>");
			div.addClass("input-group");
			div.addClass("mb-3");

			const input = $("<input>");
			input.attr("type", "file");
			input.attr("name", "attach");
			input.addClass("form-control");
			input.addClass("form-control-sm");

			const button = $("<button>");
			button.attr("type", "button");
			button.addClass("btn");
			button.addClass("btn-sm");
			button.addClass("btn-outline-danger");
			button.addClass("delete");
			button.text("삭제");

			div.append(input);
			div.append(button);

			$("#attachs").append(div);
		});
	});
</script>
</html>