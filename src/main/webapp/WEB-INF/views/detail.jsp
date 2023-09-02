<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Detail</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
<script type="text/javascript"
	src="/resources/js/bootstrap.bundle.min.js"></script>
<style>
img {
 width:100px;height: 240px;
}
</style>
</head>
<body>
<div>
	<ul>
		<c:if test="${item.attachs.size() < 1}">
			<li>첨부파일이 없습니다</li>
		</c:if>				
	</ul>
		<div id="carousel" class="carousel slide" data-bs-ride="carousel">
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
			<button class="carousel-control-prev" type="button"	data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"	data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>
	
</div>
</body>
</html>