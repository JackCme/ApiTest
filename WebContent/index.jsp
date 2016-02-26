<%@ page contentType="text/html; charset=utf-8" errorPage="/error.jsp" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="naver-site-verification" content="f36fb770dcfd342363658e4ce6cf3a77fb8a9ec8"/>
    <meta name="keywords" content="성남사랑가맹점,성남사랑상품권,성남사랑상품권가맹점,성남사랑" />
    <meta name="description" content="성남사랑상품권 가맹점 검색서비스" />
    <link href="https://s3.ap-northeast-2.amazonaws.com/icon-storage/favicon.ico" rel="shortcut icon" type="image/x-icon" />

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
	
	<script type="text/javascript" src="http://openapi.map.naver.com/openapi/v2/maps.js?clientId=Fb6yUt0Z8Dy9KXt8oNtc"></script>
	
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.11/css/dataTables.bootstrap.min.css"/>
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/fixedheader/3.1.1/css/fixedHeader.bootstrap.min.css"/>
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/responsive/2.0.2/css/responsive.bootstrap.min.css"/>
 
	<script type="text/javascript" src="https://cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="https://cdn.datatables.net/1.10.11/js/dataTables.bootstrap.min.js"></script>
	<script type="text/javascript" src="https://cdn.datatables.net/fixedheader/3.1.1/js/dataTables.fixedHeader.min.js"></script>
	<script type="text/javascript" src="https://cdn.datatables.net/responsive/2.0.2/js/dataTables.responsive.min.js"></script>
	<script type="text/javascript" src="https://cdn.datatables.net/responsive/2.0.2/js/responsive.bootstrap.min.js"></script>


	<meta charset="utf-8">
	<title>성남사랑가맹점 검색서비스</title>
	<style>
                a.back-to-top {
                        display: none;
                        width: 50px;
                        height: 50px;
                        text-indent: -9999px;
                        position: fixed;
                        z-index: 999;
                        right: 20px;
                        bottom: 20px;
                        background: #1ABC9C url("https://s3.ap-northeast-2.amazonaws.com/icon-storage/up-arrow.png") no-repeat center 43%;
                        -webkit-border-radius: 30px;
                        -moz-border-radius: 30px;
                        border-radius: 30px;
                }
                #entries-table > thead th, #entries-table > tbody td, .table > thead th  {
                	text-align: center;
                }
                .navbar { 
                	background: #1ABC9C;
                	color: white;
                 }
                 
                 .navbar-brand {
                 	color:white;
                 	font-weight:bold;
                 }
                 .icon-bar {
                 	background: white;
                 }
          
        </style>
	
