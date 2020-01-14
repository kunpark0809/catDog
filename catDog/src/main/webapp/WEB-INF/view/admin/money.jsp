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
<script src="https://code.highcharts.com/modules/variable-pie.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

<script type="text/javascript">
$(function(){
	Highcharts.setOptions({
		lang: {
			thousandsSep: ','
		}
		
	});

});

$(function(){
	$("#tab-0").addClass("active");
	$("#subtotal").show();
	
	var url = "<%=cp%>/admin/money/subtotalChart";
	
	subtotalChart(url);
	
	$("ul.tabs li").click(function(){
		$("#yearSalesSelect").hide();
		$("#yearSales").hide();
		$("#categorySalesSelect").hide();
		$("#categorySales").hide();
		$("#subtotal").hide();
		
		tab = $(this).attr("data-tab");
		
		$("ul.tabs li").each(function(){
			$(this).removeClass("active");
		});

		$("#tab-"+tab).addClass("active");
		
		if(tab=="0"){
			$("#subtotal").show();
			
			var url = "<%=cp%>/admin/money/subtotalChart";
			
			subtotalChart(url);
			
		}else if(tab=="1"){
			$("#yearSalesSelect").show();
			$("#yearSales").show();
			// 1년의 판매현황을 월별로 보여주는 차트
			var url = "<%=cp%>/admin/money/yearSalesChart";

			//페이지 최초 세팅시 차트 불러옴
			yearSalesChart(url);
	
		}else if(tab=="2"){
			$("#categorySalesSelect").show();
			$("#categorySales").show();
			
			var url = "<%=cp%>/admin/money/categorySalesChart";
			
			categorySalesChart(url);
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
		        align: 'center',
		        style: {
				       fontSize: '23px'
				    }
		        
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
		        pointFormat: '{series.name}: <b>{point.y}</b>원<br/>',
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
		        description: '품목별로 해당 연도의 매출액과 판매개수를 그래프로 출력. 호의 길이는 매출액의 점유율, 반지름은 판매개수'
		    },
		    title: {
		        text: data.year+'년 품목별 매출액 및 판매개수',
		        style: {
				       fontSize: '23px'
				    }
		    },
		    subtitle: {
		        text: '중심각의 크기는 매출액, 반지름의 길이는 판매개수를 의미합니다.',
		        style: {
				       fontSize: '13px'
				    }
		    },
		    tooltip: {
		    	headerFormat: '<b>{point.x}</b><br/>',
		        pointFormat: '<span style="color:{point.color}">\u25CF</span> <b> {point.name}</b><br/>' +
		            '매출액 : <b>{point.y}</b>원<br/>' +
		            '판매개수 : <b>{point.z}</b>개<br/>',
			    style: {
			       fontSize: '15px'
			    }
		            
		    },
		    series: [{
		        minPointSize: 1,
		        innerSize: '30%',
		        zMin: 0,
		        name: '그래프',
		        data: data.series
		    }],
		    plotOptions: {
		        series: {
		            dataLabels: {
		            	style: {
		            		fontSize: '14px'
		            	}
		            }
		    	}
		    }
		});
	});	
	
}

function subtotalChart(url){
	$.getJSON(url,function(data){
		$("#subtotalChart").highcharts({
			chart: {
		        zoomType: 'xy'
		    },
		    title: {
		        text: '분기별 매출과 변화율'
		    },
		    subtitle: {
		        text: ''
		    },
		    xAxis: [{
		        categories: data.categories,
		        crosshair: true
		    }],
		    yAxis: [{ // Primary yAxis
		        labels: {
		            format: '{value}%',
		            style: {
		                color: Highcharts.getOptions().colors[1]
		            }
		        },
		        title: {
		            text: '매출 변화율',
		            style: {
		                color: Highcharts.getOptions().colors[1]
		            }
		        }
		    }, { // Secondary yAxis
		        title: {
		            text: '분기별 매출',
		            style: {
		                color: Highcharts.getOptions().colors[0]
		            }
		        },
		        labels: {
		            format: '{value} 원',
		            style: {
		                color: Highcharts.getOptions().colors[0]
		            }
		        },
		        opposite: true
		    }],
		    tooltip: {
		        shared: true
		    },
		    legend: {
		        layout: 'vertical',
		        align: 'left',
		        x: 120,
		        verticalAlign: 'top',
		        y: 100,
		        floating: true,
		        backgroundColor:
		            Highcharts.defaultOptions.legend.backgroundColor || // theme
		            'rgba(255,255,255,0.25)'
		    },
		    series: [{
		        name: '분기별 매출',
		        type: 'column',
		        yAxis: 1,
		        data: data.sales,
		        tooltip: {
		            valueSuffix: ' 원'
		        }

		    }, {
		        name: '매출 변화율',
		        type: 'spline',
		        data: data.rates,
		        tooltip: {
		            valueSuffix: '%'
		        }
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

function selectCategorySales(){
	if(!$("#categorySalesSelect option:selected").val()) {
		return;
	}
	
	var url = "<%=cp%>/admin/money/categorySalesChart";
	url += "?year="+$("#categorySalesSelect option:selected").val();
	categorySalesChart(url);
}




	
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
					품목별 매출</li>
			</ul>
	</div>
	<br>
	<br>
	
	<div id="subtotal" style="margin: 0px auto;">
		<br>
		<!-- <div style="text-align: center;"><h4>주식회사 멍냥개냥</h4></div> -->
		<img src="<%=cp%>/resource/img/logos/dogcatdogcat.png" style="display:block; margin:0px auto; height: 150px; width: auto;">
		<br><br>
		
		<table border="1" style=" text-align: center; margin: 0px auto;">
			<tr>
				<td style="width: 160px;">오늘의 주문 수</td>
				<td style="width: 160px;">이번 주의 주문 수</td>
				<td style="width: 160px;">이번 달의 주문 수</td>
				<td style="width: 160px;">올해의 주문 수</td>
				<td style="width: 160px;">총 주문 수</td>
			</tr>
			<tr>
				<td>${daySalesVolume}건</td>
				<td>${weekSalesVolume}건</td>
				<td>${monthSalesVolume}건</td>
				<td>${yearSalesVolume}건</td>
				<td>${totalSalesVolume}건</td>
			</tr>
		
		
		</table>
		
		<br>
		
		<table border="1" style="text-align: center; margin: 0px auto;">
			<tr>
				<td style="width: 160px;">오늘의 매출</td>
				<td style="width: 160px;">이번 주의 매출</td>
				<td style="width: 160px;">이번 달의  매출</td>
				<td style="width: 160px;">올해의 매출</td>
				<td style="width: 160px;">총 매출</td>
			</tr>
			<tr>
				<td>${daySales}원</td>
				<td>${weekSales}원</td>
				<td>${monthSales}원</td>
				<td>${yearSales}원</td>
				<td>${totalSales}원</td>
			</tr>
		</table>
		<br><br><br><br><br>
		<div id="subtotalChart" style="width: 1000px; height: 400px; margin: 0px auto;">
		</div>
	</div>
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