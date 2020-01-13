<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<div class="body-container">
    <div style="margin: 0px auto; padding-top:90px; width:620px; text-align: center;">
    	<div style="text-align: center;">
        	<span style="font-weight: bold; font-size:27px; color: #424951;">${title}</span>
        </div>
        
        <div class="messageBox">
            <div style="line-height: 150%; padding-top: 35px;">
                       ${message}            
            </div>
            <div style="margin: 20px auto 0;">
                     <button type="button" onclick="javascript:location.href='<%=cp%>/';" class="bts">메인화면으로 이동</button>
                </div>
        </div>
     </div>   
</div>