
// Main Navigator
$('.quick-btn').on('click', function() {
  let attribute = $(this).attr('class');
  let className = '.lnb__item' + attribute.substring(attribute.indexOf('--'), attribute.length);
  $('.quick-btn').removeClass('is-active');
  $(this).addClass('is-active');
  $(className).find('a').focus()
});

$('.main-nav__item > a').on('click', function() {
  let attribute = $(this).parent('li').attr('class');
  let className = '.lnb__item' + attribute.substring(attribute.indexOf('--'), attribute.length);
  $('.main-nav__item > a').removeClass('is-active');
  $(this).addClass('is-active');
  $(className).find('a').focus()
});


// LNB
$(document).on('click', '.lnb__toggle-btn', function() {
  if (!$('.lnb').hasClass('is-active')) {
    $('.lnb').addClass('is-active')
  } else {
    $('.lnb').removeClass('is-active')
  }

  // tui grid refreshLayout() 호출
  $("div[data-grid-id]").each(function () {
    let tuiGridDivId = $(this).parent('div').attr('id');
    let tuiGridTemp = (new Function('return ' + tuiGridDivId))();
    tuiGridTemp.refreshLayout();
  });
});

$(document).on('click focus', '.lnb__item a', function() {
  if (!$(this).parents('.lnb__depth').hasClass('lnb__depth--three')) {
    $(this).parent().siblings('li').find('a').removeClass('is-active');
    $(this).addClass('is-active');

    if ($(this).parents('.lnb__depth').hasClass('lnb__depth--one')) {
      let attribute = $(this).parent('li').attr('class');
      let className = '.main-nav__item' + attribute.substring(attribute.indexOf('--'), attribute.length);
      $('.main-nav__item > a').removeClass('is-active');
      $(className).find('a').addClass('is-active');

      $('.lnb__depth--two').fadeIn();
      $('.lnb__depth--three').fadeOut();

      //ajax 값 입력전 비워두기..
      $("#left3depth").empty();
    } else if ($(this).parents('.lnb__depth').hasClass('lnb__depth--two')) {
      if(!$(this).hasClass('close')) {
        $('.lnb__depth--three').fadeIn();
      } else {
        $('.lnb__depth--three').fadeOut();
      }
    }
  }
});

$('.lnb').on('mouseleave', function() {
  $('.lnb__depth--two, .lnb__depth--three').fadeOut();
  $('.lnb__item a').removeClass('is-active').blur();
  $('.main-nav__item > a').removeClass('is-active');
  $("#left2depth").empty();
  $("#left3depth").empty();
});


// Checkbox
$('.checkbox').each(function(i) {
  if ($('.checkbox').eq(i).find('input:checkbox').is(':disabled')) {
    $('.checkbox').eq(i).addClass('is-disabled');
  }

  if ($('.checkbox').eq(i).find('input:checkbox').is(':checked')) {
    $('.checkbox').eq(i).addClass('is-active');
  }
});

$(document).on('click', '.checkbox input:checkbox', function() {
  let chk = $(this).is(':checked');
  if (chk) {
    $(this).parent('.checkbox').addClass('is-active');
  } else {
    $(this).parent('.checkbox').removeClass('is-active');
  }
});

// table all-checkbox 
$(document).on('click', '.check-cell input:checkbox', function() {
  if($(this).prop("checked")) {
    $(this).parents('table').find("td:first-child .checkbox").addClass('is-active');
    $(this).parents('table').find("td:first-child input[type=checkbox]").prop("checked", true);
  } else {
    $(this).parents('table').find("td:first-child .checkbox").removeClass('is-active');
    $(this).parents('table').find("td:first-child input[type=checkbox]").prop("checked", false);
  } 
});


// Radio button
$('.radio').each(function(i) {
  if ($('.radio').eq(i).find('input:radio').is(':disabled')) {
    $('.radio').eq(i).addClass('is-disabled');
  }

  if ($('.radio').eq(i).find('input:radio').is(':checked')) {
    $('.radio').eq(i).addClass('is-active');
  }
});

