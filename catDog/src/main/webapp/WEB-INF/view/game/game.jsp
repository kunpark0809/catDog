<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp=request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/game.css">
<script src='https://cdn.sobekrepository.org/includes/jquery-rotate/2.2/jquery-rotate.min.js'></script>
<style type="text/css">
.ui-dialog-titlebar{
   background: none;
    color: black;
    border: none;
    border-bottom: 1px solid #e4e4e4;
    border-radius: 0px;
}
.ui-dialog .ui-dialog-titlebar {
    padding-left: 0px;
}
.ui-dialog{
   padding: 5px 20px;
   border-radius: 0px;
   position: fixed;
   
}
.dialog_cancel{
   background: #D96262;
   color: white;
   border: 1px solid #D96262;
   width: 25%;
   padding: 5px 0px;
}
</style>

<script type="text/javascript">
(function($) {
     $.fn.extend({

       roulette: function(options) {

         var defaults = {
           angle: 0,
           angleOffset: -45,
           speed: 5000,
           easing: "easeInOutElastic",
         };

         var opt = $.extend(defaults, options);

         return this.each(function() {
           var o = opt;

           var data = [
                  {
               color: '#3f297e',
               text: '1000 Point'
             },
             {
               color: '#1d61ac',
               text: '강아지 사료'
             },
             {
               color: '#169ed8',
               text: '고양이 사료'
             },
             {
               color: '#209b6c',
               text: '강아지 간식'
             },
             {
               color: '#60b236',
               text: '고양이 간식'
             },
             {
               color: '#efe61f',
               text: '강아지 장난감 '
             },
             {
               color: '#f7a416',
               text: '고양이 장난감 '
             },
             {
               color: '#e6471d',
               text: '강아지 집'
             },
             {
               color: '#dc0936',
               text: '고양이 집'
             },
             {
               color: '#e5177b',
               text: '2000 Point'
             },
             {
               color: '#be107f',
               text: '강아지 용품'
             },
             {
               color: '#881f7e',
               text: '고양이  용품'
             }
           ];
    
           var $wrap = $(this);
           var $btnStart = $wrap.find("#btn-start");
           var $roulette = $wrap.find(".roulette");
           var wrapW = $wrap.width();
           var angle = o.angle;
           var angleOffset = o.angleOffset;
           var speed = o.speed;
           var esing = o.easing;
           var itemSize = data.length;
           var itemSelector = "item";
           var labelSelector = "label";
           var d = 360 / itemSize;
           var borderTopWidth = wrapW;
           var borderRightWidth = tanDeg(d);

           for (i = 1; i <= itemSize; i += 1) {
             var idx = i - 1;
             var rt = i * d + angleOffset;
             var itemHTML = $('<div class="' + itemSelector + '">');
             var labelHTML = '';
                 labelHTML += '<p class="' + labelSelector + '">';
                 labelHTML += '   <span class="text">' + data[idx].text + '<\/span>';
                 labelHTML += '<\/p>';

             $roulette.append(itemHTML);
             $roulette.children("." + itemSelector).eq(idx).append(labelHTML);
             $roulette.children("." + itemSelector).eq(idx).css({
               "left": wrapW / 2,
               "top": -wrapW / 2,
               "border-top-width": borderTopWidth,
               "border-right-width": borderRightWidth,
               "border-top-color": data[idx].color,
               "transform": "rotate(" + rt + "deg)"
             });

             var textH = parseInt(((2 * Math.PI * wrapW) / d) * .5);

             $roulette.children("." + itemSelector).eq(idx).children("." + labelSelector).css({
               "height": textH + 'px',
               "line-height": textH + 'px',
               "transform": 'translateX(' + (textH * 1.3) + 'px) translateY(' + (wrapW * -.3) + 'px) rotateZ(' + (90 + d * .5) + 'deg)'
             });

           }

           function tanDeg(deg) {
             var rad = deg * Math.PI / 180;
             return wrapW / (1 / Math.tan(rad));
           }


           $btnStart.on("click", function() {
             rotation();
        	  
           });

           function rotation() {

             var completeA = 360 * r(5, 10) + r(0, 360);

             $roulette.rotate({
               angle: angle,
               animateTo: completeA,
               center: ["50%", "50%"],
               easing: $.easing.esing,
               callback: function() {
                 var currentA = $(this).getRotateAngle();

                 console.log(currentA);

               },
               duration: speed
             });
           }

           function r(min, max) {
             return Math.floor(Math.random() * (max - min + 1)) + min;
           }

         });
       }
     });
   })(jQuery);

   $(function() {

     $('.box-roulette').roulette();

   });
   
function ajaxJSON(url, type, query, fn) {
		$.ajax({
			type:type
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data) {
				fn(data);
			}
			,beforeSend:function(jqXHR) {
		        jqXHR.setRequestHeader("AJAX", true);
		    }
		    ,error:function(jqXHR) {
		    	if(jqXHR.status==403) {
		    		login();
		    		return false;
		    	}
		    	console.log(jqXHR.responseText);
		    }
		});
	}

function ajaxHTML(url, type, query, selector) {
		$.ajax({
			type:type
			,url:url
			,data:query
			,success:function(data) {
				$(selector).html(data);
			}
			,beforeSend:function(jqXHR) {
		        jqXHR.setRequestHeader("AJAX", true);
		    }
		    ,error:function(jqXHR) {
		    	if(jqXHR.status==403) {
		    		login();
		    		return false;
		    	}
		    	console.log(jqXHR.responseText);
		    }
		});
	}
	

function report(){
	$('#report_dialog').dialog({
		  modal: true,
		  height: 300,
		  width: 500,
		  title: '서비스 점검중',
		  close: function(event, ui) {
		  },
		  open: function(event, ui) {
              $(".ui-dialog-titlebar-close", $(this).parent()).hide();
           }
	});
	
}
	
	
$(function(){
	$(".btnDialogCancel").click(function(){
		$('#report_dialog').dialog("close");
	});
});

</script>
<div class="container-board">
	<div class="body-title">
		<span style="font-family: Webdings"><i class="fas fa-gamepad"></i> 게임</span><br>
		<h4><span style="width: 100%; text-align: center; display: inline-block;"> 오늘의 주인공은 누구냥 <i class="far fa-thumbs-up"></i> </span></h4>
	</div>
	<div class="box-roulette">
   		<div class="markers"></div>
   			<button type="button" id="btn-start" onclick="report()">
      			돌려 돌려<br>돌림판
   			</button>
   		<div class="roulette" id="roulette"></div>
	</div>

<div id="report_dialog" style="display: none; text-align: center;">
			<strong><br><br>서비스 진행 준비중 입니다.<br> 이용에 불편을 드려 죄송합니다.</strong>
			<br><br>
	<div class="btn_box" align="center" style="padding-top: 20px;">
				<button type="button" class="btnDialogCancel dialog_cancel">확인</button>
	</div>
</div>
</div>