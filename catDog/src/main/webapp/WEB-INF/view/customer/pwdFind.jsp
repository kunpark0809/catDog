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
  border: 2px solid #51321b;
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
        var f = document.pwdFindForm;

        var str = f.userId.value;
        if(!str) {
            alert("아이디를 입력하세요. ");
            f.userId.focus();
            return;
        }

        f.action = "<%=cp%>/customer/pwdFind";
        f.submit();
	}
</script>

<div class="body-container" style="min-height: 490px; padding-top: 100px; background-image:url('<%=cp%>/resource/img/pwdfindbg.jpg');
 background-position:center center; background-repeat: no-repeat;">
    <div style="width:420px; margin: 0px auto; background-color: rgba( 255, 255, 255, 0.5 );">
	
		
    	<div style="text-align: center; padding-top: 30px;">
        	<span style="font-weight: bold; font-size:27px; color: #424951;">패스워드 찾기</span>
        </div>
	
		<form name="pwdFindForm" method="post" action="">
		  <table style="width:100%; margin: 20px auto; padding:30px;">
		  <tr style="height:50px;"> 
		      <td style="text-align: center;">
		          아이디를 입력해주세요.
		      </td>
		  </tr>

		  <tr align="center" height="60"> 
		      <td>
		        &nbsp;
		        <label for="userId" id="lblUserId" class="lbl" >아이디</label>
		        <input type="text" name="userId" id="userId" class="loginTF" maxlength="20" 
		                   tabindex="2"
                           onfocus="document.getElementById('lblUserId').style.display='none';"
                           onblur="bgLabel(this, 'lblUserId');">
		        &nbsp;
		      </td>
		  </tr>
		  <tr align="center" height="65" > 
		      <td>
		        &nbsp;
		        <button type="button" onclick="sendOk();" class="bts" style="width: 364px;">확인</button>
		        &nbsp;
		      </td>
		  </tr>
		  <tr align="center" height="30" >
		    	<td><span style="color: blue;">${message}</span></td>
		  </tr>
		 
		  <tr align="center" height="10" > 
		      <td>&nbsp;</td>
		  </tr>
	    </table>
		</form>
		
	</div>
</div>