</head>
<body>
	
	<a href="#" class="back-to-top">Back to Top</a>
	
	<!-- 네비게이션 바 -->
	<nav class="navbar">
		  <div class="container-fluid">
		    <div class="navbar-header">
		      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#menu-navbar">
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		      </button>
		        <a class="navbar-brand" href="/">성남사랑 상품권 가맹점</a>
		    </div>
		      <div class="collapse navbar-collapse" id="menu-navbar">
		        <ul class="nav navbar-nav">
		        </ul>
		        <ul class="nav navbar-nav navbar-right">
		          <li><a href="/" style="color:white"><span class="glyphicon glyphicon-home"></span>홈으로</a></li>      
		        </ul>
		      </div>
		  </div>
		</nav>
	<!-- 네비게이션 바 끝 -->
	
	<!-- 컨테이너 -->
	<div class="container">
	
		<div class="jumbotron">
			<div style="text-align:center">
				<h3>찾으실 동, 상호명 또는 품목을 선택하세요.</h3>
				<h4>모바일에선 검색결과에서 전화번호를 누르면 전화로 연결되고
				주소나 상호명을 누르면 해당 매장의 지도가 나옵니다.</h4>
			</div>
		</div>
		
	
	<sql:setDataSource var="apiData" driver="com.mysql.jdbc.Driver"
	     url="jdbc:mysql://dbinstance.cmpfvsw5d4kz.ap-northeast-1.rds.amazonaws.com:3306/api"
	     user="admin"  password="dbadministrator"/>
	     
	<div id="form-section" align="center">
		<form method="get" name="searchForm" action="/" role="form" class="form-horizontal">
			<div class="form-group">
				<label class="control-label col-sm-4">선택</label>
				<div class="col-sm-4">
					<select id="formChoice" name="choice" class="form-control">
						<option value="searchDong">동</option>
						<option value="searchName">상호</option>
						<option value="searchGenre">품목</option>
					</select>
				</div>
			</div>
				
			<div id="formSection" class="form-group">
			
				<label class="control-label col-sm-4">찾을 주소</label>
				<div class="col-sm-4" >
					<input type="text" name="dongValue" value="${param.dongValue }" class="form-control col-sm-10" placeholder="동을 입력하세요." required/>
				</div>
				
			</div>

			<div id="genreForm" class="form-group" style="display:none;">
				<label class="control-label col-sm-4">찾을 품목</label>
				<div class="col-sm-4" >
					<select name="genreValue" class="form-control ">
					<c:forEach items="${genres}" var="genre">
						
							<c:if test="${genre eq param.genre}" >
							<option value="${genre}" selected>${genre}</option>
							</c:if>
							<c:if test="${genre ne param.genre }">
							<option value="${genre}">${genre}</option>
							</c:if>
						
						
					</c:forEach>
					</select>
				</div>
			</div>
		
			
				<p></p>
			<div class="form-group">
				<div class="col-sm-offset-4 col-sm-4">
      				<button type="submit" class="btn btn-block">찾기</button>
    			</div>
			</div>
					
		</form>
	</div>
	
	<script type="text/javascript">
	
		$('#formChoice').change(function() {
			if ( $('#formChoice').val() === 'searchName' ) {
				$('#formSection').empty().show();
				$('#formSection').html(
						'<label class="control-label col-sm-4">찾을 상호</label>'+
						'<div class="col-sm-4" >'+
							'<input type="text" name="nameValue" value="${param.nameValue }" class="form-control col-sm-10" placeholder="상호명을 입력하세요." required/>' +
						'</div>');
				$('#genreForm').hide();
			}
			
			if ( $('#formChoice').val() === 'searchDong' ) {
				$('#formSection').empty().show();
				$('#formSection').html(
						'<label class="control-label col-sm-4">찾을 주소</label>'+
						'<div class="col-sm-4" >'+
							'<input type="text" name="dongValue" value="${param.dongValue }" class="form-control col-sm-10" placeholder="동을 입력하세요." required/>' +
						'</div>');
				$('#genreForm').hide();
			}
			
			if ( $('#formChoice').val() === 'searchGenre' ) {
				$('#formSection').empty().css('display', 'none');
				
				$('#genreForm').show();
			}
		})
		
	</script>
		
		<c:if test="${param.choice == 'searchName' }">
			<sql:query dataSource="${apiData}" var="result">
		 		SELECT *
		 		FROM newApi where name like "%${param.nameValue}%";
		 	</sql:query>
		</c:if>
		
		
		<c:if test="${param.choice == 'searchDong' }">
			<sql:query dataSource="${apiData}" var="result">
		 		SELECT *
		 		FROM newApi where dong like "%${param.dongValue}%";
		 	</sql:query>
		</c:if>
		
		<c:if test="${param.choice == 'searchGenre' }">
			<sql:query dataSource="${apiData}" var="result">
		 		SELECT *
		 		FROM newApi where genre like "${param.genreValue}";
		 	</sql:query>
		</c:if>
		
		<c:if test="${param.choice != null }" >
		<div style="overflow-x: auto;">
	 	 	<table id="entries-table" class="table table-hover" >
		 		<thead style="background:#1ABC9C;color:white;text-align:center">
		 			<tr>
		 				<th style="overflow-x:auto; white-space:nowrap">상호</th>
		 				<th style="overflow-x:auto; white-space:nowrap">전화번호</th>
		 				<th style="overflow-x:auto; white-space:nowrap" >주소</th>
		 				<c:if test="${param.choice ne 'searchGenre' }">
		 				<th>품목</th>
		 				</c:if>
		 			</tr>
		 		</thead>
				<tbody >
		 		
		 			<c:forEach items="${result.rows }" var="row">
		 			
		 			<tr>
		 				<td data-toggle="modal" data-target="#mapModal" 
		 					data-name="${row.name}" data-addr="${row.address}" 
		 					data-phone="${row.phone }" data-ceo="${row.ceo }"
		 					data-category="${row.category }" data-genre="${row.genre }">
		 					
		 					<c:out value="${row.name }" /> </td>
		 				<td>
		 					<c:choose>
		 						<c:when test="${fn:startsWith(row.phone,'0')}">
		 							<a href="tel:${row.phone}"><c:out value="${row.phone }" /></a>
		 						</c:when>
		 						<c:otherwise>
		 							<a href="tel:031${row.phone}"><c:out value="${row.phone }" /></a>
		 						</c:otherwise>
		 					</c:choose>
		 					
		 					
		 				</td>
		 				<td data-toggle="modal" data-target="#mapModal" 
		 					data-name="${row.name}" data-addr="${row.address}" 
		 					data-phone="${row.phone }" data-ceo="${row.ceo }"
		 					data-category="${row.category }" data-genre="${row.genre }"
		 					>
		 					
		 					<c:out value="${row.address }" />
		 				</td>
		 				<c:if test="${param.choice ne 'searchGenre' }" >
		 				<td><c:out value="${row.genre }" /> </td>
		 				</c:if>
		 			</tr>
		 			</c:forEach>
		 			
		 		
		 		</tbody>
		 	</table>
		 
		</div>
	 	</c:if>

	 	<script type="text/javascript">
	 	
	 	
	 	
	 		$(document).ready(function() {
	 			var table = $("#entries-table").dataTable({
		 				searching: false,
		 				paging: false,
		 				info: false,
		 				"language" : {
		 					"url" : "//cdn.datatables.net/plug-ins/1.10.11/i18n/Korean.json"
		 				}
	 			});
	 			
	 			new $.fn.dataTable.FixedHeader( table );
	 			
	 			 
	 		})
	 		
	 	
	 	
	 	</script>
	 	
	 	
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
	      /*
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
	        */
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
				var ceo = td.data('ceo');
				var category = td.data('category');
				var genre = td.data('genre');
					
				if (!phone.startsWith('0',0)) {
					phone = "031-" + phone;
				}
				
				$(this).find('.modal-title').text(name);
				$(this).find('.modal-footer #spec')
						.html("<b>주소:</b> " + addr )
						.append("<br/><b>전화번호:</b> <a href='tel:"+phone+"'>"+ phone + "</a>")
						.append("<br/><b>대표자:</b> " + ceo)
						.append("<br/><b>업종:</b> " + category)
						.append("<br/><b>품목:</b> " + genre);
						
						
				
				$.ajax({
					url: "/",
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
			
			 var amountScrolled = 200;

             $(window).scroll(function() {
                     if ( $(window).scrollTop() > amountScrolled ) {
                             $('a.back-to-top').fadeIn('slow');
                     } else {
                             $('a.back-to-top').fadeOut('slow');
                     }
             });

             $('a.back-to-top').click(function() {
                     $('html, body').animate({
                             scrollTop: 0
                     }, 700);
                     return false;
             });


		</script>
	 	 
	</div>
	<!-- 컨테이너 끝 -->
	
	<!-- 풋터 -->
        <footer class="footer">
                <div class="container">
                        <hr />
                        <p class="text-muted">&copy;2016 Copyrights <a href="mailto:pitou_106@naver.com">JackCme</a>
                        <br />
                        <br />

                                불편한 사항이나 개선해야 할 사항들은 <a href="mailto:pitou_106@naver.com">pitou_106@naver.com</a> 으로 메일주시면 감사하겠습니다. <br />
                                해당 서비스는 <a href="http://data.seongnam.go.kr/">성남공공데이터</a>API 기반으로 제공되
어 만들어졌습니다.
                        </p>

                </div>
        </footer>
        <!-- 풋터 끝 -->

</body>


	

</html>