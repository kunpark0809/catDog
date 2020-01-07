<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.lbl { 
   position:absolute; 
   margin-left:15px; margin-top: 17px;
   color: #999999; font-size: 11pt;
}
.loginTF {
  width: 340px; height: 35px;
  padding: 5px;
  padding-left: 15px;
  border:1px solid #999999;
  color:#333333;
  margin-top:5px; margin-bottom:5px;
  font-size:14px;
  border-radius:4px;
}
</style>
<script type="text/javascript">
	function bgLabel(ob, id) {
	    if(!ob.value) {
		    document.getElementById(id).style.display="";
	    } else {
		    document.getElementById(id).style.display="none";
	    }
	}

	function sendOk() {
        var f = document.idFindForm;

        var str = f.userName.value;
        if(!str) {
            alert("이름을 입력하세요.");
            f.userName.focus();
            return;
        }
        
        var str = f.email.value;
        if(!str) {
            alert("이메일을 입력하세요.");
            f.email.focus();
            return;
        }

        f.action = "<%=cp%>/customer/idFind";
        f.submit();
	}
</script>

<div class="body-container">
    <div style="width:420px; margin: 0px auto; padding-top:90px;">
	
    	<div style="text-align: center;">
        	<span style="font-weight: bold; font-size:27px; color: #424951;">아이디 찾기</span>
        </div>
	
		<form name="idFindForm" method="post" action="">
		  <table style="width:100%; margin: 20px auto; padding:30px;  border-collapse: collapse; border: 1px solid #DAD9FF;">
		  <tr style="height:50px;"> 
		      <td style="text-align: center;">
		          이름과 이메일을  입력해주세요.
		      </td>
		  </tr>

		  <tr align="center" height="60"> 
		      <td>
		        &nbsp;
		        <label for="userId" id="lblUserName" class="lbl" >이름</label>
		        <input type="text" name="userName" id="userName" class="loginTF" maxlength="20" 
		                   tabindex="2"
                           onfocus="document.getElementById('lblUserName').style.display='none';"
                           onblur="bgLabel(this, 'lblUserName');">
		        &nbsp;
		      </td>
		  </tr>
		   <tr align="center" height="60"> 
		      <td>
		        &nbsp;
		        <label for="userId" id="lblEmail" class="lbl" >이메일</label>
		        <input type="text" name="email" id="email" class="loginTF" maxlength="20" 
		                   tabindex="2"
                           onfocus="document.getElementById('lblEmail').style.display='none';"
                           onblur="bgLabel(this, 'lblEmail');">
		        &nbsp;
		      </td>
		  </tr>
		  
		  <tr align="center" height="65" > 
		      <td>
		        &nbsp;
		        <button type="button" onclick="sendOk();" class="btnConfirm">확인</button>
		        &nbsp;
		      </td>
		  </tr>
		  <tr align="center" height="10" > 
		      <td>&nbsp;</td>
		  </tr>
	    </table>
		</form>
		           
	    <table style="width:100%; margin: 10px auto 0; border-collapse: collapse;">
		  <tr align="center" height="30" >
		    	<td><span style="color: blue;">${message}</span></td>
		  </tr>
		</table>
	</div>
</div>