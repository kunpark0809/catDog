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

<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript">

function bgLabel(ob, id) {
    if(!ob.value) {
	    document.getElementById(id).style.display="";
    } else {
	    document.getElementById(id).style.display="none";
    }
}

function sendLogin() {
    var f = document.loginForm;

	var str = f.userId.value;
    if(!str) {
        alert("아이디를 입력하세요. ");
        f.userId.focus();
        return;
    }

    str = f.userPwd.value;
    if(!str) {
        alert("패스워드를 입력하세요. ");
        f.userPwd.focus();
        return;
    }


    
    
    f.action = "<%=cp%>/customer/login";
    f.submit();
}
</script>

<div class="body-container" style="background-image:url('<%=cp%>/resource/img/loginbg.jpg');
 background-position:center center; background-repeat: no-repeat; min-height: 600px;">
    <div style="width:360px; min-height:490px; margin: 0px auto; padding-top:105px;">
    	<div style=" background-color: rgba( 255, 255, 255, 0.5 ); padding-top: 40px;">
    	<div style="text-align: center;">
        	<span style="font-weight: bold; font-size:27px; color: #424951;">회원 로그인</span>
        </div>
        
		<form name="loginForm" method="post" action="">
		  <table style="margin: 15px auto; width: 100%; border-spacing: 0px;">
		  <tr align="center" height="60"> 
		      <td> 
                <label for="userId" id="lblUserId" class="lbl" >아이디</label>
		        <input type="text" name="userId" id="userId" class="loginTF" maxlength="15"
		                   tabindex="1"
                           onfocus="document.getElementById('lblUserId').style.display='none';"
                           onblur="bgLabel(this, 'lblUserId');" style="width: 278px;">
		      </td>
		  </tr>
		  <tr align="center" height="60"> 
		      <td>
		        <label for="userPwd" id="lblUserPwd" class="lbl" >패스워드</label>
		        <input type="password" name="userPwd" id="userPwd" class="loginTF" maxlength="20" 
		                   tabindex="2"
                           onfocus="document.getElementById('lblUserPwd').style.display='none';"
                           onblur="bgLabel(this, 'lblUserPwd');" style="width: 278px;">
		      </td>
		  </tr>
		  <tr align="center" height="65" > 
		      <td>
		        <button type="button" onclick="sendLogin();" class="bts" style="width: 300px;">로그인</button>
		      </td>
		  </tr>

		  <tr align="center" height="45">
		      <td>
		       		<button style="width: 93px; background-color: #A66E4E;" class="bts" type="button" onclick="javascript:location.href='<%=cp%>/customer/idFind';">아이디찾기</button>
		       		<button style="width: 93px; background-color: #A66E4E;" class="bts" type="button" onclick="javascript:location.href='<%=cp%>/customer/pwdFind';">패스워드찾기</button>
		       		<button style="width: 93px; background-color: #A66E4E;" class="bts" type="button" onclick="javascript:location.href='<%=cp%>/customer/register';">회원가입</button>
		      </td>
		  </tr> 
		  <tr>
		  	<td>
		  		<div align="center" style="padding: 10px 0;">
			  		<a id="kakao-login-btn"></a>
					<a href="http://developers.kakao.com/logout"></a>
					<script type='text/javascript'>
					  //<![CDATA[
					    // 사용할 앱의 JavaScript 키를 설정해 주세요.
					    Kakao.init('b9ef4aedfdb873e59d1caf06b1541f6a');
					    // 카카오 로그인 버튼을 생성합니다.
					    Kakao.Auth.createLoginButton({
					      container: '#kakao-login-btn',
					      success: function(authObj) {
					        alert(JSON.stringify(authObj));
					      },	
					      fail: function(err) {
					         alert(JSON.stringify(err));
					      },
					      size:'large'
					    });
					  //]]>
					</script>
		  		</div>
		  	</td>
		  </tr>
		  	
		  
		  <tr align="center" height="40" >
		    	<td><span style="color: blue;">${message}</span></td>
		  </tr>
		  
		  </table>
		</form>           
	</div>
	</div>
</div>


