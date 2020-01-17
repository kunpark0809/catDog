<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<style type="text/css">
.bts {
width: 70px;
background-color: #51321b;
border: none;
color: #ffffff;
padding: 6px 0;
text-align: center;
display: inline-block;
font-size: 15px;
margin: 4px;
border-radius: 5px;
}
</style>

<script type="text/javascript" src="<%=cp%>/resource/se/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
 function check() {
     var f = document.petForm;

 	var str = f.subject.value;
     if(!str) {
         alert("제목을 입력하세요. ");
         f.subject.focus();
         return false;
     }
     
     var mode="${mode}";
     if(mode=="created"||mode=="update" && $f.main.value!="") {
 		if(! /(\.gif|\.jpg|\.png|\.jpeg)$/i.test(f.main.value)) {
 			alert('이미지 파일만 업로드 가능합니다.');
 			f.main.focus();
 			return false;
 		}
 	}
     
   
 	f.action="<%=cp%>/pet/created";
 	return true;
 }

</script>

<div class="wide-container">
	 <div class="body-title">
		<span style="font-family: Webdings"><i class="fas fa-paw"></i> 멍냥 자랑</span>
	</div>

		<form name="petForm" method="post" enctype="multipart/form-data" onsubmit="return submitContents(this);">
			<div class="container" style="color: white;">
			
				
			  <table style="width: 100%; margin: 20px auto 10px; border-spacing: 0px; border-collapse: collapse;">
			  <tbody id="petb">
			  
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#51321b" style="text-align: center; font-weight: bold;">제목</td>
			      <td style="padding-left:10px;"> 
			        <input type="text" name="subject" maxlength="100" class="boxTF" style="width: 100%;" value="${dto.subject}">
			      </td>
			  </tr>
			
			  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#51321b" style="text-align: center; font-weight: bold;">작&nbsp;&nbsp;성&nbsp;&nbsp;자</td>
			      <td style="padding-left:10px; color: #262626">
			           ${sessionScope.member.nickName}
			      </td>
			  </tr>
			  
			<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
		    	<td width="100" bgcolor="#51321b" style="text-align: center; font-weight: bold;">본문사진</td>
		    	<td style="padding-left:10px;"> 
		       		<input type="file" name="upload" class="boxTF" size="53" style="height: 25px; color: black;">
		       		${dto.imageFileName}
		      	</td>
		 	</tr>
			</table>
			</div>
			<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			     <tr height="45"> 
			      <td align="center">
			        <button type="submit" class="bts">${mode=='update'?'수정완료':'등록하기'}</button>
			        <button type="reset" class="bts">다시입력</button>
			        <button type="button" class="bts" onclick="javascript:location.href='<%=cp%>/pet/list';">${mode=='update'?'수정취소':'등록취소'}</button>
			        	<c:if test="${mode=='update'}">
								<input type="hidden" name="myPetNum" value="${dto.myPetNum}">
								<input type="hidden" name="imageFilename" value="${dto.imageFileName}">
								<input type="hidden" name="page" value="${page}">
						</c:if>
			      </td>
			    </tr>
			   </tbody>
			</table>
		</form>
    </div>
