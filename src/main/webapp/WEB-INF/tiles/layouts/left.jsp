<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- LEFT-->
<div class="lnb__depth lnb__depth--one">
    <div class="lnb__head">
        <button class="lnb__toggle-btn" type="button" aria-label="닫기"></button>
    </div>
    <ul class="lnb__list" id="left1depth"></ul>
</div>

<div class="lnb__depth lnb__depth--two">
    <ul class="lnb__list" id="left2depth"></ul>
</div>

<div class="lnb__depth lnb__depth--three">
    <ul class="lnb__list" id="left3depth"></ul>
</div>

<script>
    $( document ).ready(function() {

        $.ajax({
            url: '/menu',
            type: 'GET',
            dataType: 'json',
            data : 'gubun=left'
        }).done(function (result) {
            generateLeftmenu(result, $("#left1depth"));
        }).fail(function(xhr, textStatus, errorThrown) {
            if(xhr.status =='403'){
                alert("해당 기능에 대한 권한이 없습니다.");
            } else if (xhr.status == '501') {
                alert("session정보가 없습니다. 로그인페이지로 이동합니다.");
                window.location.href = "/loginView";
            }else if (xhr.status == '500') {
                alert("에러["+textStatus+"]" + errorThrown );
            }
        });

        $.ajax({
            url: '/menutop',
            type: 'GET',
            dataType: 'json',
        }).done(function (result) {
            generateTopmenu(result);
        }).fail(function(xhr, textStatus, errorThrown) {
            if(xhr.status =='403'){
                alert("해당 기능에 대한 권한이 없습니다.");
            }else if (xhr.status == '501') {
                alert("session정보가 없습니다. 로그인페이지로 이동합니다.");
                window.location.href = "/loginView";
            }else if (xhr.status == '500') {
                alert("에러["+textStatus+"]" + errorThrown );
            }
        });
    });

    function generateTopmenu(data){
        var length = data.length;
        var leftHtml = "";
        for(var i=0; i<length; i++ ) {
            leftHtml = "";
            //leftHtml += "<p class=\"level-item\" id=\""+data[i].iconCss+"\">";
            leftHtml += "<a href=\""+ data[i].menuUrl+"\" class=\"etc-btn etc-btn"+data[i].iconCss+"\">" + data[i].menuName + "</a>";
            //leftHtml += "</p>";

            $("#"+data[i].iconCss).addClass("level-item");
            $("#"+data[i].iconCss).html(leftHtml).trigger("create");
        }
    }

    function generateLeftmenu(data, obj){
        var length = data.length;
        var leftHtml = "";
        for(var i=0; i<length; i++ ) {
            if (data[i].lev == 1) {
                leftHtml += "<li class=\"lnb__item lnb__item" + data[i].iconCss + "\">";
                leftHtml += "<a href=\"#\" id=\"left_" + data[i].menuId + "\" onclick=\"getSubmenu('" + data[i].menuId + "','2');\">" + data[i].menuName + "</a>";
            } else if( data[i].lev == 2 ){
                leftHtml += "<li class=\"lnb__item\">";
                if( data[i].menuUrl != '')
                    leftHtml += "<a href=\""+ data[i].menuUrl+"\"  id=\"left_" + data[i].menuId + "\" class='close'>" + data[i].menuName + "</a>";
                else
                    leftHtml += "<a href=\"#\" id=\"left_" + data[i].menuId + "\" onclick=\"getSubmenu('" + data[i].menuId + "','3');\">" + data[i].menuName + "</a>";
            } else if( data[i].lev == 3 ){
                leftHtml += "<li class=\"lnb__item\">";
                leftHtml += "<a href=\""+ data[i].menuUrl+"\" id=\"left_"+ data[i].menuId+ "\">" + data[i].menuName+ "</a>";
            }
            leftHtml += "</li>";
        }
        obj.empty();
        obj.html(leftHtml);
    }

    //lvl은 db조건과 상관없이 ul id 지정때문에 사용함.
    function getSubmenu(menuId, lvl){
        //alert( "menuId=====>"+menuId);
        $.ajax({
            url: '/menusub',
            type: 'GET',
            data: 'menuId='+menuId+'&lvl='+lvl,
            dataType: 'json',
        }).done(function (result) {
            if( lvl == 2)
                generateLeftmenu(result, $("#left2depth"));
            else if( lvl == 3)
                generateLeftmenu(result, $("#left3depth"));

        }).fail(function(xhr, textStatus, errorThrown) {
            if(xhr.status =='403'){
                alert("해당 기능에 대한 권한이 없습니다.");
            }else if (xhr.status == '501') {
                alert("session정보가 없습니다. 로그인페이지로 이동합니다.");
                window.location.href = "/loginView";
            }else if (xhr.status == '500') {
                alert("에러["+textStatus+"]" + errorThrown );
            }
        });
    }
</script>