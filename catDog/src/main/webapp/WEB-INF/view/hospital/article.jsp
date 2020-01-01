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

.star-input>.input,
.star-input>.input>label:hover,
.star-input>.input>input:focus+label,
.star-input>.input>input:checked+label{display: inline-block;vertical-align:middle;background:url('<%=cp%>/resource/img/star.png')no-repeat;}
.star-input{white-space:nowrap;width:225px;height:40px;line-height:30px;}
.star-input>.input{width:150px;background-size:150px;height:28px;white-space:nowrap;overflow:hidden;position: relative;}
.star-input>.input>input{position:absolute;width:1px;height:1px;opacity:0;}
.star-input>.input.focus{outline:1px dotted #ddd;}
.star-input>.input>label{width:30px;height:0;padding:28px 0 0 0;overflow: hidden;float:left;cursor: pointer;position: absolute;top: 0;left: 0;}
.star-input>.input>label:hover,
.star-input>.input>input:focus+label,
.star-input>.input>input:checked+label{background-size: 150px;background-position: 0 bottom;}
.star-input>.input>label:hover~label{background-image: none;}
.star-input>.input>label[for="p1"]{width:30px;z-index:5;}
.star-input>.input>label[for="p2"]{width:60px;z-index:4;}
.star-input>.input>label[for="p3"]{width:90px;z-index:3;}
.star-input>.input>label[for="p4"]{width:120px;z-index:2;}
.star-input>.input>label[for="p5"]{width:150px;z-index:1;}
.star-input>output{display:inline-block;width:60px; font-size:18px;text-align:right; vertical-align:middle;}

</style>


<script type="text/javascript">
function deleteHospital(recommendNum) {
	<c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId=='admin2' || sessionScope.member.userId=='admin3'}">
	var q = "recommendNum="+recommendNum+"&${query}";
    var url = "<%=cp%>/hospital/delete?" + q;

    if(confirm("위 게시물을 삭제 하시겠습니까 ? "))
  	  location.href=url;
</c:if>    
<c:if test="${sessionScope.member.userId!='admin' && sessionScope.member.userId!='admin2' && sessionScope.member.userId!='admin3'}">
  alert("게시물을 삭제할 수  없습니다.");
</c:if>
}

function updateHospital(recommendNum) {
	<c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId=='admin2' || sessionScope.member.userId=='admin3'}">
	var q = "recommendNum="+recommendNum+"&page=${page}";
    var url = "<%=cp%>/hospital/update?" + q;

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
	
	var placeName="${dto.placeName}";
	var addr="${dto.addr}";
	
	var mapContainer = document.getElementById('map'), 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), 
        level: 4 
    };  

	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	var geocoder = new kakao.maps.services.Geocoder();
	
	geocoder.addressSearch(addr, function(result, status) {
	
	     if (status === kakao.maps.services.Status.OK) {
	
	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords
	        });
	
	        var infowindow = new kakao.maps.InfoWindow({
	            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+placeName+'</div>'
	        });
	        infowindow.open(map, marker);
	
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
	var url = "<%=cp%>/hospital/listRate";
	var query = "recommendNum=${dto.recommendNum}&pageNo="+page;
	var selector = "#listRate";
	
	ajaxHTML(url, "get", query, selector);
}

