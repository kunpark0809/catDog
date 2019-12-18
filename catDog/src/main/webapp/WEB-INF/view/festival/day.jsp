<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/tabs.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/vendor/jquery-ui/css/smoothness/jquery-ui.min.css" type="text/css">

<style type="text/css">
.ui-widget-header {
	background: none;
	border: none;
	height: 35px;
	line-height:35px;
	border-bottom: 1px solid #cccccc;
	border-radius: 0px;
}   
.help-block {
	margin-top: 3px;
}
.titleDate {
	display: inline-block;
	font-weight: 600;
	font-size: 15px;
	font-family: 나눔고딕, "맑은 고딕", 돋움, sans-serif;
	padding: 2px 4px 4px;
	text-align: center;
	position: relative;
	top: 4px;
}
.btnDate {
	display: inline-block;
	font-size: 10px;
	font-family: 나눔고딕, "맑은 고딕", 돋움, sans-serif;
	color:#333333;
	padding: 3px 5px 5px;
	border: 1px solid #cccccc;
	background-color: #fff;
	text-align: center;
	cursor: pointer;
	border-radius: 2px;
}
.textDate {
	font-weight: 500; cursor: pointer; display: block; color: #333333;
}
.preMonthDate, .nextMonthDate {
	color: #aaaaaa;
}
.nowdate {
	color: #111111;
}
.saturdayDate {
	color: #0000ff;
}
.sundayDate {
	color: #ff0000;
}
</style>

<script type="text/javascript" src="<%=cp%>/resource/vendor/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/vendor/jquery-ui/jquery.ui.datepicker-ko.js"></script>

<script type="text/javascript">
$(function(){
	$("#tab-day").addClass("active");
});
$(function(){
	$("ul.tabs li").click(function(){
		tab = $(this).attr("data-tab");
		
		$("ul.tabs li").each(function(){
			$(this).removeClass("active");
		});
		
		$("#tab-"+tab).addClass("active");
		
		var url="<%=cp%>/festival"
		if(tab=="month") {
			url+="/month";
		} else if(tab=="day") {
			url+="/day";
		} else if(tab=="year") {
			url+="/year";
		}
		
		location.href=url;
	});
});

$(function(){
	var today="${today}";
	var date="${date}";
	$("#smallCalendar .textDate").each(function (i) {
		var s=$(this).attr("data-date");
		if(s==today) {
			$(this).parent().css("background", "#ffffd9");
		}
		if(s==date) {
			$(this).css("font-weight", "600");
		}
	})
});

function changeDate(date) {
	var url="<%=cp%>/festival/day?date="+date;
	location.href=url;
}

$(function(){
	$(".textDate").click(function(){
		var date=$(this).attr("data-date");
		var url="<%=cp%>/festival/day?date="+date;
		location.href=url;
	});
});

<c:if test="${not empty dto}">
$(function(){
	$("#btnUpdate").click(function(){
		$("form[name=festivalForm]").each(function(){
			this.reset();
		});
		
		$("#form-startDate").datepicker({showMonthAfterYear:true});
		$("#form-endDate").datepicker({showMonthAfterYear:true});
		
		var date1="${dto.startDate}";
		var date2="${dto.endDate}";
		if(date2=="") {
			date2=date1;
			$("#form-endDate").val(date2);
		}
		
		$("#form-startDate").datepicker("option", "defaultDate", date1);
		$("#form-endDate").datepicker("option", "defaultDate", date2);
		
		var startTime="${dto.startTime}";
		if(startTime!="") {
			$("#form-startTime").show();
			$("#form-endTime").show();
		} else {
			$("#form-startTime").hide();
			$("#form-endTime").hide();
		}
		
		$('#festival-dialog').dialog({
			modal: true,
			height: 650,
			width: 600,
			title: '스케쥴 수정',
			close: function(event, ui) {
				
			}
		});
	});
});

$(function(){
	$("#btnFestivalSendOk").click(function(){
		if(! check()) {
			alert($(this));
			return;
		}
		
		var query=$("form[name=festivalForm]").serialize();
		var url="<%=cp%>/festival/update";
		
		$.ajax({
			type:"post"
			,url: url
			,data: query
			,dataType: "json"
			,success: function(data) {
				var state=data.state;
				if(state=="true") {
					var date = "${date}";
					var festivalNum = "${dto.festivalNum}";
					location.href="<%=cp%>/festival/day?date="+date+"&festivalNum="+festivalNum;
				}
			}
			,beforeSend : function(jqXHR) {
				jqXHR.setRequestHeader("AJAX", true);
			}
			,error : function(jqXHR) {
				if(jqXHR.status==403) {
				location.href="<%=cp%>/member/login";
					return;
				}
				console.log(jqXHR.responseText);
			} 
		});
	});
});

