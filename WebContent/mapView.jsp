<%@ page contentType ="text/html; charset=utf-8" errorPage="/error.jsp"%>

<!-- Modal -->
 
	<div id="mapModal" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	
	    <!-- Modal content-->
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h3 class="modal-title"></h3>
	      </div>
	      <div class="modal-body">
	        <div id="map" style="margin:auto;width:100%;"></div>
	      </div>
	      <div class="modal-footer">
	      	<div id="spec" style="float:left;"></div>
	        <button style="float:right;"id="btnClose" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	
	  </div>
	</div>

	