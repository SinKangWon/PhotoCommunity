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