$(function(){
	$("#btnFestivalSendCancel").click(function(){
		$('#festival-dialog').dialog("close");
	});
});

$(function() {
	$("#form-allDay").click(function(){
		if(this.checked==true) {
			$("#form-startTime").val("").hide();
			$("#form-endTime").val("").hide();
		} else if(this.checked==false) {
			$("#form-startTime").val("00:00").show();
			$("#form-endTime").val("00:00").show();
		}
	});
	
	$("#form-startDate").change(function() {
		$("#form-endDate").val($("#form-startDate").val());
	});
});

function check() {
/* 	if(! $("form-subject").val()) {
		$("#form-subject").focus();
		return false;
	}
	
	if(! $("#form-startDate").val()) {
		$("#form-startDate").focus();
		return false;
	}
	
	if(! $("#form-endDate").val()) {
		var s1=$("#form-startDate").val().replace("-", "");
		var s2=$("#form-endDate").val().replace("-", "");
		if(s1>s2) {
			$("#form-startDate").focus();
			return false;
		}
	}
	 */
	return true;
}

function isValidTime(data) {
	if(! /(\d){2}[:](\d){2}/g.test(data)) {
		return false;
	}
	
	var t=data.split(":");
	if(t[0]<0||t[0]>23||t[1]<0||t[1]>59) {
		return false;
	}
	
	return true;
}

