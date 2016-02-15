<%@ page contentType="text/html; charset=utf-8" errorPage="/error.jsp" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="favicon.ico" rel="icon" type="image/x-icon" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
	
	<!-- Optional theme -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">
	
	<!-- Latest compiled and minified JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
	<script type="text/javascript" src="http://openapi.map.naver.com/openapi/v2/maps.js?clientId=Fb6yUt0Z8Dy9KXt8oNtc"></script>
	<meta charset="utf-8">
	<title>성남사랑가맹점 검색서비스</title>
</head>
<body>

	<!-- 네비게이션 바 -->
	<nav class="navbar navbar-inverse">
		  <div class="container-fluid">
		    <div class="navbar-header">
		      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#menu-navbar">
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		      </button>
		        <a class="navbar-brand" href="/ApiTest">성남사랑 상품권 가맹점</a>
		    </div>
		      <div class="collapse navbar-collapse" id="menu-navbar">
		        <ul class="nav navbar-nav">
		        </ul>
		        <ul class="nav navbar-nav navbar-right">
		          <li><a href="/ApiTest"><span class="glyphicon glyphicon-home"></span>홈으로</a></li>      
		        </ul>
		      </div>
		  </div>
		</nav>
	<!-- 네비게이션 바 끝 -->
	
	<!-- 컨테이너 -->
	<div class="container">
	
		<div class="jumbotron">
			<div style="text-align:center">
				<h3>찾으실 업종을 선택하고 동 이름을 입력하세요.</h3>
				<h4>모바일에선 검색결과에서 전화번호를 누르면 전화로 연결되고
				주소를 누르면 해당 매장의 지도가 나옵니다.</h4>
			</div>
		</div>
		
	
	<sql:setDataSource var="apiData" driver="com.mysql.jdbc.Driver"
	     url="jdbc:mysql://dbinstance.cmpfvsw5d4kz.ap-northeast-1.rds.amazonaws.com:3306/api"
	     user="admin"  password="dbadministrator"/>
	     
	<div id="form-section" align="center">
		<form method="get" name="searchForm" action="/ApiTest" role="form" class="form-horizontal">
			<div class="form-group">
				<!-- <select name="choice" class="form-control">
					<option value="searchDong">동</option>
					<option value="searchName">상호</option>
				</select> -->
			
				<label class="control-label col-sm-4">업종</label>
				<div class="col-sm-4">
					<select name="category" class="form-control ">
					<c:forEach items="${category}" var="cate">
						<c:choose>
							<c:when test="${cate == param.category}" >
							<option value="${cate}" selected>${cate}</option>
							</c:when>
							<c:otherwise>
							<option value="${cate}">${cate}</option>
							</c:otherwise>
						</c:choose>
						
					</c:forEach>
					</select>
				</div>
			</div>
				
			<div class="form-group">
				<label class="control-label col-sm-4">찾을 주소</label>
				<div class="col-sm-4" >
					<input type="text" name="searchValue" value="${param.searchValue }" class="form-control col-sm-10" placeholder="동을 입력하세요." required/>
				</div>
			</div>
				<p></p>
			<div class="form-group">
				<div class="col-sm-offset-4 col-sm-4">
      				<button type="submit" class="btn btn-success btn-block">찾기</button>
    			</div>
			</div>
					
		</form>
	</div>
		<!-- 
		<c:if test="${param.choice == 'searchName' }">
			<sql:query dataSource="${apiData}" var="result">
		 		SELECT *
		 		FROM apiTable where val002 like "%${param.searchValue}%" AND val005="${param.category}";
		 	</sql:query>
		</c:if>
		-->
		
		<!--<c:if test="${param.choice == 'searchDong' }">
			<sql:query dataSource="${apiData}" var="result">
		 		SELECT *
		 		FROM apiTable where val004 like "%${param.searchValue}%" AND val005="${param.category}";
		 	</sql:query>
		</c:if>-->
		
		<sql:query dataSource="${apiData}" var="result">
	 		SELECT *
	 		FROM apiTable where val004 like "%${param.searchValue}%" AND val005="${param.category}";
	 	</sql:query>
	
	 	<c:if test="${param.searchValue != null && param.searchValue != \"\"}">
	 	<div class="table-responsive" style="overflow:auto;height:500px;" >
	 	 	<table class="table table-striped table-hover">
		 		<thead>
		 			<tr>
		 				<th>상호</th>
		 				<th>전화번호</th>
		 				<th>주소</th>
		 				<th>분류</th>
		 			</tr>
		 		</thead>
		 		
		 		<tbody >
		 		
		 			<c:forEach items="${result.rows }" var="row">
		 			
		 			<tr>
		 				<td data-toggle="modal" data-target="#mapModal" data-name="${row.val002}" data-addr="${row.val004}" data-phone="${row.val003 }">
		 					<c:out value="${row.val002 }" /> </td>
		 				<td>
		 					<c:choose>
		 						<c:when test="${fn:startsWith(row.val003,'0')}">
		 							<a href="tel:${row.val003}"><c:out value="${row.val003 }" /></a>
		 						</c:when>
		 						<c:otherwise>
		 							<a href="tel:031${row.val003}"><c:out value="${row.val003 }" /></a>
		 						</c:otherwise>
		 					</c:choose>
		 					
		 					
		 				</td>
		 				<td data-toggle="modal" data-target="#mapModal" data-name="${row.val002}" data-addr="${row.val004}" data-phone="${row.val003 }">
		 					<c:out value="${row.val004 }" />
		 				</td>
		 				<td><c:out value="${row.val005 }" /> </td>
		 			</tr>
		 			</c:forEach>
		 			
		 		
		 		</tbody>
		 	</table>
	 	</div>
	 	</c:if>
	 	
	 	
	 	<jsp:include page="/mapView.jsp" flush="false" />
	 	
	 	<script type="text/javascript">
			
	 		var x, y;
	 		var oPoint = new nhn.api.map.LatLng();
	        var defaultLevel = 12;
	        var oMap = new nhn.api.map.Map(document.getElementById('map'), { 
	                                        point : oPoint,
	                                        zoom : defaultLevel,
	                                        enableWheelZoom : true,
	                                        enableDragPan : true,
	                                        enableDblClickZoom : false,
	                                        mapMode : 0,
	                                        activateTrafficMap : false,
	                                        activateBicycleMap : false,
	                                        minMaxLevel : [ 1, 14 ], 
	                                        size: new nhn.api.map.Size(300, 200)   
	        								});
	      //줌 슬라이더 
	        var oSlider = new nhn.api.map.ZoomControl();
	        oMap.addControl(oSlider);
	        oSlider.setPosition({
	                top : 10,
	                left : 10
	        });
			
	        //지도 타입 버튼 
	        var oMapTypeBtn = new nhn.api.map.MapTypeBtn();
	        oMap.addControl(oMapTypeBtn);
	        oMapTypeBtn.setPosition({
	                bottom : 10,
	                right : 80
	        });
	        
	        //주제별 지도 버튼
	        var oThemeMapBtn = new nhn.api.map.ThemeMapBtn();
	        oThemeMapBtn.setPosition({
	                bottom : 10,
	                right : 10
	        });
	        oMap.addControl(oThemeMapBtn);
	
	        var oSize = new nhn.api.map.Size(28, 37);
	        var oOffset = new nhn.api.map.Size(14, 37);
	        var oIcon = new nhn.api.map.Icon('http://static.naver.com/maps2/icons/pin_spot2.png', oSize, oOffset);
	
	        var oInfoWnd = new nhn.api.map.InfoWindow();
	        oInfoWnd.setVisible(false);
	        oMap.addOverlay(oInfoWnd);
	
	        oInfoWnd.setPosition({
	                top : 20,
	                left :20
	        });
	
	        var oLabel = new nhn.api.map.MarkerLabel(); // - 마커 라벨 선언.
	        
	        oMap.addOverlay(oLabel); // - 마커 라벨 지도에 추가. 기본은 라벨이 보이지 않는 상태로 추가됨.
	       
	        
	        oInfoWnd.attach('changeVisible', function(oCustomEvent) {
	                if (oCustomEvent.visible) {
	                        oLabel.setVisible(true);
	                }
	        });
	        
	
	        oMap.attach('mouseenter', function(oCustomEvent) {
	
	                var oTarget = oCustomEvent.target;
	                // 마커위에 마우스 올라간거면
	                if (oTarget instanceof nhn.api.map.Marker) {
	                        var oMarker = oTarget;
	                        oLabel.setVisible(true, oMarker); // - 특정 마커를 지정하여 해당 마커의 title을 보여준다.
	                }
	        });
	
	        oMap.attach('mouseleave', function(oCustomEvent) {
	
	                var oTarget = oCustomEvent.target;
	                // 마커위에서 마우스 나간거면
	                if (oTarget instanceof nhn.api.map.Marker) {
	                        oLabel.setVisible(false);
	                }
	        });
	        
	        var oMarker = new nhn.api.map.Marker(oIcon);
	        oMap.addOverlay(oMarker);
	        
			$('#mapModal').on('show.bs.modal',function(event) {
				var td = $(event.relatedTarget);
				var name = td.data('name');
				var addr = td.data('addr');
				var phone = td.data('phone');
					
				if (!phone.startsWith('0',0)) {
					phone = "031-" + phone;
				}
				
				$(this).find('.modal-title').text(name);
				$(this).find('.modal-footer #spec')
						.html("<b>주소:</b> " + addr )
						.append("<br/><b>전화번호:</b> <a href='tel:"+phone+"'>"+ phone + "</a>");
				
				$.ajax({
					url: "/ApiTest",
					method: "POST",
					data: {address : addr},
				}).done(function(json){
					if(json != null) {
						//console.log(json);
						var obj = JSON.parse(JSON.stringify(json));	
						x = obj.result.items[0].point.x;
						y = obj.result.items[0].point.y;
						
						oPoint.set(x,y);
						oMap.setCenterAndLevel(oPoint,11);
						
						oMarker.setTitle(name);
			            oMarker.setPoint(oPoint);
					}
					else
						alert("json is null!");
					
				})
			})

		</script>
	 	 
	</div>
	<!-- 컨테이너 끝 -->
	
	<!-- 풋터 -->
	<footer class="footer">
		<div class="container">
			<hr />
			<p class="text-muted">&copy;2016 Copyrights <a href="mailto:pitou_106@naver.com">JackCme</a></p>
		</div>
	</footer>
	<!-- 풋터 끝 -->
</body>


	

</html>