//한줄평 등록
$(function(){
	$(".btnSendRate").click(function(){
		
		var num=${dto.recommendNum};

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
		
		var url="<%=cp%>/hospital/insertRate";
		var query="recommendNum="+num+"&content="+content+"&rate="+rate;
	
		var fn = function(data){
			$tb.find("textarea").val("");
			
			var state=data.state;
			if(state=="true") {
				listPage(1);
			} else if(state=="false") {
				alert("별점을 선택한 뒤 한줄평 등록이 가능합니다.");
			}
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});

//한줄평 삭제
$(function(){
	$("body").on("click", ".deleteRate", function(){
		if(! confirm("한줄평을 삭제하시겠습니까 ? ")) {
		    return false;
		}
		
		var rateNum=$(this).attr("data-rateNum");
		var page=$(this).attr("data-pageNo");
		
		var url="<%=cp%>/hospital/deleteRate";
		var query="rateNum="+rateNum;
		
		var fn = function(data){
			// var state=data.state;
			listPage(page);
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});

</script>

<script type="text/javascript">
$(function(){
	var $star = $(".star-input"),
    $result = $("input[name=rate]");
	
  	$(document)
	    .on("focusin", ".star-input>.input", 
		    function(){
   		       $(this).addClass("focus");
 	    })
	    .on("focusout", ".star-input>.input", function(){
		    var $this = $(this);
		    setTimeout(function(){
      		    if($this.find(":focus").length === 0){
       			  $this.removeClass("focus");
     	 	    }
    		 }, 100);
  	    })
	    .on("change", ".star-input :radio", function(){
		    $result.val($(this).next().text());
	    })
	    .on("mouseover", ".star-input label", function(){
		    $result.val($(this).text());
	    })
	    .on("mouseleave", ".star-input>.input", function(){
		    var $checked = $star.find(":checked");
		    if($checked.length === 0){
			    $result.val("0");
		    } else {
			    $result.val($checked.next().text());
		    }
	    });
});
</script>

<div class="page-section" id="command" style="text-align: center;">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<p class="section-heading text-uppercase" style="font-size: 45px; font-weight: bold;">동물병원</p>
				</div>
				
				
		<table style="width: 98%; margin: 10px auto 0px; border-spacing: 0px; border-collapse: collapse; border-top: 3px solid;">
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td width="50%" align="left" style="padding-bottom: 20px; padding-top:20px; padding-left: 20px; font-size: 20px;">
			        ${dto.placeName}
			    </td>
			    <td width="50%" align="right" style="padding-bottom: 20px; padding-top:20px; font-size: 15px; font-weight: bold;">
			         날짜&nbsp;&nbsp;${dto.created}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;조회수&nbsp;&nbsp;${dto.hitCount}
			    </td>  
			</tr>
			
			<tr>
			<td colspan="2" align="center" style="padding: 10px 5px;">
			<br><br>
				<img alt="" src="<%=cp%>/uploads/hospital/${dto.imageFileName}">

			  </td>
			</tr>

			<tr>
			  <td colspan="2" align="center" style="padding: 10px 5px;" valign="top" height="50">
			       ${dto.content}
			       <br><br>
			   </td>
			</tr>
			
			<tr align="left">
			  <td>
			      <p style="font-weight: bold; font-size: 18px;">전화번호&nbsp;&nbsp;&nbsp;&nbsp;${dto.tel}</p>
			      <p style="font-weight: bold; font-size: 18px;">주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소&nbsp;&nbsp;&nbsp;&nbsp;${dto.addr}</p>
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
			         <c:if test="${not empty preReadHospital}">
			              <a style="color: #A66E4E" href="<%=cp%>/hospital/article?${query}&recommendNum=${preReadHospital.recommendNum}">${preReadHospital.placeName}</a>
			        </c:if>
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			       <i class="fas fa-chevron-down"></i>&nbsp;&nbsp;
			         <c:if test="${not empty nextReadHospital}">
			              <a style="color: #A66E4E" href="<%=cp%>/hospital/article?${query}&recommendNum=${nextReadHospital.recommendNum}">${nextReadHospital.placeName}</a>
			        </c:if>
			    </td>
			</tr>
			</table>
		
	
			<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
			<tr height="45">
			    <td align="center">
			    <br>
			        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/hospital/list?${query}';">목록</button>
			    </td>
			 </table>  
			 
			 
			 <table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;"> 
			 <tr>
			    <td align="right">
			       <c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId=='admin2' || sessionScope.member.userId=='admin3'}">				    
			         <button type="button" class="btn" onclick="updateHospital('${dto.recommendNum}');">수정</button>
			       </c:if>
			       <c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId=='admin2' || sessionScope.member.userId=='admin3'}">				    
			         <button type="button" class="btn" onclick="deleteHospital('${dto.recommendNum}');">삭제</button>
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
					<span class="star-input">
						<span class="input">
					    	<input type="radio" name="star_input" value="1" id="p1">
					    	<label for="p1">1</label>
					    	<input type="radio" name="star_input" value="2" id="p2">
					    	<label for="p2">2</label>
					    	<input type="radio" name="star_input" value="3" id="p3">
					    	<label for="p3">3</label>
					    	<input type="radio" name="star_input" value="4" id="p4">
					    	<label for="p4">4</label>
					    	<input type="radio" name="star_input" value="5" id="p5">
					    	<label for="p5">5</label>
					  	</span>
					  	<output for="star-input" ><input type="hidden" name="rate" value="0"></output>						
					</span>			   	
					<textarea class='boxTA' style='width:100%; height: 70px; color: #262626;'></textarea>
			    </td>
			</tr>
			<tr>
			   <td align='right'>
			        <button type='button' class='btn btnSendRate' data-num='10' style="padding:10px 10px; font-size: 12px;">등록하기</button>
			    </td>
			 </tr>
		</table>
		     
		<div id="listRate" style="width: 100%"></div>

   	 </div>
	  
			
    	</div>
    </div>