function deleteOk(festivalNum) {
	if(confirm("일정을 삭제 하시겠습니까 ? ")) {
		var date="${date}";
		var url="<%=cp%>/festival/delete?date="+date+"&festivalNum="+festivalNum;
		location.href=url;
	}
}
</c:if>
</script>
<div style="width: 900px; margin: 20px auto 10px;">
	<div class="body-title">
		<h3><i class="far fa-calendar-alt"></i> 일정관리 </h3>
	</div>
	
	<div>
		<div style="clear:both;">
			<ul class="tabs">
				<li id="tab-month" data-tab="month">월별일정</li>
				<li id="tab-day" data-tab="day">상세일정</li>
				<li id="tab-year" data-tab="year">년도</li>
			</ul>
		</div>
	
		<div id="tab-content" style="clear:both; padding: 20px 0px 0px; ">
			<div style="clear: both;">
				<div id="festivalLeft" style="float:left; padding-left: 0px; padding-right: 0px;">
					<table style="width: 280px; border-spacing: 0;">
						<tr height="35">
							<td align="center">
								<span class="btnDate" onclick="changeDate('${today}');">오늘</span>
								<span class="btnDate" onclick="changeDate('${preMonth}');">＜</span>
								<span class="titleDate">${year}년  ${month}월</span>
								<span class="btnDate" onclick="changeDate('${nextMonth}');">＞</span>
							</td>
						</tr>
					</table>
					
					<table id="smallCalendar" style="width: 280px; margin-top: 5px; border-spacing: 1px; background: #cccccc; ">
						<tr align="center" height="33" bgcolor="#ffffff">
							<td width="40" style="color: #ff0000;">일</td>
							<td width="40">월</td>
							<td width="40">화</td>
							<td width="40">수</td>
							<td width="40">목</td>
							<td width="40">금</td>
							<td width="40" style="color: #0000ff;">토</td>
						</tr>
						
						<c:forEach var="row" items="${days}">
							<tr align="left" height="37" bgcolor="#ffffff">
								<c:forEach var="d" items="${row}">
									<td align="center" class="tdDay">
										${d}
									</td>
								</c:forEach>
							</tr>
						</c:forEach>
					</table>
				</div>
				<div id="festivalRight" style="float:left; padding-left: 30px; padding-right: 0px; width: 600px; box-sizing: border-box;">
					<table style="width: 100%; border-spacing: 0px;">
						<tr height="35">
							<td align="left">
								<span class="titleDate">${year}년  ${month}월  ${day}일  일정</span>
							</td>
						</tr>
					</table>
					
					<c:if test="${empty dto}">
						<table style="width: 100%; margin-top: 5px; border-spacing: 0px; border-collapse: collapse;">
							<tr height="35">
								<td align="center">등록된 일정이 없습니다.</td>
							</tr>
						</table>
					</c:if>
					<c:if test="${not empty dto}">
						<table style="width: 100%; margin-top: 5px; border-spacing: 0px; border-collapse: collapse;">
							<tr height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
								<td width="100" style="text-align: right;">
									<label style="font-weight: 900">제목</label>
								</td>
								<td style="text-align: left; padding-left: 7px;">
									<p style="margin-top: 1px; margin-bottom: 1px;">
										${dto.subject}
									</p>
								</td>
							</tr>
							<tr height="35" style="border-bottom: 1px solid #cccccc;">
								<td width="100" style="text-align: right;">
									<label style="font-weight: 900;">날짜</label>
								</td>
								<td style="text-align: left; padding-left: 7px;">
									<p style="margin-top: 1px; margin-bottom: 1px;">
										${dto.period}
									</p>
								</td>
							</tr>
							<tr height="35" style="border-bottom: 1px solid #cccccc;">
								<td width="100" style="text-align: right; ">
									<label style="font-weight: 900;">일정분류</label>
								</td>
								<td style="text-align: left; padding-left: 7px;">
									<p style="margin-top: 1px; margin-bottom: 1px;">
										<c:choose>
											<c:when test="${dto.color=='#A66E4E'}">강아지일정</c:when>
											<c:when test="${dto.color=='#D96262'}">고양이일정</c:when>
											<c:otherwise>기타일정</c:otherwise>
										</c:choose>, ${empty dto.startTime?"종일일정":"시간일정"}
									</p>
								</td>
							</tr>
							<tr height="35" style="border-bottom: 1px solid #cccccc;">
								<td width="100" style="text-align: right;">
									<label style="font-weight: 900;">등록일</label>
								</td>
								<td style="text-align: left; padding-left: 7px;">
									<p style="margin-top: 1px; margin-bottom: 1px;">
										${dto.created}
									</p>
								</td>
							</tr>
							<tr height="35" style="border-bottom: 1px solid #cccccc;">
								<td width="100" style="text-align: right;">
									<label style="font-weight: 900;">장소</label>
								</td>
								<td style="text-align: left; padding-left: 7px;">
									<p style="margin-top: 1px; margin-bottom: 1px;">
										${dto.addr}
									</p>
								</td>
							</tr>
							<tr height="45" style="border-bottom: 1px solid #cccccc;">
								<td width="100" valign="top" style="text-align: right; margin-top: 5px;">
									<label style="font-weight: 900;">내용</label>
								</td>
								<td valign="top" style="text-align: left; margin-top: 5px; padding-left: 7px;">
									<p style="margin-top: 0px; margin-bottom: 1px;">
										<span style="white-space: pre;">${dto.content}</span>
									</p>
								</td>
							</tr>
							<tr height="45">
								<td colspan="2" align="right" style="padding-right: 5px;">
									<button type="button" id="btnUpdate" class="btn">수정</button>
									<button type="button" id="btnDelete" class="btn" onclick="deleteOk('${dto.festivalNum}');">삭제</button>
								</td>
							</tr>
						</table>
					</c:if>
					
					<c:if test="${list.size()>1}">
						<table style="width:100%; margin-top: 15px; border-spacing: 0px;">
							<tr height="35">
								<td align="left">
									<span class="titleDate">${year}년  ${month}월  ${day}일  다른  일정</span>
								</td>
							</tr>
						</table>
						<table style="width: 100%; margin: 5px 0 20px; border-spacing: 0px; border-collapse: collapse;">
							<tr align="center" bgcolor="#eeeeee" height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
								<th width="80" style="color: #787878;">분류</th>
								<th style="color: #787878;">제목</th>
								<th width="80" style="color: #787878;">등록일</th>
							</tr>
						  	<c:forEach var="vo" items="${list}">
								<c:if test="${dto.festivalNum != vo.festivalNum}">
									<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;">
										<td>
											<c:choose>
												<c:when test="${vo.color=='#A66E4E'}">강아지일정</c:when>
												<c:when test="${vo.color=='#D96262'}">고양이일정</c:when>
												<c:otherwise>기타일정</c:otherwise>
											</c:choose>
										</td>
										<td align="left" style="padding-left: 10px;">
										  
										<a href="<%=cp%>/festival/day?date=${date}&festivalNum=${vo.festivalNum}"></a>
										</td>
										<td>${vo.created}</td>
									</tr>
								</c:if> 
							</c:forEach>
							
						</table>
					</c:if>
					
				</div>
			</div>
		</div>

	</div>