$(document).on('click', '.radio input:radio', function() {
  if ($(this).parents('.col-type').length) {
    $(this).parents('.col-type').find('.radio').removeClass('is-active');
  }

  $(this).parents('.control').find('.radio').removeClass('is-active');
  $(this).parent('.radio').addClass('is-active');
});


// Input box reset
$('.control--reset .input').keyup(function (e){
  let contentsText = $(this).val();
  contentsText.length > 0 ? $(this).siblings('.clear-btn').show() : $(this).siblings('.clear-btn').hide();
});

$('.clear-btn').on('click', function() {
  $(this).siblings('.input').val('').focus();
  $(this).hide();
});


// Modal popup
$('.modal-close, .modal-btn.is-cancel').on('click', function() {
  $(this).parents('.modal').removeClass('is-active');
});

$(".modal-card").draggable({
  cancel: ".modal-card-body"
});


// Bookmark
$('.bookmark-btn').on('click', function() {
  if(!$(this).hasClass('is-active')) {
    $(this).addClass('is-active');
  } else {
    $(this).removeClass('is-active');
  }
});

// 3자리수 ',' 처리
function inputNumberAutoComma(obj) {
  var number = obj.value;
  var integer = obj.value;
  var point = number.indexOf(".");
  var decimal = "";
  var chekcd = "";

  // 첫번째 수부터 소수점 기호( . )를 사용 방지
  if(number.charAt(0) === ".") {
      alert("첫번째 수부터 소수점 기호( . )를 사용할 수 없습니다.");
      obj.value = "";
      return false;
  }
  
  // 소수점이 존재하면 태우는 분기
  if(point > 0) {

      // 소수점 앞 자리값만을 따로 담는다.
      integer = number.substr(0, point);

      // 소수점 아래 자리값만을 따로 담는다.
      decimal = number.substr((point + 1), number.length);
      chekcd = inputNumberisFinit(decimal);

      if(chekcd == "N") {
          alert("문자는 입력하실 수 없습니다.");
          obj.value = "";
          return false;
      }
  }

  // 정수형의 콤마를 제거한다.
  integer = integer.replace(/\,/g, "");
  chekcd = inputNumberisFinit(integer);

  if(chekcd === "N") {
      alert("문자는 입력하실 수 없습니다.");
      obj.value = "";
      return false;
  }

  // 정수형을 한번더 점검한다.
  integer = inputNumberWithComma(inputNumberRemoveComma(integer));
  
  // 소수가 존재하면 나누었던 콤마 기호를 삽입한다.
  if(point > 0) {
      obj.value = integer + "." + decimal;
  }
  
  // 소수가 존재하지 않는다면 콤마값을 넣은 정수만 삽입한다.
  else {
      obj.value = integer;
  }
}

// 천단위 이상의 숫자에 콤마( , )를 삽입하는 함수
function inputNumberWithComma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, "$1,");
}

// 콤마( , )가 들어간 값에 콤마를 제거하는 함수
function inputNumberRemoveComma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, "");
}

// 문자 여부를 확인하고 문자가 존재하면 N, 존재하지 않으면 Y를 리턴한다.
function inputNumberisFinit(str) {
    if(isFinite(str) === false) {
        return "N";
    } else {
        return "Y";
    }
}


function comm_favorit(obj, menuId, transPatternCode) {
  let flag = "";
  if(!$(obj).hasClass('is-active')) {
    //즐겨찾기 등록
    flag = "C";
  } else {
    //즐겨찾기 삭제
    flag = "D";
  }

  var params = {
    "menuId"		    : menuId
    ,"transPatternCode"	: transPatternCode
    ,"flag"		        : flag
  };

  $.ajax({
    url: '/paydoc/favorit',
    type: 'POST',
    data: params,
  }).done(function (result) {

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


// tui-grid - checkDisabled: true 에 맞는 custom-checkbox disabled 처리
$(document).ready(function() {
  $('.tui-grid-cell-disabled .hidden-input').attr('disabled', true);

  $('.main-nav__quick .quick-btn').on('click', function() {
    console.log("click");
    $('.lnb__depth--two').hide();
  });
});