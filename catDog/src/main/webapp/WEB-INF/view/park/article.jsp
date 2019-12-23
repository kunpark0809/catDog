<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<style type="text/css">
.btn {
	width:70px;
    background-color: #262626;
    border: none;
    color:#ffffff;
    padding: 10px 0;
    text-align: center;
    display: inline-block;
    font-size: 15px;
    margin: 4px;
    border-radius:10px;
}


</style>


<script type="text/javascript">
function deletePark() {
<c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId=='admin2' || sessionScope.member.userId=='admin3'}">
	var q = "recommendNum=${dto.recommendNum}&${query}";
    var url = "<%=cp%>/park/delete?" + q;

    if(confirm("해당 게시물을 삭제하시겠습니까?"))
  	  location.href=url;
</c:if>

<c:if test="${sessionScope.member.userId!='admin' && sessionScope.member.userId!='admin2' && sessionScope.member.userId!='admin3'}">
  alert("해당 게시물을 삭제할 수 없습니다.");
</c:if>
}

function updatePark() {
<c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId=='admin2' || sessionScope.member.userId=='admin3'}">
	var q = "recommendNum=${dto.recommendNum}&page=${page}";
    var url = "<%=cp%>/park/update?" + q;

    location.href=url;
</c:if>

<c:if test="${sessionScope.member.userId!='admin' && sessionScope.member.userId!='admin2' && sessionScope.member.userId!='admin3'}">
   alert("게시물을 수정할 수  없습니다.");
</c:if>
}
</script>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=60c1097ba8f6f767297a53630f9853eb&libraries=services"></script>
<script>
$(function(){
	
	var placeName="${list.get(0).placeName}";
	var addr="${list.get(0).addr}";
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 4 // 지도의 확대 레벨
    };  

	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(addr, function(result, status) {
	
	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {
	
	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords
	        });
	
	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	        var infowindow = new kakao.maps.InfoWindow({
	            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+placeName+'</div>'
	        });
	        infowindow.open(map, marker);
	
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    } 
	});    
	
});
</script>

<script type="text/javascript">
function login() {
	location.href="<%=cp%>/member/login";
}

function ajaxJSON(url, type, query, fn) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			fn(data);
		}
		,beforeSend:function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

function ajaxHTML(url, type, query, selector) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,success:function(data) {
			$(selector).html(data);
		}
		,beforeSend:function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

//페이징 처리
$(function(){
	listPage(1);
});

function listPage(page) {
	var url = "<%=cp%>/park/listRate";
	var query = "rateNum=${dto.rateNum}&pageNo="+page;
	var selector = "#listRate";
	
	ajaxHTML(url, "get", query, selector);
}

//댓글 등록
$(function(){
	$(".btnSendRate").click(function(){
		
		var num=${list.get(0).recommendNum};

		var $tb = $(this).closest("table");
		var content=$tb.find("textarea").val().trim();
		var rate = $("input[name=rate]").val();
		if(!rate)
			rate="0";
		
		if(! content) {
			$tb.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url="<%=cp%>/park/insertRate";
		var query="recommendNum="+num+"&content="+content+"&rate="+rate;
		
		var fn = function(data){
			$tb.find("textarea").val("");
			
			var state=data.state;
			if(state=="true") {
				listPage(1);
			} else if(state=="false") {
				alert("댓글을 추가 하지 못했습니다.");
			}
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});

</script>


<div class="page-section" id="command" style="text-align: center;">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<p class="section-heading text-uppercase" style="font-size: 45px; border-bottom: 3px solid; font-weight: bold; padding-bottom: 30px;">공원/산책</p>
				</div>
				
				
		<table style="width: 98%; margin: 10px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td width="50%" align="left" style="padding-bottom: 20px; padding-left: 20px; font-size: 20px;">
			        ${list.get(0).placeName}
			    </td>
			    <td width="50%" align="right" style="padding-bottom: 20px; font-size: 15px; font-weight: bold;">
			         날짜&nbsp;&nbsp;${list.get(0).created}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;조회수&nbsp;&nbsp;${list.get(0).hitCount}
			    </td>  
			</tr>
			
			<tr>
			<td colspan="2" align="center" style="padding: 10px 5px;">
			<br><br>
			     <c:forEach var="dto" items="${list}">
				<img alt="" src="<%=cp%>/uploads/park/${dto.imageFileName}">
				</c:forEach> 
			  </td>
			</tr>

			<tr>
			  <td colspan="2" align="center" style="padding: 10px 5px;" valign="top" height="50">
			       ${list.get(0).content}
			       <br><br>
			   </td>
			</tr>
			
			<tr align="left">
			  <td>
			      <p style="font-weight: bold; font-size: 18px;">전화번호&nbsp;&nbsp;&nbsp;&nbsp;${list.get(0).tel}</p>
			      <p style="font-weight: bold; font-size: 18px;">주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소&nbsp;&nbsp;&nbsp;&nbsp;${list.get(0).addr}</p>
			   <br>
			   </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc; border-top: 1px solid #cccccc;">
				<td colspan="2" align="center" style="padding-top: 10px; padding-bottom: 10px;">
				<div id="map" style="width: 100%; height: 500px;">
				</div>
				</td>
			</tr>
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			    <br><br>
			       <i class="fas fa-chevron-up"></i>&nbsp;&nbsp;
			         <c:if test="${not empty preReadPark}">
			              <a style="color: #A66E4E" href="<%=cp%>/park/article?${query}&recommendNum=${preReadPark.recommendNum}">${preReadPark.placeName}</a>
			        </c:if>
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			       <i class="fas fa-chevron-down"></i>&nbsp;&nbsp;
			         <c:if test="${not empty nextReadPark}">
			              <a style="color: #A66E4E" href="<%=cp%>/park/article?${query}&recommendNum=${nextReadPark.recommendNum}">${nextReadPark.placeName}</a>
			        </c:if>
			    </td>
			</tr>
			</table>
		
	
			<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
			<tr height="45">
			    <td align="center">
			    <br>
			        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/park/list?${query}';">목록</button>
			    </td>
			 </table>  
			 
			 
			 <table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;"> 
			 <tr>
			    <td align="right">
			       <c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId=='admin2' || sessionScope.member.userId=='admin3'}">				    
			          <button type="button" class="btn" onclick="updatepark();">수정</button>
			       </c:if>
			       <c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId=='admin2' || sessionScope.member.userId=='admin3'}">				    
			          <button type="button" class="btn" onclick="deletepark();">삭제</button>
			       </c:if>
			    </td>
			</tr>
			</table>
			
					 
		<table style='width: 100%; margin: 15px auto 0px; border-spacing: 0px;'>
			<tr height='30'> 
				 <td align='left' >
				 	<span style='font-weight: bold;' >한줄평쓰기</span><span> - 해당 장소와 관련없는 댓글은 관리자에 의해 삭제될 수 있습니다.</span>
				 </td>
			</tr>
			
			<tr>
			   	<td align="left" style='padding:5px 5px 0px;'>
			   	
			   		  <label><input type="text" name="rate"></label>
				      
					<textarea class='boxTA' style='width:100%; height: 70px;'></textarea>
			    </td>
			</tr>
			<tr>
			   <td align='right'>
			        <button type='button' class='btn btnSendRate' data-num='10' style="padding:10px 10px; font-size: 12px;">등록하기</button>
			    </td>
			 </tr>
		</table>
		     
		<div id="listRate"></div>
 
   	 </div>
	  
			
    	</div>
    </div>

