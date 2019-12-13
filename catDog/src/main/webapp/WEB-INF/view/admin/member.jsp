<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<div class="body-container" style="width: 700px; margin: 0px auto;">
	<div class="body-title">
		<h3>
			<span style="font-family: Wingdings">CD</span> 회원 관리
		</h3>

	</div>

	<div>
		<table
			style="font-size:15px; width: 100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
			<tr align="center" bgcolor="#eeeeee" height="35"
				style="border-top: 2px solid #cccccc; border-bottom: 1px solid #cccccc;">
				<th width="80" style="color: #787878;">사용자번호</th>
				<th width="100" style="color: #787878;">ID</th>
				<th style="color: #787878;">닉네임</th>
				<th width="80" style="color: #787878;">성명</th>
				<th width="90" style="color: #787878;">마일리지</th>
				<th width="90" style="color: #787878;">신고횟수</th>
				<th width="90" style="color: #787878;">주문횟수</th>
			</tr>
			
			<tr align="center"height="25" style="border-bottom: 1px solid #cccccc;">
				<td>15</td>
				<td>sloth20</td>
				<td>고독사</td>
				<td>김규동</td>
				<td>70</td>
				<td>0</td>
				<td>4</td>
			</tr>
			
			
		</table>
	</div>
</div>