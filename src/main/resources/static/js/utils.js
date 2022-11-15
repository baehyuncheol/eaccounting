function priceFormat(param) {
    return param.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
function removeComma(param) {
    param = String(param);
    return parseInt(param.replace(/,/g,''));
}
function removeCommaForDecimal(param) {
    param = String(param);
    return param.replace(/,/g,'');
}
function uncomma(param) {
    param = String(param);
    return param.replace(/[^\d]+/g, '');
}

function numberOnly(param) {
    return param.replace(/[^0-9]/g,'');
}
function regNumFormat(param) {
    return param.toString().replace(/(\d{3})(\d{2})(\d{5})/, "$1-$2-$3");
}
function approvalNoFormat(param) {
    return param.toString().replace(/(\d{8})(\d{8})(\d{8})/, "$1-$2-$3");
}
function makeDtFormat(param) {
    return param.toString().replace(/(\d{4})(\d{2})(\d{2})/, "$1-$2-$3");
}
function makeDtFormat2(param) {
    return param.toString().replace(/(\d{4})(\d{2})(\d{2})/, "$1.$2.$3");
}
//문자열 날짜형식으로 변환..
function dateparse(str) {
    var y = str.substr(0, 4);
    var m = str.substr(4, 2);
    var d = str.substr(6, 2);

    return new Date(y,m-1,d);
}

(function(){
    $(document).on('keyup','input[inputmode=numeric]',function(event){
        this.value = this.value.replace(/[^0-9]/g,'');   // 입력값이 숫자가 아니면 공백
        this.value = this.value.replace(/,/g,'');          // ,값 공백처리
        this.value = this.value.replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 정규식을 이용해서 3자리 마다 , 추가
    });
})();

(function(){
    $(document).on('keyup','input[inputmode=numericComma]',function(event){
        this.value = this.value.replace(/[^.0-9]/g,'');   // 입력값이 숫자가 아니면 공백
        var bExists = this.value.indexOf(".", 0);//0번째부터 .을 찾는다.
        var strArr = this.value.split('.');
        //정수 부분에만 콤마 달기
        strArr[0] = strArr[0].replace(/,/g,'');          // ,값 공백처리
        strArr[0] = strArr[0].replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 정규식을 이용해서 3자리 마다 , 추가
        if (bExists > -1) {
            //. 소수점 문자열이 발견되지 않을 경우 -1 반환
            this.value = strArr[0] + "." + strArr[1].substring(0,2);
        } else { //정수만 있을경우 //소수점 문자열 존재하면 양수 반환
            this.value = strArr[0];
        }

    });
})();

function formatMoney(number, decPlaces, decSep, thouSep) {
    decPlaces = isNaN(decPlaces = Math.abs(decPlaces)) ? 2 : decPlaces;
    decSep = typeof decSep === "undefined" ? "." : decSep;
    thouSep = typeof thouSep === "undefined" ? "," : thouSep;

    let sign = number < 0 ? "-" : "";
    let i = String(parseInt(number = Math.abs(Number(number) || 0).toFixed(decPlaces)));
    let j = i.length;
    j = j > 3 ? j % 3 : 0;

    return sign +
      (j ? i.substr(0, j) + thouSep : "") +
      i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + thouSep) +
      (decPlaces ? decSep + Math.abs(number - i).toFixed(decPlaces).slice(2) : "");
}

/**
 * 좌측문자열채우기
 * @params
 *  - str : 원 문자열
 *  - padLen : 최대 채우고자 하는 길이
 *  - padStr : 채우고자하는 문자(char)
 */
function lpad(str, padLen, padStr) {
    if (padStr.length > padLen) {
        console.log("오류 : 채우고자 하는 문자열이 요청 길이보다 큽니다");
        return str;
    }
    str += ""; // 문자로
    padStr += ""; // 문자로
    while (str.length < padLen)
        str = padStr + str;
    str = str.length >= padLen ? str.substring(0, padLen) : str;
    return str;
}

/**
 * 우측문자열채우기
 * @params
 *  - str : 원 문자열
 *  - padLen : 최대 채우고자 하는 길이
 *  - padStr : 채우고자하는 문자(char)
 */
function rpad(str, padLen, padStr) {
    if (padStr.length > padLen) {
        console.log("오류 : 채우고자 하는 문자열이 요청 길이보다 큽니다");
        return str + "";
    }
    str += ""; // 문자로
    padStr += ""; // 문자로
    while (str.length < padLen)
        str += padStr;
    str = str.length >= padLen ? str.substring(0, padLen) : str;
    return str;
}

function updateQueryStringParameter(uri, key, value) {
    var re = new RegExp("([?&])" + key + "=.*?(&|$)", "i");
    var separator = uri.indexOf('?') !== -1 ? "&" : "?";
    if (uri.match(re)) {
        return uri.replace(re, '$1' + key + "=" + value + '$2');
    }
    else {
        return uri + separator + key + "=" + value;
    }
}

