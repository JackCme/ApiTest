<%@ page contentType ="text/html; charset=utf-8" errorPage="/error.jsp"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="org.apache.http.HttpEntity, 
				org.apache.http.client.HttpClient,
				org.apache.http.HttpResponse,
				org.apache.http.client.methods.HttpGet,
				org.apache.http.impl.client.HttpClientBuilder,
				org.apache.http.util.EntityUtils" %>


<%
	String clientId = "Fb6yUt0Z8Dy9KXt8oNtc";
	String clientSecret = "uNk8ZBCBp_";
	String encoded = URLEncoder.encode("성남시 분당구 야탑동 342-1", "UTF-8");
	String url = "https://openapi.naver.com/v1/map/geocode?query=" + encoded;
 
	HttpClient client = HttpClientBuilder.create().build();
	HttpGet req = new HttpGet(url);
	 
	req.addHeader("X-Naver-Client-Id", clientId);
	req.addHeader("X-Naver-Client-Secret", clientSecret);
	HttpResponse res = client.execute(req);
	 
	HttpEntity res_entity = res.getEntity();
	String res_string = EntityUtils.toString(res_entity);
	 
	//request.setAttribute("res_string", res_string);


%>
<!-- Modal -->
 
	<div id="mapModal" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	
	    <!-- Modal content-->
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title"></h4>
	      </div>
	      <div class="modal-body">
	      	<%= request.getParameter("idx") %>
	        <div id="map" style="border:1px solid #000;"></div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	
	  </div>
	</div>
	
 	<iframe width=0 name="frame" height=0 frameborder=0 scrolling="no" ></iframe>
 	<form name="frame_form" method="post" action=""></form>
 	
 	
	