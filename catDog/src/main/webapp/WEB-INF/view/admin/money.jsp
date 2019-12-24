<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/tabs.css" type="text/css">
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-3.4.1.min.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-3d.js"></script>

<script type="text/javascript">
$("#tab-${group}").addClass("active");

$("ul.tabs li").click(function(){
	tab = $(this).attr("data-tab");
	
	$("ul.tabs li").each(function(){
		$(this).removeClass("active");
	});

	$("#tab-"+tab).addClass("active");

	//var url = "<%=cp%>/admin/money?group="+tab+"&year="+$("#year option:selected").val();
	//location.href=url
});

$(function(){
	Highcharts.setOptions({
		lang: {
			thousandsSep: ','
		},
		legend: {
			enabled: false
		}
	});
	// 1년의 판매현황을 월별로 보여주는 차트
	var url = "<%=cp%>/admin/money/yearSalesChart";

	//페이지 최초 세팅시 차트 불러옴
	yearSalesChart(url);
	
});

function yearSalesChart(url){
	$.getJSON(url, function(data){
		$("#yearSales").highcharts({
			chart: {type: 'column'},
			title : {text : data.title},
			xAxis : {
				categories : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
				crosshair : true,
				labels: {
	                style: {
	                	fontSize:'15px'
	                }
	            }
			},
			yAxis : {
				min : 0,
				title : {
					text : '매출(원)'
				},
				labels: {
	                style: {
	                	fontSize:'15px'
	                }
				}
				
			},
			tooltip: {
		       headerFormat: '<span style="font-size:15px">{point.key}</span><table>',
		       pointFormat: '<tr><td style="color:{series.color};padding:0"></td>' +
		           '<td style="padding:0"><b>{point.y:,.0f}원</b></td></tr>',
		       footerFormat: '</table>',
		       shared: true,
		       useHTML: true
			    },
			plotOptions: {
				column: {
			    	pointPadding: 0.2,
			    	borderWidth: 0
			        }
			    },
			
			series : data.series
			
		});
	
	});	
}

function yearSalesChartChange(){
	if(!$("#year option:selected").val()) {
		return;
	}
	
	var url = "<%=cp%>/admin/money/yearSalesChart";
	url += "?year="+$("#year option:selected").val();
	yearSalesChart(url);
}

<%-- $(function(){
	var url = "<%=cp%>/admin/money/productSalesChart";
		
			$.getJSON(url, function(data) {
			// console.log(data);

			$("#monthContainer").highcharts({
				chart : {
					type : 'pie',
					options3d : {
						enabled : true,
						alpha : 45
					}
				},
				title : {
					text : '시간대별 접속자 수'
				},
				plotOptions : {
					pie : {
						innerSize : 100,
						depth : 45
					}
				},
				series : data
			});
		});
	}) --%>

	
</script>

<div class="body-container" style="width: 1100px; margin: 0px auto;">
	<div class="body-title">
		<h3>
			<i class="fas fa-search-dollar"></i> 매출 관리
		</h3>
	</div>

	<div style="clear: both;">
			<ul class="tabs">
				<li id="tab-0" data-tab="0">소계</li>
				<li id="tab-1" data-tab="1">
					월별 매출</li>
				<li id="tab-2" data-tab="2">
					분기별 매출</li>
				<li id="tab-3" data-tab="3">
					품목별 매출</li>
			</ul>
	</div>
	<br>

	<select id="year" onchange="selectChart()">
		<option value="">년도</option>
		<option value="2019">2019년</option>
		<option value="2018">2018년</option>
		<option value="2017">2017년</option>
	</select>
	
	
	<%-- <select id="month">
		<option>월</option>
		<c:forEach begin="1" end="12" var="x">
			<option><c:out value="${x}월" /></option>
		</c:forEach>
	</select> --%>
	



	<div>
		<div id="yearSales"
			style="width : 800px; height: 400px; margin: 0px auto;"></div>
	</div>
	<br> <br>

	<div>
		<div id="pie3dContainer"
			style="width: 500px; height: 300px; float: left; margin: 10px;"></div>
	</div>

	

</div>