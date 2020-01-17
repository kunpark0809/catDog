<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<link rel="stylesheet" href="<%=cp%>/resource/css/tabs.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/dogshop.css">
<style>
.alert-info {
    border: 1px solid #9acfea;
    border-radius: 4px;
    background-color: #d9edf7;
    color: #31708f;
    padding: 15px;
    margin-top: 10px;
    margin-bottom: 20px;
}

</style>

<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery.form.js"></script>
<script type="text/javascript">
$(function(){
	$("#tab-qna").addClass("active");
	listPage(1);

	$("ul.tabs li").click(function() {
		tab = $(this).attr("data-tab");
		
		$("ul.tabs li").each(function(){
			$(this).removeClass("active");
		});
		
		$("#tab-"+tab).addClass("active");
		
		// listPage(1);
		reloadBoard();
	});
});

function login() {
	location.href="<%=cp%>/member/login";
}

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
			if($.trim(data)=="error") {
				listPage(1);
				return false;
			}	
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


function reloadBoard() {
	var f=document.mypageSearchForm;
	f.condition.value="all";
	f.keyword.value="";
	
	listPage(1);
}

function listPage(page) {
	var $tab = $(".tabs .active");
	var tab = $tab.attr("data-tab");
	var url="<%=cp%>/mypage/"+tab;
	var query="pageNo="+page;
	var search=$('form[name=mypageSearchForm]').serialize();
	query=query+"&"+search;
	var selector = "#tab-content";
	
	ajaxHTML(url, "get", query, selector);
}


function searchList() {
	var f=document.mypageSearchForm;
	f.condition.value=$("#condition").val();
	f.keyword.value=$.trim($("#keyword").val());

	listPage(1);
}

function articleBoard(num, page) {
	var $tab = $(".tabs .active");
	var tab = $tab.attr("data-tab");
	
	var url="<%=cp%>/mypage/"+tab;
	var query="num="+num;
	var search=$('form[name=mypageSearchForm]').serialize();
	query=query+"&pageNo="+page+"&"+search;
	var selector = "#tab-content";
	
	ajaxHTML(url, "get", query, selector);
}

$(document).on("click",".tabs li",function(){
	var subUrl=this.getAttribute("data-tab");
	console.log(subUrl);
	var url="<%=cp%>/mypage/"+subUrl;
	var selector='#tab-content';
	var query="";
	ajaxHTML(url, "get", query, selector);
	
});

</script>

<div class="container-board">
    <div class="body-title">
        <h3><i class="fas fa-chalkboard"></i>&nbsp;&nbsp;  내가 쓴 글 </h3>
    </div>
    
    <div>
            <div style="clear: both;">
	           <ul class="tabs">
			       <li id="tab-qna"  data-tab="qna">qna</li>
			       <li id="tab-tip" data-tab="tip"> 꿀팁 </li>
			       <li id="tab-bbs" data-tab="bbs"> 자유게시판 </li>
			       <li id="tab-mypet" data-tab="mypet"> 내 새끼 자랑 </li>
			       <li id="tab-lostpet" data-tab="lostpet"> 유기동물 </li>
			       <li id="tab-adoption" data-tab="adoption"> 입양 </li>
			   </ul>
		   </div>
		   <div id="tab-content" style="clear:both; padding: 20px 10px 0px;"></div>
    </div>
</div>

<form name="mypageSearchForm" action="" method="post">
    <input type="hidden" name="condition" value="all">
    <input type="hidden" name="keyword" value="">
</form>

