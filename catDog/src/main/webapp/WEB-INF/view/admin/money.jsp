<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-3.4.1.min.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-3d.js"></script>

<script type="text/javascript">
// http://www.highcharts.com/demo

$(function(){
	// 1년의 판매현황을 월별로 보여주는 차트
	var url = "<%=cp%>/admin/money/yearSalesChart?year=2019";
	//url += "?"+$("#year option:selected").val();
	// +"&"+$("#month option:selected").val();
	
	$.getJSON(url, function(data){
		// console.log(data);
		$("#yearSales").highcharts({
			title : {text : data.title},
			xAxis : {
				categories : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
			},
			yAxis : {
				title : {
					text : '매출'
				}
			},
			series : data.series
		});
	
	});
});

$(function(){
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
	})

	document.addEventListener('DOMContentLoaded', function() {
		var myChart = Highcharts.chart('container', {
			chart : {
				type : 'bar'
			},
			title : {
				text : 'Fruit Consumption'
			},
			xAxis : {
				categories : [ 'Apples', 'Bananas', 'Oranges' ]
			},
			yAxis : {
				title : {
					text : 'Fruit eaten'
				}
			},
			series : [ {
				name : 'Jane',
				data : [ 1, 0, 4 ]
			}, {
				name : 'John',
				data : [ 5, 7, 3 ]
			} ]
		});
	});
</script>

<div class="body-container" style="width: 1100px; margin: 0px auto;">
	<div class="body-title">
		<h3>
			<i class="fas fa-search-dollar"></i> 매출 관리
		</h3>
	</div>


	<select id="year">
		<option>년도</option>
		<option>2019</option>
		<option>2018</option>
		<option>2017</option>
	</select>
	
	<!-- 
	<select id="month">
		<option>월</option>
		<c:forEach begin="1" end="12" var="x">
			<option><c:out value="${x}" /></option>
		</c:forEach>
	</select>
	-->



	<div style="clear: both;">
		<div id="yearSales"
			style="width: 500px; height: 300px; float: left; margin: 10px;"></div>
	</div>
	<br> <br>

	<div style="clear: both;">
		<div id="pie3dContainer"
			style="width: 500px; height: 300px; float: left; margin: 10px;"></div>
	</div>

	<div id="container" style="width: 100%; height: 400px;"></div>

</div>