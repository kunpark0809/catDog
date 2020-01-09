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
	
	    	str = f.name.value;
	    	
	        if(!str) {
	            alert("이름을 입력하세요. ");
	            f.name.focus();
	            return;
	        }
	        
			str = f.bank.value;
	    	
	        if(!str) {
	            alert("은행명 입력하세요. ");
	            f.bank.focus();
	            return;
	        }
	        
			str = f.refundAccount.value;
	    	
	        if(!str) {
	            alert("계좌번호를 입력하세요. ");
	            f.refundAccount.focus();
	            return;
	        }
    	
		
   		f.action="<%=cp%>/mypage/${mode}";

        f.submit();
        
        return true;
   }

</script>

<div class="body-container" style="width: 1200px; margin: 20px auto 0px; border-spacing: 0px;">
	

<form name="boardForm" method="post" enctype="multipart/form-data" onsubmit="return submitContents(this);">
  <div class="detailList">
  <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
  
  <tr align="center" bgcolor="#eeeeee" height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
				<th width="15" style="color: #787878;"><input type="checkbox" value="all" id="requestAllCheck" onchange="checkRequest();"></th>
				<th width="130" style="color: #787878;">주문일자<br>[주문상세번호]</th>
				<th style="color: #787878; width: 80px;">이미지</th>
				<th width="300" style="color: #787878;">상품정보</th>
				<th width="80" style="color: #787878;">수량</th>
				<th width="60" style="color: #787878;">상품구매금액</th>
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
					<a href="<%=cp%>/dogshop/article?productNum=${dto.productNum}">${dto.productName}</a>
				</td>
				<td>${dto.productCount}</td>
				<td>${dto.productSum}</td>
			</tr>
			</c:if>
			</c:forEach>
			</table>
			
  <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
      <td width="100" bgcolor="#eeeeee" style="text-align: center;">작성자</td>
      <td style="padding-left:10px;"> 
          ${detailList.get(0).name}
      </td>
  </tr>

  <tr align="left" style="border-bottom: 1px solid #cccccc;"> 
      <td width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="top">사&nbsp;&nbsp;&nbsp;&nbsp;유</td>
      <c:if test="${mode=='refund'}">
      <td valign="top" style="padding:5px 0px 5px 10px;"> 
        <textarea id="Reason" name="refundReason" rows="12" class="boxTA" style="width: 95%; resize: none;"></textarea>
      </td>
      </c:if>
      <c:if test="${mode=='swap'}">
      <td valign="top" style="padding:5px 0px 5px 10px;"> 
        <textarea id="Reason" name="swapReason" rows="12" class="boxTA" style="width: 95%; resize: none;"></textarea>
      </td>
      </c:if>
  </tr>
  
  </table>
  
  <c:if test="${mode=='refund'}">
   <table style="width: 50%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
 	 <tr align="left" height="10px" style="border-bottom: 1px solid #cccccc;"> 
      <td width="50" bgcolor="#eeeeee" style="text-align: center;">이름</td>
      <td style="padding-left:10px;"> 
         <textarea id="name" name="name" rows="1" class="boxTA" style="width: 95%; resize: none;">${pay.name}</textarea>
      </td>
  	</tr>
 	 
 	 <tr align="left" height="10px" style="border-bottom: 1px solid #cccccc;"> 
      <td width="100" bgcolor="#eeeeee" style="text-align: center;">은행명</td>
      <td style="padding-left:10px;"> 
         <textarea id="bank" name="bank" rows="1" class="boxTA" style="width: 95%; resize: none;">${pay.bank}</textarea>
      </td>
  	</tr>

   <tr align="left" height="10px" style="border-bottom: 1px solid #cccccc;"> 
      <td width="100" bgcolor="#eeeeee" style="text-align: center;">계좌번호</td>
      <td style="padding-left:10px;"> 
         <textarea id="refundAccount" name="refundAccount" rows="1" class="boxTA" style="width: 95%; resize: none;">${pay.refundAccount}</textarea>
      </td>
  	</tr>
  
  </table>
</c:if>
  <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
     <tr height="45"> 
      <td align="center" >
	        <button type="submit" class="btn">${mode=='refund'?'환불신청':'교환신청'}</button>
	        <button type="reset" class="btn">다시입력</button>
	        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/mypage/requestCheck';">${mode=='refund'?'환불취소':'교환취소'}</button>

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