</div>

<c:if test="${not empty dto}">
	<div id="festival-dialog" style="display: none;">
		<form name="festivalForm">
			<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
				<tr>
					<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
						<label style="font-weight: 900;">제목</label>
					</td>
					<td style="padding: 0 0 15px 15px;">
						<p style="margin-top: 1px; margin-bottom: 5px;">
							<input type="text" name="subject" id="form-subject" maxlength="100" class="boxTF" value="${dto.subject}" style="width: 95%;">
						</p>
						<p class="help-block">* 제목은 필수입니다.</p>
					</td>
				</tr>
				
				<tr>
					<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
						<label style="font-weight: 900;">일정분류</label>
					</td>
					<td style="padding: 0 0 15px 15px;">
						<p style="margin-top: 1px; margin-bottom: 5px;">
							<select name="color" id="form-color" class="selectField">
								<option value="#A66E4E" ${dto.color=="#A66E4E"?"selected='selected' ":""}>강아지일정</option>
								<option value="#D96262" ${dto.color=="#D96262"?"selected='selected' ":""}>고양이일정</option>
								<option value="#8DC3F2" ${dto.color=="#8DC3F2"?"selected='selected' ":""}>기타일정</option>
							</select>
						</p>
					</td>
				</tr>
				
				<tr>
					<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
						<label style="font-weight: 900;">종일일정</label>
					</td>
					<td style="padding: 0 0 15px 15px;">
						<p style="margin-top: 5px; margin-bottom: 5px;">
							<input type="checkbox" name="allDay" id="form-allDay" value="1" ${empty dto.startTime?"checked='checked'":""}>	
							<label for="allDay">하루종일</label>
						</p>
					</td>
				</tr>
				
				<tr>
					<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
						<label style="font-weight: 900;">시작일자</label>
					</td>
					<td style="padding: 0 0 15px 15px;">
						<p style="margin-top: 1px; margin-bottom: 5px">
							<input type="text" name="startDate" id="form-startDate" maxlength="10" class="boxTF" value="${dto.startDate}" readonly="readonly" style="width: 25%; background: #ffffff;">
							<input type="text" name="startTime" id="form-startTime" maxlength="5" class="boxTF" value="${dto.startTime}" style="width: 15%; display: none;" placeholder="시작시간">
						</p>
						<p class="help-block">* 시작날짜는 필수입니다.</p>
					</td>
				</tr>
				
				<tr>
					<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
						<label style="font-weight: 900;">종료일자</label>
					</td>
					<td style="padding: 0 0 15px 15px;">
						<p style="margin-top: 1px; margin-bottom: 5px;">
							<input type="text" name="endDate" id="form-endDate" maxlength="10" class="boxTF" value="${dto.endDate}" readonly="readonly" style="width: 25%; background: #ffffff;">
							<input type="text" name="endTime" id="form-endTime" maxlength="5" class="boxTF" value="${dto.endTime}" style="width: 15%; display: none;" placeholder="종료시간">
						</p>
						<p class="help-block">종료일자는 선택사항이며, 시작일 이후로 해주세요.</p>
					</td>
				</tr>

				<tr>
					<td width="100" valign="top"
						style="text-align: right; padding-top: 5px;"><label
						style="font-weight: 900;">장소</label></td>
					<td style="padding: 0 0 15px 15px;">
						<p style="margin-top: 1px; margin-bottom: 5px;">
							<input type="text" name="addr" id="form-address" maxlength="100" class="boxTF" style="width: 93%;">
						</p>
					</td>
				</tr>

				<tr>
					<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
						<label style="font-weight: 900;">내용</label>
					</td>
					<td style="padding: 0 0 15px 15px;">
						<p style="margin-top: 1px; margin-bottom: 5px;">
							<textarea rows="content" name="content" id="form-content" class="boxTA" style="width: 93%; height: 70px;">${dto.content}</textarea>
						</p>
					</td>
				</tr>
				
				<tr height="45">
					<td align="center" colspan="2">
						<input type="hidden" name="festivalNum" value="${dto.festivalNum}">
						<button type="button" class="btn" id="btnFestivalSendOk">수정완료</button>
						<button type="button" class="btn" id="btnFestivalSendCancel">수정취소</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</c:if>
