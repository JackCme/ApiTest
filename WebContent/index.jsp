<%@ page contentType="text/html; charset=utf-8" errorPage="/error.jsp" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
	
	<!-- Optional theme -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">
	
	<!-- Latest compiled and minified JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
	<script type="text/javascript" src="http://openapi.map.naver.com/openapi/v2/maps.js?clientId=Fb6yUt0Z8Dy9KXt8oNtc"></script>
	<meta charset="utf-8">
	<title>Insert title here</title>
</head>
<body>

	<nav class="navbar navbar-inverse">
		  <div class="container-fluid">
		    <div class="navbar-header">
		      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#menu-navbar">
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		      </button>
		        <a class="navbar-brand" href="/ApiTest">Menu</a>
		    </div>
		      <div class="collapse navbar-collapse" id="menu-navbar">
		        <ul class="nav navbar-nav">
		        </ul>
		        <ul class="nav navbar-nav navbar-right">
		          <li><a href="/ApiTest"><span class="glyphicon glyphicon-home"></span>Home</a></li>
		       
		        </ul>
		      </div>
		  </div>
		</nav>


<div class="container">

<sql:setDataSource var="apiData" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://dbinstance.cmpfvsw5d4kz.ap-northeast-1.rds.amazonaws.com:3306/api"
     user="admin"  password="dbadministrator"/>
     
	<h1>Hello JSP!</h1>
	
	<p>Total API data count = <c:out value="${totalCount }" /> </p>
	
	<form method="get" name="searchForm" action="/ApiTest" class="">
		<select name="choice">
			<option value="searchName">상호</option>
			<option value="searchDong">동</option>
		</select>
		<input type="text" name="searchValue" />
		<input type="submit" value="찾기" />
		
	</form>
	
	<c:if test="${param.choice == 'searchName' }">
		<sql:query dataSource="${apiData}" var="result">
	 		SELECT *
	 		FROM apiTable where val002 like "%${param.searchValue}%";
	 	</sql:query>
	</c:if>
	
	<c:if test="${param.choice == 'searchDong' }">
		<sql:query dataSource="${apiData}" var="result">
	 		SELECT *
	 		FROM apiTable where val004 like "%${param.searchValue}%";
	 	</sql:query>
	</c:if>
	
	
 	<c:if test="${param.searchValue != null && param.searchValue != \"\"}">
 	<div class="table-responsive">
 	 	<table class="table table-striped table-hover">
	 		<thead>
	 			<tr>
	 				<th>상호</th>
	 				<th>전화번호</th>
	 				<th>주소</th>
	 				<th>분류</th>
	 			</tr>
	 		</thead>
	 		
	 		<tbody>
	 			<c:forEach items="${result.rows }" var="row">
	 			<tr>
	 				<td><c:out value="${row.val002 }" /> </td>
	 				<td><a href="tel:+8231${row.val003}"><c:out value="${row.val003 }" /></a></td>
	 				<td><c:out value="${row.val004 }" /> </td>
	 				<td><c:out value="${row.val005 }" /> </td>
	 			</tr>
	 			</c:forEach>
	 			
	 		
	 		</tbody>
	 	</table>
 
 	</div>
	
 	</c:if>
 	<div id="map" style="border:1px solid #000;"></div>
	
 	 
</div>
 	<script type="text/javascript">
 		var form = document.searchForm;
 		var d = form.dong;
 		var g = form.gu;
 		
 		$("#searchBtn").click(function() {
 			alert("구: " + g.options[g.selectedIndex].value + "\n동: " + d.options[d.selectedIndex].value);
 		});
 		
 	</script>
 	
 	<!-- 
	<script type="text/javascript">
                var oSeoulCityPoint = new nhn.api.map.LatLng(37.5675451, 126.9773356);
                var defaultLevel = 11;
                var oMap = new nhn.api.map.Map(document.getElementById('map'), { 
                                                point : oSeoulCityPoint,
                                                zoom : defaultLevel,
                                                enableWheelZoom : true,
                                                enableDragPan : true,
                                                enableDblClickZoom : false,
                                                mapMode : 0,
                                                activateTrafficMap : false,
                                                activateBicycleMap : false,
                                                minMaxLevel : [ 1, 14 ],
                                                size : new nhn.api.map.Size(800, 480)           });
                
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
                
                var oPolyline = new nhn.api.map.Polyline([], {
                        strokeColor : '#f00', // - 선의 색깔
                        strokeWidth : 5, // - 선의 두께
                        strokeOpacity : 0.5 // - 선의 투명도
                }); // - polyline 선언, 첫번째 인자는 선이 그려질 점의 위치. 현재는 없음.
                oMap.addOverlay(oPolyline); // - 지도에 선을 추가함.

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

                oMap.attach('click', function(oCustomEvent) {
                        var oPoint = oCustomEvent.point;
                        var oTarget = oCustomEvent.target;
                        oInfoWnd.setVisible(false);
                        // 마커 클릭하면
                        if (oTarget instanceof nhn.api.map.Marker) {
                                // 겹침 마커 클릭한거면
                                if (oCustomEvent.clickCoveredMarker) {
                                        return;
                                }
                                // - InfoWindow에 들어갈 내용은 setContent로 자유롭게 넣을 수 있습니다. 외부 css를 이용할 수 있으며, 
                                // - 외부 css에 선언된 class를 이용하면 해당 class의 스타일을 바로 적용할 수 있습니다.
                                // - 단, DIV의 position style은 absolute가 되면 안되며, 
                                // - absolute의 경우 autoPosition이 동작하지 않습니다. 
                                oInfoWnd.setContent('<DIV style="border-top:1px solid; border-bottom:2px groove black; border-left:1px solid; border-right:2px groove black;margin-bottom:1px;color:black;background-color:white; width:auto; height:auto;">'+
                                        '<span style="color: #000000 !important;display: inline-block;font-size: 12px !important;font-weight: bold !important;letter-spacing: -1px !important;white-space: nowrap !important; padding: 2px 5px 2px 2px !important">' + 
                                        'Hello World <br /> ' + oTarget.getPoint()
                                        +'<span></div>');
                                oInfoWnd.setPoint(oTarget.getPoint());
                                oInfoWnd.setPosition({right : 15, top : 30});
                                oInfoWnd.setVisible(true);
                                oInfoWnd.autoPosition();
                                return;
                        }
                        var oMarker = new nhn.api.map.Marker(oIcon, { title : '마커 : ' + oPoint.toString() });
                        oMarker.setPoint(oPoint);
                        oMap.addOverlay(oMarker);

                        var aPoints = oPolyline.getPoints(); // - 현재 폴리라인을 이루는 점을 가져와서 배열에 저장.
                        aPoints.push(oPoint); // - 추가하고자 하는 점을 추가하여 배열로 저장함.
                        oPolyline.setPoints(aPoints); // - 해당 폴리라인에 배열에 저장된 점을 추가함
                });
        </script>
 -->



</body>


	

</html>