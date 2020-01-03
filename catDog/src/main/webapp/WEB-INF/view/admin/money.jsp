<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/tabs.css" type="text/css">

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-3d.js"></script>

<script type="text/javascript">

$(function(){
	// $("#tab-${group}").addClass("active");
	$("#tab-0").addClass("active");

	
	$("ul.tabs li").click(function(){
		$("#yearSalesSelect").hide();
		$("#yearSales").hide();
		$("#categorySalesSelect").hide();
		$("#categorySales").hide();
		
		tab = $(this).attr("data-tab");
		
		$("ul.tabs li").each(function(){
			$(this).removeClass("active");
		});

		$("#tab-"+tab).addClass("active");
		
		if(tab=="0"){
			$("#yearSales").html("test");
		}else if(tab=="1"){
			$("#yearSalesSelect").show();
			$("#yearSales").show();
			// 1년의 판매현황을 월별로 보여주는 차트
			var url = "<%=cp%>/admin/money/yearSalesChart";

			//페이지 최초 세팅시 차트 불러옴
			yearSalesChart(url);
	
		}else if(tab=="2"){
			$("#yearSales").html("test2");
	
		}else if(tab=="3"){
			$("#categorySalesSelect").show();
			$("#categorySales").show();
			
			var url = "<%=cp%>/admin/money/categorySalesChart";
			
			categorySalesChart(url);
		}
	});

});

$(function(){
	Highcharts.setOptions({
		lang: {
			thousandsSep: ','
		}
		
	});

});

function yearSalesChart(url){
	$.getJSON(url, function(data){

		$("#yearSales").highcharts({
			chart: {
		        type: 'column'
		    },
		    title: {
		        text: data.year+'년 연매출 ('+data.totalYearSales+'원)',
		        align: 'center'
		    },
		    xAxis: {
		        categories: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
		    },
		    yAxis: {
		        min: 0,
		        title: {
		            text: '매출(￦)'
		        },
		        stackLabels: {
		            enabled: true,
		            style: {
		                fontWeight: 'bold',
		                color: ( // theme
		                    Highcharts.defaultOptions.title.style &&
		                    Highcharts.defaultOptions.title.style.color
		                ) || 'gray'
		            },
		            enabled: true
		            
		        }
		    },
		    legend: {
		        align: 'right',
		        x: -10,
		        verticalAlign: 'top',
		        y: 40,
		        floating: true,
		        backgroundColor:
		            Highcharts.defaultOptions.legend.backgroundColor || 'white',
		        borderColor: '#CCC',
		        borderWidth: 1,
		        shadow: false,
		        enabled: true,
		        width:'17%',
		        maxHeight:100
		    },
		    tooltip: {
		        headerFormat: '<b>{point.x}</b><br/>',
		        pointFormat: '{series.name}: {point.y}<br/>',
		        valueSuffix: '원',
		        style: {
		           fontSize: '15px'
		        }
		    },
		    plotOptions: {
		        column: {
		            stacking: 'normal',
		            dataLabels: {
		                enabled: true
		            }
		        },
		        series: {
		        	pointWidth:50
		        }
		    },
		   series: data.productList
		});
	
	});	
	
}

function categorySalesChart(url){
	$.getJSON(url, function(data){
		$("#categorySales").highcharts({
			chart: {
		        type: 'variablepie'
		    },
		    accessibility: {
		        description: 'A variable radius pie chart compares the population density and total land mass for seven European nations: Spain, France, Poland, the Czech Republic, Italy, Switzerland and Germany. The chart visualizes the data by using the width of each section to represent total area and the depth of the section to represent population density. Each section is color-coded according to the country and the chart is interactive: by hovering over each section the data points are exposed in a call-out box. The chart is organized by population density in a counterclockwise direction. Germany has the highest population density at 235.6 people per square kilometer, followed by Switzerland, Italy, the Czech Republic, Poland, France and Spain. France has the largest land mass at 551,500 square kilometers. Spain is the second largest country at 505,370 square kilometers but has the lowest population density at 92.9 people per square kilometer. Switzerland is the smallest nation by land mass at 41,277 square kilometers but it has the second highest population density at 214.5 people per square kilometer.'
		    },
		    title: {
		        text: 'Countries compared by population density and total area.'
		    },
		    tooltip: {
		        headerFormat: '',
		        pointFormat: '<span style="color:{point.color}">\u25CF</span> <b> {point.name}</b><br/>' +
		            'Area (square km): <b>{point.y}</b><br/>' +
		            'Population density (people per square km): <b>{point.z}</b><br/>'
		    },
		    series: [{
		        minPointSize: 10,
		        innerSize: '20%',
		        zMin: 0,
		        name: 'countries',
		        data: [{
		            name: 'Spain',
		            y: 505370,
		            z: 92.9
		        }, {
		            name: 'France',
		            y: 551500,
		            z: 118.7
		        }, {
		            name: 'Poland',
		            y: 312685,
		            z: 124.6
		        }, {
		            name: 'Czech Republic',
		            y: 78867,
		            z: 137.5
		        }, {
		            name: 'Italy',
		            y: 301340,
		            z: 201.8
		        }, {
		            name: 'Switzerland',
		            y: 41277,
		            z: 214.5
		        }, {
		            name: 'Germany',
		            y: 357022,
		            z: 235.6
		        }]
		    }]
		});
	});	
	
}

function selectYearSales(){
	if(!$("#yearSalesSelect option:selected").val()) {
		return;
	}
	
	var url = "<%=cp%>/admin/money/yearSalesChart";
	url += "?year="+$("#yearSalesSelect option:selected").val();
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
					연매출</li>
				<li id="tab-2" data-tab="2">
					분기별 매출</li>
				<li id="tab-3" data-tab="3">
					품목별 매출</li>
			</ul>
	</div>
	<br>
	<br>
	
	
	
	<%-- <select id="month">
		<option>월</option>
		<c:forEach begin="1" end="12" var="x">
			<option><c:out value="${x}월" /></option>
		</c:forEach>
	</select> --%>
	



		
			<select id="yearSalesSelect" onchange="selectYearSales()" style="float: right; margin: 0% 5.5% 0% 0%; display: none;">
				<option value="">년도</option>
				<option value="2020">2020년</option>
				<option value="2019">2019년</option>
				<option value="2018">2018년</option>
				<option value="2017">2017년</option>
			</select>
			<div id="yearSales"
				style="width : 1000px; height: 600px; margin: 0px auto;">
			</div>
		
	
	
	<select id="categorySalesSelect" onchange="selectCategorySales()" style="float: right; margin: 0% 5.5% 0% 0%; display: none;">
			<option value="">년도</option>
			<option value="2020">2020년</option>
			<option value="2019">2019년</option>
			<option value="2018">2018년</option>
			<option value="2017">2017년</option>
		</select>
		<div id="categorySales"
			style="width : 1000px; height: 600px; margin: 0px auto;">
		</div>

	

</div>