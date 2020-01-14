<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript" src="<%=cp%>/resource/se/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
function checkRequest(){
	if($("#requestAllCheck").is(':checked')){
		$("input[name=requestDetailNum]").prop("checked",true);
	} else{
		$("input[name=requestDetailNum]").prop("checked",false);
	}
}

    function sendOk() {
        var f = document.boardForm;
        
        
	    	var str = f.refundReason.value;
	    	
	        if(!str) {
	            alert("사유를 입력하세요. ");
	            f.refundReason.focus();
	            return;
	        }
    	
		
   		f.action="<%=cp%>/mypage/${mode}";

        f.submit();
        
        return true;
   }

</script>

<div class="container-board">
		<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
			<tr height="35" style="border-bottom: 2px solid #D96262; padding-top:20px; padding-bottom:20px;">
				<c:if test="${mode=='refundRequest'}">
				<td align="left" width="50%">
					<h2>환불 신청</h2>
				</td>
				</c:if>
				<c:if test="${mode=='swapRequest'}">
				<td align="left" width="50%">
					<h2>교환 신청</h2>
				</td>
				</c:if>
				<td align="right">
					&nbsp;
				</td>
			</tr>
		</table><br>

<form name="boardForm" method="post" enctype="multipart/form-data" onsubmit="return submitContents(this);">
  <div class="detailList">
  <table style="width: 100%; border-spacing: 0px; border-collapse: collapse;">
  
  <tr align="center" bgcolor="#51321b" height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				<th width="15" style="color: white;"><input type="checkbox" value="all" id="requestAllCheck" onchange="checkRequest();"></th>
				<th width="130" style="color: white;">주문일자<br>[주문상세번호]</th>
				<th style="color: white; width: 80px;">이미지</th>
				<th width="300" style="color: white;">상품정보</th>
				<th width="80" style="color: white;">수량</th>
				<th width="60" style="color: white;">상품구매금액</th>
	</tr>
			
			<c:forEach var="dto" items="${detailList}">
			<c:if test="${dto.status==4}">
			<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;"> 
				<td>
					<input type="checkbox" value="${dto.requestDetailNum}" name="requestDetailNum">
				</td> 
				<td>${dto.requestDate}<br>${dto.requestDetailNum}</td>
				<td align="center">
					<img style="width: 80px; height: 80px;" src="<%=cp%>/uploads/dogshop/${dto.imageFileName}">
				</td>
				<td>
					<a href="<%=cp%>/dogshop/article?productNum=${dto.productNum}" style="color: black;">${dto.productName}</a>
				</td>
				<td>${dto.productCount}</td>
				<td>${dto.productSum}</td>
			</tr>
			</c:if>
			</c:forEach>
			</table>
			
  <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
      <td width="100" bgcolor="#51321b" style="text-align: center; font-weight: bold; color: white;">작&nbsp;&nbsp;성&nbsp;&nbsp;자</td>
      <td style="padding-left:10px; color: #262626"> 
          ${detailList.get(0).name}
      </td>
  </tr>

  <tr align="left" style="border-bottom: 1px solid #cccccc;"> 
      <td width="100" bgcolor="#51321b" style="text-align: center; padding-top:5px; color: white;" valign="top">사&nbsp;&nbsp;&nbsp;&nbsp;유</td>
      <c:if test="${mode=='refundRequest'}">
      <td valign="top" style="padding:5px 0px 5px 10px;"> 
        <textarea id="Reason" name="refundReason" rows="12" class="boxTA" style="width: 95%; resize: none;"></textarea>
      </td>
      </c:if>
      <c:if test="${mode=='swapRequest'}">
      <td valign="top" style="padding:5px 0px 5px 10px;"> 
        <textarea id="Reason" name="swapReason" rows="12" class="boxTA" style="width: 95%; resize: none;"></textarea>
      </td>
      </c:if>
  </tr>
  
  </table>
  
  <c:if test="${mode=='refundRequest'}">
   <table style="width: 50%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
 	 <tr align="left" height="10px" style="border-bottom: 1px solid #cccccc;"> 
      <td width="50" bgcolor="#51321b" style="text-align: center; color: white;">이름</td>
      <td style="padding-left:10px;"> 
         <textarea id="name" name="name" rows="1" class="boxTA" style="width: 95%; resize: none; border-radius:5px;">${pay.name}</textarea>
      </td>
  	</tr>
 	 
 	 <tr align="left" height="10px" style="border-bottom: 1px solid #cccccc;"> 
      <td width="100" bgcolor="#51321b" style="text-align: center; color: white;">은행명</td>
      <td style="padding-left:10px;"> 
         <textarea id="bank" name="bank" rows="1" class="boxTA" style="width: 95%; resize: none; border-radius:5px;">${pay.bank}</textarea>
      </td>
  	</tr>

   <tr align="left" height="10px" style="border-bottom: 1px solid #cccccc;"> 
      <td width="100" bgcolor="#51321b" style="text-align: center; color: white;">계좌번호</td>
      <td style="padding-left:10px;"> 
         <textarea id="refundAccount" name="refundAccount" rows="1" class="boxTA" style="width: 95%; resize: none; border-radius:5px;">${pay.refundAccount}</textarea>
      </td>
  	</tr>
  
  </table>
</c:if>
<br>
  <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
     <tr height="45"> 
      <td align="center" >
	        <button type="submit" class="bts">${mode=='refundRequest'?'환불신청':'교환신청'}</button>
	        <button type="reset" class="bts">다시입력</button>
	        <button type="button" class="bts" onclick="javascript:location.href='<%=cp%>/mypage/requestCheck';">${mode=='refundRequest'?'환불취소':'교환취소'}</button>

      </td>
    </tr>
  </table>
  </div>
</form>
</div>

<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "Reason",
	sSkinURI: "<%=cp%>/resource/se/SmartEditor2Skin.html",	
	htParams : {bUseToolbar : true,
		fOnBeforeUnload : function(){
			//alert("아싸!");
		}
	}, //boolean
	fOnAppLoad : function(){
		//예제 코드
		//oEditors.getById["content"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
	},
	fCreator: "createSEditor2"
});

function pasteHTML() {
	var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
	oEditors.getById["Reason"].exec("PASTE_HTML", [sHTML]);
}

function showHTML() {
	var sHTML = oEditors.getById["Reason"].getIR();
	alert(sHTML);
}
	
function submitContents(elClickedObj) {
	oEditors.getById["Reason"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	
	// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("content").value를 이용해서 처리하면 됩니다.
	
	try {
		// elClickedObj.form.submit();
		return sendOk();
	} catch(e) {}
}

function setDefaultFont() {
	var sDefaultFont = '돋움';
	var nFontSize = 24;
	oEditors.getById["Reason"].setDefaultFont(sDefaultFont, nFontSize);
}
</script>