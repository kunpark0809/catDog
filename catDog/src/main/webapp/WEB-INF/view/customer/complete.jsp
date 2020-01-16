<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<div class="body-container" style="min-height: 490px; padding-top: 100px; background-image:url('/catDog/resource/img/completebg.jpg');
 background-position:center center; background-repeat: no-repeat;">
    <div style="margin: 0px auto; padding-top:30px;	padding-bottom:50px; width:520px; margin-top:40px; text-align: center; background-color: rgba( 255, 255, 255, 0.5 );">
    	<div style="text-align: center;">
        	<span style="font-weight: bold; font-size:27px; color: #424951;">${title}</span>
        </div>
        
        
        <div class="messageBox">
            <div style="line-height: 150%; padding-top: 35px;">
                       ${message}            
            </div>
            <div style="margin: 20px auto 0;">
                     <button type="button" onclick="javascript:location.href='<%=cp%>/';" class="bts" style="width: 350px;">메인화면으로 이동</button>
                </div>
        </div>
        
     </div>   
</div>