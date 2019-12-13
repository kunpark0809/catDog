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
 function sendOk() {
     var f = document.parkForm;

 	var str = f.placeName.value;
     if(!str) {
         alert("장소 이름을 입력하세요. ");
         f.placeName.focus();
         return;
     }

     str = f.addr.value;
     if(!str) {
         alert("주소를 입력하세요. ");
         f.addr.focus();
         return;
     }
     
     str = f.tel.value;
     if(!str) {
         alert("전화번호를 입력하세요. ");
         f.tel.focus();
         return;
     }
     
     str = f.lat.value;
     if(!str) {
         alert("지도 좌표 위치의 경도를 입력하세요. ");
         f.lat.focus();
         return;
     }
     
     str = f.lon.value;
     if(!str) {
         alert("지도 좌표 위치의 위도를 입력하세요. ");
         f.lon.focus();
         return;
     }
     
 	str = f.content.value;
     if(!str) {
         alert("내용을 입력하세요. ");
         f.content.focus();
         return;
     }
     

     var mode="${mode}";
     if(mode=="created"||mode=="update" && f.upload.value!="") {
 		if(! /(\.gif|\.jpg|\.png|\.jpeg)$/i.test(f.upload.value)) {
 			alert('이미지 파일만 업로드 가능합니다.');
 			f.upload.focus();
 			return;
 		}
 	}

 	f.action="<%=cp%>/park/${mode}";

    f.submit();
 }

</script>



<div class="page-section" id="command" style="text-align: center;">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<p class="section-heading text-uppercase" style="font-size: 40px; border-bottom: 2px solid;">공원/산책</p>
				</div>
			</div>
    	</div>
    <div>
		<form name="parkForm" method="post" enctype="multipart/form-data">
			<div class="container" style="color: white;">
				
			  <table style="width: 100%; margin: 20px auto 10px; border-spacing: 0px; border-collapse: collapse;">
			  
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#262626" style="text-align: center;">장소이름</td>
			      <td style="padding-left:10px;"> 
			        <input type="text" name="placeName" maxlength="100" class="boxTF" style="width: 100%;" value="${dto.placeName}">
			      </td>
			  </tr>
			
			  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#262626" style="text-align: center;">작&nbsp;&nbsp;성&nbsp;&nbsp;자</td>
			      <td style="padding-left:10px;">
			           ${sessionScope.member.nickName}
			      </td>
			  </tr>
			  
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#262626" style="text-align: center;">주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</td>
			      <td style="padding-left:10px;"> 
			        <input type="text" name="addr" maxlength="100" class="boxTF" style="width: 100%;" value="${dto.addr}">
			      </td>
			  </tr>
			  
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#262626" style="text-align: center;">전화번호</td>
			      <td style="padding-left:10px;"> 
			        <input type="text" name="tel" maxlength="100" class="boxTF" style="width: 40%;" value="${dto.tel}">
			      </td>
			  </tr>
			  
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#262626" style="text-align: center;">위도/경도</td>
			      <td style="padding-left:10px;"> 
			        <input type="text" name="lat" maxlength="100" class="boxTF" style="width: 20%;" value="${dto.lat}">
			        <input type="text" name="lon" maxlength="100" class="boxTF" style="width: 20%;" value="${dto.lon}">
			      </td>
			  </tr>
			
			  <tr align="left" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#262626" style="text-align: center; padding-top:5px;" valign="top">상세정보</td>
			      <td valign="top" style="padding:5px 0px 5px 10px;"> 
			        <textarea name="content" rows="12" class="boxTA" style="width: 100%;">${dto.content}</textarea>
			      </td>
			  </tr>
			  
			  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
			      <td width="100" bgcolor="#262626" style="text-align: center;">사&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;진</td>
			      <td style="padding-left:10px;"> 
			          <input type="file" name="upload" class="boxTF" size="53"
			                     accept="image/*" 
			                     style="height: 25px;">
			       </td>
			  </tr>
			</table>
			</div>
			<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			     <tr height="45"> 
			      <td align="center" >
			        <button type="button" class="btn" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}</button>
			        <button type="reset" class="btn">다시입력</button>
			        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/park/list';">${mode=='update'?'수정취소':'등록취소'}</button>
			         <c:if test="${mode=='update'}">
			         	 <input type="hidden" name="recommendNum" value="${dto.recommendNum}">
			         	 <input type="hidden" name="imageFilename" value="${dto.imageFileName}">
			         	 <input type="hidden" name="page" value="${page}">
			        </c:if>
			      </td>
			    </tr>
			</table>
		</form>
    </div>
    
</div>