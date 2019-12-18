<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<link rel="stylesheet" href="<%=cp%>/resource/css/tabs.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/vendor/jquery-ui/css/smoothness/jquery-ui.min.css" type="text/css">

<style type="text/css">
.ui-widget-header {
	background: none;
	border: none;
	height: 35px;
	line-height: 35px;
	border-bottom: 1px solid #cccccc;
	border-radius: 0px;
}

.help-block {
	margin-top: 3px;
}

.titleDate {
	display: inline-block;
	font-weight: 600;
	font-size: 19px;
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
	color: #333333;
	padding: 3px 5px 5px;
	border: 1px solid #cccccc;
	background-color: #fff;
	text-align: center;
	cursor: pointer;
	border-radius: 2px;
}

.textDate {
	font-weight: 500;
	cursor: pointer;
	display: block;
	color: #333333;
}

.preMonthDate, .nextMonthDate {
	color: #aaaaaa;
}

.nowDate {
	color: #111111;
}

.saturdayDate {
	color: #0000ff;
}

.sundayDate {
	color: #ff0000;
}

.festivalSubject {
	display: block;
	/*width:100%;*/
	width: 110px;
	margin: 1.5px 0;
	font-size: 13px;
	color: #555555;
	background: #eeeeee;
	cursor: pointer;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.festivalMore {
	display: block;
	width: 110px;
	margin: 0 0 1.5px;
	font-size: 13px;
	color: #555555;
	cursor: pointer;
	text-align: right;
}
</style>

<script type="text/javascript" src="<%=cp%>/resource/vendor/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/vendor/jquery-ui/jquery.ui.datepicker-ko.js"></script>


<script type="text/javascript">
$(function() {
	$("#tab-month").addClass("active");
});

$(function() {
	var today="${today}";
	$("#largeCalendar .textDate").each(function (i) {
		var s=$(this).attr("data-date");
		if(s==today) {
			$(this).parent().css("background", "#ffffd9");
		}
	});
});

$(function() {
	$("ul.tabs li").click(function() {
		tab = $(this).attr("data-tab");
		
		$("ul.tabs li").each(function() {
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

function changeDate(year, month) {
	var url="<%=cp%>/festival/month?year="+year+"&month="+month;
	location.href=url;
}

$(function() {
	$(".textDate").click(function(){
		$("form[name=festivalForm]").each(function() {
			this.reset();
		});
		$("#form-allDay").prop("checked", true);
		$("#form-allDay").removeAttr("disabled");
		$("#form-endDate").closest("tr").show();
		
		var date=$(this).attr("data-date");
		date=date.substr(0, 4)+"-"+date.substr(4, 2)+"-"+date.substr(6, 2);
		
		$("form[name=festivalForm] input[name=startDate]").val(date);
		$("form[name=festivalForm] input[name=endDate]").val(date);
		
		$("#form-startDate").datepicker({showMonthAfterYear:true});
		$("#form-endDate").datepicker({showMonthAfterYear:true});
		
		$("#form-startDate").datepicker("option", "defaultDate", date);
		$("#form-endDate").datepicker("option", "defaultDate", date);
		
		$('#festival-dialog').dialog({
			modal: true,
			height: 650,
			width: 600,
			title: '스케쥴 등록',
			close: function(event, ui) {
			}
		});
	});
});

$(function(){
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

$(function() {
	$("#btnFestivalSendOk").click(function() {
		
		if(! check()) {
			return;
		}
		
		var query=$("form[name=festivalForm]").serialize();
		var url="<%=cp%>/festival/insert";
		
		$.ajax({
			type:"post"
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data) {
				var state=data.state;
				if(state=="true") {
					var dd=$("#form-startDate").val().split("-");
					var y=dd[0];
					var m=dd[1];
					if(m.substr(0, 1)=="0") m=m.substr(1, 1);
					location.href="<%=cp%>/festival/month?year="+y+"&month="+m;
				}
			}
			,beforeSend: function(jqXHR) {
				jqXHR.setRequestHeader("AJAX", true);
			}
			,error: function(jqXHR) {
				if(jqXHR.status==403) {
					location.href="<%=cp%>/member/login";
					return;
				}
				console.log(jqXHR.responseText);
			}
		});
	});
});

$(function() {
	$("#btnFestivalSendCancel").click(function() {
		$('#festival-dialog').dialog("close");
	});
});

function check() {
	if(! $("#form-subject").val()){
		$("#form-subject").focus();
		return false;
	}
	
	if(! $("#form-startDate").val()) {
		$("#form-startDate").focus();
		return false;
	}
	
	if($("#form-endDate").val()) {
		var s1=$("#form-startDate").val().replace("-", "");
		var s2=$("#form-endDate").val().replace("-", "");
		if(s1>s2) {
			$("#form-startDate").focus();
			return false;
		}
	}
	
	if($("#form-startTime").val()!="" && !isValidTime($("#form-startTime").val())) {
		$("#form-startTime").focus();
		return false;
	}
	
	if($("#form-endTime").val()!="" && !isValidTime($("#form-endTime").val())) {
		$("#form-endTime").focus();
		return false;
	}
	
	if($("#form-endTime").val()) {
		var s1=$("#form-startTime").val().replace(":", "");
		var s2=$("#form-endTime").val().replace(":", "");
		if(s1>s2) {
			$("#form-startTime").focus();
			return false;
		}
	}
	
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

$(function() {
	$(".festivalSubject").click(function() {
		var date=$(this).attr("data-date");
		var festivalNum=$(this).attr("data-festivalNum");
		var url="<%=cp%>/festival/day?date="+date+"&festivalNum="+festivalNum;
		location.href=url;
	});
});

$(function() {
	$(".festivalMore").click(function(){
		var date=$(this).attr("data-date");
		var url="<%=cp%>/festival/day?date="+date;
		locateion.href=url;
	});
});
</script>

<div style="width: 900px; margin: 20px auto 10px;">
	<div class="body-title">
		<h3>
			<i class="far fa-calendar-alt"></i> 일정관리
		</h3>
	</div>

	<div>
		<div style="clear: both;">
			<ul class="tabs">
				<li id="tab-month" data-tab="month">월별일정</li>
				<li id="tab-day" data-tab="day">상세일정</li>
				<li id="tab-year" data-tab="year">연도일정</li>
			</ul>
		</div>
		
		<div id="tab-content" style="clear: both; padding: 20px 0px 0px;">
			<table style="width: 840px; margin: 0px auto; border-spacing: 0;">
				<tr height="60">
					<td width="200">&nbsp;</td>
					<td align="center">
						<span class="btnDate" onclick="changeDate(${todayYear}, ${todayMonth});">오늘</span>
						<span class="btnDate" onclick="changeDate(${year}, ${month-1});">＜</span>
						<span class="titleDate">${year}년 ${month}월</span>
						<span class="btnDate" onclick="changeDate(${year}, ${month+1});">＞</span>
					</td>
					<td width="200">&nbsp;</td>
				</tr>
			</table>

			<table id="largeCalendar" style="width: 840px; margin: 0px auto; border-spacing: 1px; background: #cccccc;">
				<tr align="center" height="30" bgcolor="#ffffff">
					<td width="120" style="color: #ff0000;">일</td>
					<td width="120">월</td>
					<td width="120">화</td>
					<td width="120">수</td>
					<td width="120">목</td>
					<td width="120">금</td>
					<td width="120" style="color: #0000ff;">토</td>
				</tr>

				<c:forEach var="row" items="${days}">
					<tr align="left" height="120" valign="top" bgcolor="#ffffff">
						<c:forEach var="d" items="${row}">
							<td style="padding: 5px; box-sizing: border-box;">${d}</td>
						</c:forEach>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</div>
<div id="festival-dialog" style="display: none;">
	<form name="festivalForm">
		<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			<tr>
				<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
				<label style="font-weight: 900;">제목</label></td>
				<td style="padding: 0 0 15px 15px;">
					<p style="margin-top: 1px; margin-bottom: 5px;">
						<input type="text" name="subject" id="form-subject" maxlength="100" class="boxTF" style="width: 95%;">
					</p>
					<p class="help-block">* 제목은 필수 입니다.</p>
				</td>
			</tr>
			<tr>
				<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
					<label style="font-weight: 900;">일정분류</label></td>
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
					<label style="font-weight: 900;">종일일정</label></td>
				<td style="padding: 0 0 15px 15px;">
					<p style="margin-top: 5px; margin-bottom: 5px;">
						<input type="checkbox" name="allDay" id="form-allDay" value="1" checked="checked">
						<label for="allDay">하루종일</label>
					</p>
				</td>
			</tr>

			<tr>
				<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
					<label style="font-weight: 900;">시작일자</label></td>
				
				<td style="padding: 0 0 15px 15px;">
					<p style="margin-top: 1px; margin-bottom: 5px;">
						<input type="text" name="startDate" id="form-startDate" maxlength="10" class="boxTF" readonly="readonly" style="width: 25%; background: #ffffff;">
						<input type="text" name="startTime" id="form-startTime" maxlength="5" class="boxTF" style="width: 15%; display: none;" placeholder="시작시간">
					</p>
					<p class="help-block">* 시작날짜는 필수입니다.</p>
				</td>
			</tr>

			<tr>
				<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
					<label style="font-weight: 900;">종료일자</label></td>
				<td style="padding: 0 0 15px 15px;">
					<p style="margin-top: 1px; margin-bottom: 5px;">
						<input type="text" name="endDate" id="form-endDate" maxlength="10" class="boxTF" readonly="readonly" style="width: 25%; background: #ffffff;">
						<input type="text" name="endTime" id="form-endTime" maxlength="5" class="boxTF" style="width: 15%; display: none;" placeholder="종료시간">
					</p>
					<p class="help-block">종료일자는 선택사항이며, 시작일자보다 작을 수 없습니다.</p>
				</td>
			</tr>
			
			<tr>
				<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
					<label style="font-weight: 900;">내용</label></td>
				<td style="padding: 0 0 15px 15px;">
					<p style="margin-top: 1px; margin-bottom: 5px;">
						<textarea name="content" id="form-content" class="boxTA" style="width: 93%; height: 70px;"></textarea>
					</p>
				</td>
			</tr>

			<tr height="45">
				<td align="center" colspan="2">
					<button type="button" class="btn" id="btnFestivalSendOk">일정등록</button>
					<button type="reset" class="btn">다시입력</button>
					<button type="button" class="btn" id="btnFestivalSendCancel">등록취소</button>
				</td>
			</tr>
		</table>
	</form>
</div>