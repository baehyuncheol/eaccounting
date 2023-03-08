<%@ page contentType="text/html;charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%--<spring:eval expression="@environment.getProperty('eaccounting.groupware.serverhost')" var="gwhosts" />--%>
<section class="contents__body">
    <!--
        type별로 include를 달리 한다...
        type별로 include를 달리 한다...
    -->
    <form id="form" name="form"<c:if test="${docType eq 'AA'}"> method="post" enctype="multipart/form-data"</c:if>>
        <input name="emplNo" type="hidden" value="${SESSION_USERINFO.emplNo}">
        <input name="deptCode" type="hidden" value="${SESSION_USERINFO.deptCode}">
        <input name="positionName" type="hidden" value="${SESSION_USERINFO.positionName}">
        <input name="deptName" type="hidden" value="${SESSION_USERINFO.deptName}">
        <input name="transPatternCode" type="hidden" value="${cat.transPatternCode}">
        <input name="docType" type="hidden" value="AA">
        <input name="payDocNo" type="hidden" value="${payDocNo}">
        <input type="hidden" name="menuId" value="${menuId}">
        <input type="hidden" name="apprvTitle" value="${naviMap['naviName3']}">
        <%--
        <input type="hidden" name="apprvTitle" value="${naviMap['naviName3']}-${SESSION_USERINFO.userName}">
        --%>
        <!-- 임시저장 여부 flag -->
        <input type="hidden" name="flag" value="">
        <c:set var="docType" value='AA' />
        <c:choose>
            <c:when test="${docType eq 'A'}">
                <%-- A Type 이면 --%>
                <c:import url="/WEB-INF/views/payDoc/template/Atype.jsp"/>
            </c:when>
            <c:when test="${docType eq 'AA'}">
                <%-- AA Type 이면 --%>
                <c:import url="/WEB-INF/views/payDoc/template/AAtype.jsp"/>
            </c:when>
            <c:when test="${docType eq 'AB'}">
                <%-- AA Type 이면 --%>
                <c:import url="/WEB-INF/views/payDoc/template/ABtype.jsp"/>
            </c:when>
            <c:when test="${docType eq 'B'}">
            <%-- B Type 이면 --%>
                <c:import url="/WEB-INF/views/payDoc/template/Btype.jsp"/>
            </c:when>
            <c:when test="${docType eq 'C'}">
            <%-- C Type 이면 --%>
                <c:import url="/WEB-INF/views/payDoc/template/Ctype.jsp"/>
            </c:when>
            <%-- D Type 이면 --%>
            <c:when test="${docType eq 'D'}">
                <%-- B Type 이면 --%>
                <c:import url="/WEB-INF/views/payDoc/template/Dtype.jsp"/>
            </c:when>
            <c:when test="${docType eq 'E'}">
            <%-- E Type 이면 --%>
                <c:import url="/WEB-INF/views/payDoc/template/Etype.jsp"/>
            </c:when>
            <%-- F Type 이면 지출결의>외환거래매입--%>
            <c:when test="${docType eq 'F'}">
                <c:import url="/WEB-INF/views/payDoc/template/Ftype.jsp"/>
            </c:when>
            <%-- G Type 이면 지출결의>원천세--%>
            <c:when test="${docType eq 'G'}">
                <c:import url="/WEB-INF/views/payDoc/template/Gtype.jsp"/>
            </c:when>
            <%-- H Type 이면 지출결의>원천세>기타소득--%>
            <c:when test="${docType eq 'H'}">
                <c:import url="/WEB-INF/views/payDoc/template/Htype.jsp"/>
            </c:when>
            <%-- I Type 이면 지출결의>선급>선급금 신청--%>
            <c:when test="${docType eq 'I'}">
                <c:import url="/WEB-INF/views/payDoc/template/Itype.jsp"/>
            </c:when>
            <%-- K Type 이면 지출결의>선급급-선급금정산--%>
            <c:when test="${docType eq 'K'}">
                <c:import url="/WEB-INF/views/payDoc/template/Ktype.jsp"/>
            </c:when>
            <%-- L Type 이면 --%>
            <c:when test="${docType eq 'L'}">
                <c:import url="/WEB-INF/views/payDoc/template/Ltype.jsp"/>
            </c:when>
            <%-- M Type 이면 지출결의>가지급금-가지급금정산--%>
            <c:when test="${docType eq 'M'}">
                <c:import url="/WEB-INF/views/payDoc/template/Mtype.jsp"/>
            </c:when>
            <%-- N Type 이면 지출결의>선급보험료-건물/구축물--%>
            <c:when test="${docType eq 'N'}">
                <c:import url="/WEB-INF/views/payDoc/template/Ntype.jsp"/>
            </c:when>
            <%-- O Type 이면 지출결의>선급보험료-기타--%>
            <c:when test="${docType eq 'O'}">
                <c:import url="/WEB-INF/views/payDoc/template/Otype.jsp"/>
            </c:when>

            <%-- P Type 이면 지출결의>선급보험료-건물/구축물--%>
            <c:when test="${docType eq 'P'}">
                <c:import url="/WEB-INF/views/payDoc/template/Ptype.jsp"/>
            </c:when>

            <%-- Q Type 이면 지출결의>기타-대체분개--%>
            <c:when test="${docType eq 'Q'}">
                <c:import url="/WEB-INF/views/payDoc/template/Qtype.jsp"/>
            </c:when>

            <%-- R Type 이면 --%>
            <c:when test="${docType eq 'R'}">
                <c:import url="/WEB-INF/views/payDoc/template/Rtype.jsp"/>
            </c:when>

            <%-- T Type 이면 지출결의>외환거래처분--%>
            <c:when test="${docType eq 'T'}">
                <c:import url="/WEB-INF/views/payDoc/template/Ttype.jsp"/>
            </c:when>

            <%-- U Type 이면 --%>
            <c:when test="${docType eq 'U'}">
                <c:import url="/WEB-INF/views/payDoc/template/Utype.jsp"/>
            </c:when>

            <%-- V Type 이면 거래처등록--%>
            <c:when test="${docType eq 'V'}">
                <c:import url="/WEB-INF/views/payDoc/template/Vtype.jsp"/>
            </c:when>

            <%-- W Type 이면 시내교통비--%>
            <c:when test="${docType eq 'W'}">
                <c:import url="/WEB-INF/views/payDoc/template/Wtype.jsp"/>
            </c:when>

            <%-- Y Type 이면 실비정산--%>
            <c:when test="${docType eq 'Y'}">
                <c:import url="/WEB-INF/views/payDoc/template/Ytype.jsp"/>
            </c:when>

            <%-- Y Type 이면 실비정산--%>
            <c:when test="${docType eq 'Z'}">
                <c:import url="/WEB-INF/views/payDoc/template/Ztype.jsp"/>
            </c:when>

            <%-- docType이 없으면 일단 A로 보여준다... --%>
            <c:otherwise>
                <c:import url="/WEB-INF/views/payDoc/template/Atype.jsp"/>
            </c:otherwise>
        </c:choose>
    </form>
</section>

<c:choose>
    <c:when test="${docType eq 'A'}">
        <%-- A Type 이면 --%>
        <!--계정과목 매칭된 계정과목만 나오도록..-->
        <c:import url="/WEB-INF/views/payDoc/accountmybatis.jsp"/>
        <!--세금계산서-->
        <c:import url="/WEB-INF/views/payDoc/taxbill.jsp"/>
        <!--거래처-->
        <c:import url="/WEB-INF/views/payDoc/businesspartners.jsp"/>

    </c:when>
    <c:when test="${docType eq 'AA'}">
        <%-- AA Type 이면 --%>
        <!--계정과목 매칭된 계정과목만 나오도록..-->
        <%--<c:import url="/WEB-INF/views/payDoc/accountmybatis.jsp"/>--%>
        <!--세금계산서-->
        <%--<c:import url="/WEB-INF/views/payDoc/taxbill.jsp"/>--%>
        <!--거래처-->
        <c:import url="/WEB-INF/views/payDoc/businesspartners.jsp"/>

    </c:when>
    <c:when test="${docType eq 'AB'}">
        <%-- AB Type 이면 --%>
        <c:import url="/WEB-INF/views/payDoc/bmsinterface.jsp"/>
    </c:when>
    <c:when test="${docType eq 'B'}">
        <c:import url="/WEB-INF/views/payDoc/rentaldepositvendor.jsp"/>
        <c:import url="/WEB-INF/views/payDoc/accountmybatis.jsp"/>
        <!--거래처-->
        <c:import url="/WEB-INF/views/payDoc/businesspartners.jsp"/>
    </c:when>
    <c:when test="${docType eq 'C'}">
        <c:import url="/WEB-INF/views/payDoc/rentaldepositvendor.jsp"/>
        <c:import url="/WEB-INF/views/payDoc/accountmybatis.jsp"/>
        <!--거래처-->
        <c:import url="/WEB-INF/views/payDoc/businesspartners.jsp"/>
    </c:when>
    <c:when test="${docType eq 'D'}">
        <c:import url="/WEB-INF/views/payDoc/rentaldepositvendor.jsp"/>
        <c:import url="/WEB-INF/views/payDoc/accountmybatis.jsp"/>
        <!--거래처-->
        <c:import url="/WEB-INF/views/payDoc/businesspartners.jsp"/>
    </c:when>
    <c:when test="${docType eq 'E'}">
        <c:import url="/WEB-INF/views/payDoc/rentaldepositvendor.jsp"/>
        <c:import url="/WEB-INF/views/payDoc/accountmybatis.jsp"/>
        <!--거래처-->
        <c:import url="/WEB-INF/views/payDoc/businesspartners.jsp"/>
    </c:when>
    <c:when test="${docType eq 'G'}">
        <c:import url="/WEB-INF/views/payDoc/accountmybatis.jsp"/>
        <!--거래처-->
        <c:import url="/WEB-INF/views/payDoc/businesspartners.jsp"/>
    </c:when>
    <c:when test="${docType eq 'H'}">
        <c:import url="/WEB-INF/views/payDoc/accountmybatis.jsp"/>
        <!--거래처-->
        <c:import url="/WEB-INF/views/payDoc/businesspartners.jsp"/>
    </c:when>
    <c:when test="${docType eq 'K'}">
        <c:import url="/WEB-INF/views/payDoc/accountmybatis.jsp"/>
        <!--선급금신청내역-->
        <c:import url="/WEB-INF/views/payDoc/prepaymentCalc.jsp"/>
    </c:when>
    <c:when test="${docType eq 'L'}">
        <c:import url="/WEB-INF/views/payDoc/accountmybatis.jsp"/>
    </c:when>
    <c:when test="${docType eq 'M'}">
        <!--가지급신청내역-->
        <c:import url="/WEB-INF/views/payDoc/accountmybatis.jsp"/>
        <c:import url="/WEB-INF/views/payDoc/suspaymentCalc.jsp"/>
    </c:when>
    <c:when test="${docType eq 'P'}">
        <c:import url="/WEB-INF/views/payDoc/accountmybatis.jsp"/>
        <!--거래처-->
        <c:import url="/WEB-INF/views/payDoc/businessallpartners.jsp"/>
    </c:when>
    <c:when test="${docType eq 'Q'}">
        <c:import url="/WEB-INF/views/payDoc/account.jsp"/>
        <!--세금계산서-->
        <c:import url="/WEB-INF/views/payDoc/taxbill.jsp"/>
        <!--거래처-->
        <c:import url="/WEB-INF/views/payDoc/businessallpartners.jsp"/>
    </c:when>
    <c:when test="${docType eq 'R'}">
        <c:import url="/WEB-INF/views/payDoc/accountmybatis.jsp"/>
        <!--거래처-->
        <c:import url="/WEB-INF/views/payDoc/businesspartners.jsp"/>
    </c:when>
    <c:when test="${docType eq 'U'} || ${docType eq 'Z'}">
        <!--매출 import 필요없음..-->
    </c:when>
    <c:when test="${docType eq 'W'}">
        <!--시내교통비정산서는 사원조회팝업 -->
        <jsp:include page="/WEB-INF/views/popup/empPopup.jsp"/>
    </c:when>
    <c:when test="${docType eq 'Y'}">
        <!--계정과목 매칭된 계정과목만 나오도록..-->
        <c:import url="/WEB-INF/views/payDoc/accountmybatis.jsp"/>
        <!--실비정산은 사원조회팝업 -->
        <jsp:include page="/WEB-INF/views/popup/empPopup.jsp"/>
    </c:when>
    <c:when test="${docType eq 'X'}">
    <script>
        alert( "서비스 준비중입니다.!" );
        history.back(-1);
    </script>
    </c:when>
    <c:otherwise>
        <c:import url="/WEB-INF/views/payDoc/account.jsp"/>
        <!--세금계산서-->
        <c:import url="/WEB-INF/views/payDoc/taxbill.jsp"/>
        <!--거래처-->
        <c:import url="/WEB-INF/views/payDoc/businesspartners.jsp"/>
    </c:otherwise>
</c:choose>

<!--예산부서-->
<c:import url="/WEB-INF/views/payDoc/budgetdept.jsp"/>

<script type="text/javascript">
    //오늘 날짜
    let todayDate = new Date();
    const date = todayDate.toISOString().slice(0, 10);
    // Bookmark
    $('.bookmark-btn').on('click', function() {
        if(!$(this).hasClass('is-active')) {
            //즐겨찾기 등록
            fn_favorit('C', $(this));
        } else {
            //즐겨찾기 삭제
            fn_favorit('D', $(this));
        }
    });

    function fn_favorit(flag, obj)
    {
        var params = {
            "menuId"		    : "${menuId}"
            ,"transPatternCode"	: "${cat.transPatternCode}"
            ,"flag"		        : flag
        };

        $.ajax({
            url: '/payDoc/favorit',
            type: 'POST',
            data: params,
        }).done(function (result) {
            if( flag == 'C')
                obj.addClass('is-active');
            else
                obj.removeClass('is-active');
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

    function fn_goGroupware(payDocNo)
    {
        var link = "${gwhosts}/Account/eAccountingToApproval?co_cd=300&emp_no=${SESSION_USERINFO.emplNo}&work_kind=${cat.docType}&work_key="+ payDocNo;
        window.open(link);
    }

    //분개장 라인 추가..
    function fn_journalAdd(obj)
    {
        <c:choose>
            <c:when test="${docType eq 'A'}"> //일반비용
            var budgetDeptCode = $("select[name=budgetDept] option:selected").val();
            var budgetDeptName = $("select[name=budgetDept] option:selected").text();
            </c:when>
            <c:when test="${docType eq 'AA'}"> //일반비용기타
            var budgetDeptCode = $("select[name=budgetDept] option:selected").val();
            var budgetDeptName = $("select[name=budgetDept] option:selected").text();
            </c:when>
            <c:when test="${docType eq 'G'}"> //원천세
            var budgetDeptCode = $("select[name=budgetDept] option:selected").val();
            var budgetDeptName = $("select[name=budgetDept] option:selected").text();
            </c:when>
            <c:when test="${docType eq 'H'}"> //원천세 기타
            var budgetDeptCode = $("select[name=budgetDept] option:selected").val();
            var budgetDeptName = $("select[name=budgetDept] option:selected").text();
            </c:when>
            <c:when test="${docType eq 'I'}"> //선급
            var budgetDeptCode = "7000";
            var budgetDeptName = "㈜GS공통";
            </c:when>
            <c:when test="${docType eq 'K'}">
            var budgetDeptCode = "7000";
            var budgetDeptName = "㈜GS공통";
            </c:when>
            <c:when test="${docType eq 'N'}">
            var budgetDeptCode = "7000";
            var budgetDeptName = "㈜GS공통";
            </c:when>
            <c:when test="${docType eq 'O'}">
            var budgetDeptCode = "7000";
            var budgetDeptName = "㈜GS공통";
            </c:when>
            <c:when test="${docType eq 'P'}"> //투자
            var budgetDeptCode = "7000";
            var budgetDeptName = "㈜GS공통";
            </c:when>
            <c:otherwise>
            var budgetDeptCode = "${orgbudgetmap.budgetCode}";
            var budgetDeptName = "${orgbudgetmap.budgetCodeName}";
            </c:otherwise>
        </c:choose>

        //alert(  "budgetDeptCode===>"+budgetDeptCode );
        //alert(  "budgetDeptName===>"+budgetDeptName );

        //분개장 생성되면 세금계산서 버튼 비활성화
        $("#taxbillSearch").attr('disabled', true);
        $("#taxbillSearchOtype").attr('disabled', true);
        //분개장을 수동으로 추가하더라도 Header에 있는 input박스는 수정불가 하도록 수정.
        fn_inputselectControl(true);

        var generateHtml = "";
        generateHtml += "<tr>";
        generateHtml += "    <td>";
        generateHtml += "       <div class=\"control\">";
        generateHtml += "           <label class=\"checkbox\">";
        generateHtml += "           <input name=\"journalCheck\" type=\"checkbox\">";
        generateHtml += "           </label>";
        generateHtml += "       </div>";
        generateHtml += "    </td>";
        generateHtml += "    <td>";
        generateHtml += "       <div class=\"control\">";
        generateHtml += "           <div class=\"select\">";
        generateHtml += "               <select name=\"drCrInd\" required>";
        if(obj.children().length < 1){
            generateHtml += "                   <option value=\"S\" selected>차</option>";
            generateHtml += "                   <option value=\"H\">대</option>";
        }else{
            generateHtml += "                   <option value=\"S\">차</option>";
            generateHtml += "                   <option value=\"H\" selected>대</option>";
        }
        generateHtml += "               </select>";
        generateHtml += "           </div>";
        generateHtml += "       </div>";
        generateHtml += "    </td>";
        generateHtml += "    <td>";
        generateHtml += "       <div class=\"field has-addons\">";
        generateHtml += "           <div class=\"control is-expanded\">";
        generateHtml += "               <input class=\"input\" type=\"text\" name=\"acctCodeName\" onKeyDown=\"fn_accntKeyDown(this);\" value='<c:out value="${account.acctName}"/>' readonly=\"readonly\"/>";
        generateHtml += "               <input class=\"input\" type=\"hidden\" name=\"acctCode\" value='<c:out value="${account.acctCode}"/>' />";
        generateHtml += "           </div>";
        generateHtml += "           <div class=\"control\">";
        generateHtml += "               <button name=\"btnAccountCode\" class=\"icon-btn icon-btn--search\" type=\"button\" onclick=\"fn_AccountDivCreate(this);\">검색</button>";
        generateHtml += "           </div>";
        generateHtml += "       </div>";
        generateHtml += "    </td>";
        generateHtml += "    <td>";
        generateHtml += "       <div class=\"field has-addons\">";
        generateHtml += "           <div class=\"control is-expanded\">";
        generateHtml += "               <input class=\"input\" type=\"text\" name=\"budgetCodeName\" onKeyDown=\"fn_budgetKeyDown(this);\" value='"+ budgetDeptName +"' readonly=\"readonly\"/>";
        generateHtml += "               <input class=\"input\" type=\"hidden\" name=\"budgetCode\" value='"+ budgetDeptCode +"' />";
        generateHtml += "           </div>";
        generateHtml += "           <div class=\"control\">";
        generateHtml += "               <button name=\"btnBudgetDeptCode\" class=\"icon-btn icon-btn--search\" type=\"button\" onclick=\"fn_BudgetDeptDivCreate(this);\">검색</button>";
        generateHtml += "           </div>";
        generateHtml += "           <div class=\"control\">";
        generateHtml += "               <button name=\"btnBudgetDeptCodeDelete\" class=\"icon-btn icon-btn--delete\" type=\"button\" onclick=\"fn_BudgetDeptValueDelete(this);\">삭제</button>";
        generateHtml += "           </div>";
        generateHtml += "       </div>";
        generateHtml += "    </td>";
        generateHtml += "    <td>";
        generateHtml += "       <div class=\"control\">";
        generateHtml += "           <input class=\"input is-align-right\" inputmode=\"numeric\"name=\"slipCurrencyAmt\" value=\"\"/>";
        generateHtml += "       </div>";
        generateHtml += "    </td>";
        generateHtml += "    <td>";
        generateHtml += "       <div class=\"control\">";
        generateHtml += "           <input class=\"input is-align-right\" inputmode=\"numeric\" name=\"localCurrencyAmt\" value=\"\"/>";
        generateHtml += "       </div>";
        generateHtml += "    </td>";
        generateHtml += "    <td>";
        generateHtml += "       <div class=\"control\">";
        generateHtml += "           <input class=\"input\" type=\"text\" name=\"slipText\" />";
        generateHtml += "       </div>";
        generateHtml += "    </td>";
        generateHtml += "</tr>";

        obj.append(generateHtml);
    }

    //체크된 분개장 삭제
    function fn_journalDel(obj)
    {
        var id = obj[0].id;
        $("#"+ id+" input:checkbox[name=journalCheck]:checked").each(function() {
            var tr = $(this).parent().parent().parent().parent();
            tr.remove();
        });

        if( $("#journal tr").length == 0 )
        {
            fn_inputselectControl(false);
            if("${cat.docType}" == "G" || "${cat.docType}" == "H") {
                $('select[name=whCodeNRate] option').attr('disabled', true);
            }
            if("${cat.docType}" == "R") {
                if($("select[name=evdGb]").val() == '01'){
                    $("#taxbillSearch").attr('disabled', false);
                }
            }else {
                $("#taxbillSearch").attr('disabled', false);
                $("#taxbillSearchOtype").attr('disabled', false);
            }
            if("${cat.docType}" == "A" || "${cat.docType}" == "AA"
                || "${cat.docType}" == "I" || "${cat.docType}" == "N" || "${cat.docType}" == "O" || "${cat.docType}" == "R"){
                if($("input[name=compayName]").val() != ""){
                    $("input[name=supplyAmt]").attr('readonly', true);
                    $("input[name=taxAmt]").attr('readonly', true);
                    $("input[name=payAmt]").attr('readonly', true);
                } else {
                    $("input[name=supplyAmt]").attr('readonly', false);
                    $("input[name=taxAmt]").attr('readonly', false);
                    $("input[name=payAmt]").attr('readonly', false);
                }
            }
        }
    }

    function fn_inputselectControl(flag)
    {
        $('#payInform input').prop('readonly', flag);
        $('#payInform option').attr('disabled', flag);
    }

    //분개장 자동생성취소
    function fn_journalCancel(obj)
    {
        fn_inputselectControl(false);
        obj.empty();

        if("${cat.docType}" == "A" || "${cat.docType}" == "AA" || "${cat.docType}" == "R") {
            $("#taxbillSearch").attr('disabled', false);
            if($("select[name=evdGb]").val() == "01") {
                $("input[name=supplyAmt]").attr('readonly', true);
                $("input[name=taxAmt]").attr('readonly', true);
                $("input[name=payAmt]").attr('readonly', true);
            }
            else //증빙구분이 세금계산서가 아니면 세금계산서 버튼 비활성화..
                $("#taxbillSearch").attr('disabled', true);
        }
    }

    //오늘날짜로 환율 조회
    function exchangeRateCur() {
        $("input[name=exchangeRate]").val('');
        var transCurrency = $("select[name=transCurrency]").val();

        if( transCurrency != 'KRW' ){
            let param = {
                currency : transCurrency,
                rateDate : date//'2021-02-01' //개발용 데이터, 원래 데이터 : date
            };

            $.ajax({
                url: "/payDoc/exchangeRate",
                type: 'GET',
                async: false,
                data: param
            }).done(function (result) {
                if(Object.keys(result).length == 0) {
                    alert('환율내역이 없습니다.');
                    $("select[name=transCurrency]").val('KRW').trigger('change');
                } else if(Object.keys(result).length > 0) {
                    if("${cat.docType}" == "F" || "${cat.docType}" == "T") {
                        $("input[name=systemExchangeRate]").val(priceFormat(result.rate));
                        $("input[name=systemExchangeRate]").attr('readonly', false);
                    }else {
                        $("input[name=exchangeRate]").val(priceFormat(result.rate));
                        $("input[name=exchangeRate]").attr('readonly', false);
                    }
                    //외화 선택 시
                    if("${cat.docType}" == "A" || "${cat.docType}" == "AA"
                        || "${cat.docType}" == "I" || "${cat.docType}" == "N" || "${cat.docType}" == "O" || "${cat.docType}" == "R") {
                        otherTransCurrency();
                    }
                }
            }).fail(function(jqXHR) {
                alert('데이터 로드에 실패하였습니다.');
                return;
            });
        } else {
            //외화 선택 시
            if("${cat.docType}" == "A" || "${cat.docType}" == "AA" || "${cat.docType}" == "N" || "${cat.docType}" == "O" || "${cat.docType}" == "R") {
                $("select[name=evdGb]").val("01");
                $("select[name=taxCd]").val("V01");
                /*if("${cat.docType}" == "R") {
                    $("select[name=evdGb]").val("02");
                }*/
            }
            if("${cat.docType}" == "F" || "${cat.docType}" == "T") {
                //시스템 환율 비활성화
                $("input[name=systemExchangeRate]").attr('readonly', true);
                $("input[name=systemExchangeRate]").val('');
            }else {
                //환율 비활성화
                $("input[name=exchangeRate]").attr('readonly', true);
                $("input[name=exchangeRate]").val('');
            }
        }

    }

    //전기일로 환율 조회
    function exchangeRateCurByDate() {
        $("input[name=exchangeRate]").val('');

        var transCurrency = $("select[name=transCurrency]").val();
        var tmpDate = $('#slipPostingDate').val();



        if( transCurrency != 'KRW' ){
            let param = {
                currency : transCurrency,
                rateDate : tmpDate//전기일로 조회
            };

            $.ajax({
                url: "/payDoc/exchangeRate",
                type: 'GET',
                async: false,
                data: param
            }).done(function (result) {
                if(Object.keys(result).length == 0) {
                    alert('환율내역이 없습니다.');
                    $("select[name=transCurrency]").val('KRW').trigger('change');
                } else if(Object.keys(result).length > 0) {
                    if("${cat.docType}" == "F" || "${cat.docType}" == "T") {
                        $("input[name=systemExchangeRate]").val(priceFormat(result.rate));
                        $("input[name=systemExchangeRate]").attr('readonly', false);
                    }else {
                        $("input[name=exchangeRate]").val(priceFormat(result.rate));
                        $("input[name=exchangeRate]").attr('readonly', false);
                    }
                    //외화 선택 시
                    if("${cat.docType}" == "A" || "${cat.docType}" == "AA"
                        || "${cat.docType}" == "I" || "${cat.docType}" == "N" || "${cat.docType}" == "O" || "${cat.docType}" == "R") {
                        otherTransCurrency();
                    }
                }
            }).fail(function(jqXHR) {
                alert('데이터 로드에 실패하였습니다.');
                return;
            });
        } else {
            //외화 선택 시
            if("${cat.docType}" == "A" || "${cat.docType}" == "AA" || "${cat.docType}" == "N" || "${cat.docType}" == "O" || "${cat.docType}" == "R") {
                $("select[name=evdGb]").val("01");
                $("select[name=taxCd]").val("V01");
                /*if("${cat.docType}" == "R") {
                    $("select[name=evdGb]").val("02");
                }*/
            }
            if("${cat.docType}" == "F" || "${cat.docType}" == "T") {
                //시스템 환율 비활성화
                $("input[name=systemExchangeRate]").attr('readonly', true);
                $("input[name=systemExchangeRate]").val('');
            }else {
                //환율 비활성화
                $("input[name=exchangeRate]").attr('readonly', true);
                $("input[name=exchangeRate]").val('');
            }
        }

    }

    //외화 선택 시
    function otherTransCurrency() {
        if("${cat.docType}" == "A" || "${cat.docType}" == "AA" || "${cat.docType}" == "N" || "${cat.docType}" == "O" || "${cat.docType}" == "R") {
            //세금코드 : 매입세 무관
            $("select[name=taxCd]").val("V99");

            //증빙구분 - > 기타증빙으로
            if($("select[name=evdGb]").val() != ""){
                $("select[name=evdGb]").val("02");
            }
        }
        //세금계산서 내역 삭제
        if($("input[name=compayName]").val() != "" || $("input[name=strcustNo]").val() != "" || $("input[name=ebill]").val() != "" || $("input[name=ebillInd]").val() != "" || $("input[name=totalAmt]").val() != "") {
            $("input[name=compayName]").val("");
            $("input[name=strcustNo]").val("");
            $("input[name=ebill]").val("");
            $("input[name=ebillInd]").val("");
            $("input[name=totalAmt]").val("");
        }

        if("${cat.docType}" == "A" || "${cat.docType}" == "AA" || "${cat.docType}" == "N" || "${cat.docType}" == "O" || "${cat.docType}" == "R") {
            //공급가액, 세금금액, 지급금액에 관해
            if($("input[name=supplyAmt]").val() != "") {
                $("input[name=supplyAmt]").val(priceFormat($("input[name=supplyAmt]").val()));
                $("input[name=taxAmt]").val(0);
                $("input[name=payAmt]").val(priceFormat($("input[name=supplyAmt]").val()));
            }
        }
        /*//적요 삭제
        if($("input[name=slipHeader]").val() != ""){
            $("input[name=slipHeader]").val("");
        }*/
        /*//거래처 삭제
        if($("input[name=purchaseCode]").val() != "" || $("input[name=purchaseName]").val() != "") {
            $("input[name=purchaseCode]").val("");
            $("input[name=purchaseName]").val("");
        }*/
    }

    /* 전표통화 금액 입력 시 장부통화금액 자동계산 */
    $(document).on("propertychange change keyup paste input","#journal input[name=slipCurrencyAmt]",function () {
        //환율 1 default
        var exchangeRate = 1;
        // 통화코드가 KRW가 아닐때 환율X금액

        if($('select[name="transCurrency"]').length > 0 && $('input[name="exchangeRate"]').length > 0 && $('select[name="transCurrency"] option:selected').val() != "KRW"){
            exchangeRate = numberOnly($('input[name="exchangeRate"]').val());
            if(exchangeRate == "" || parseInt(exchangeRate) < 1){
                alert("통화코드(KRW)가 원화가 아닐 경우 환율을 입력하시기 바랍니다.");
                exchangeRate = 1;
            }
        }
        var idx =  $("input[name=slipCurrencyAmt]").index($(this));
        if($(this).val() == ""){
            $("input[name=localCurrencyAmt]")[idx].value = 0;
        }else{
            $("input[name=localCurrencyAmt]")[idx].value = priceFormat(parseInt(numberOnly($(this).val())) * parseInt(exchangeRate));
        }

    });

    function fn_evdGbControl() {
        let evdGbValue = $("select[name=evdGb]").val();
        fn_paymethod(evdGbValue);
        if(evdGbValue == "01") {
            $("input[name=supplyAmt]").attr('readonly', true);
            $("input[name=taxAmt]").attr('readonly', true);
            $("input[name=payAmt]").attr('readonly', true);
            //세금계산서 버튼 활성화..
            $("#taxbillSearch").attr('disabled', false);
            //사외-F/B
            $("select[name=paymethod]").val("F");
        }else {
            $("input[name=supplyAmt]").attr('readonly', false);
            $("input[name=taxAmt]").attr('readonly', false);
            $("input[name=payAmt]").attr('readonly', false);

            //세금계산서 버튼 비활성화..
            $("#taxbillSearch").attr('disabled', true);
            //사내-F/B
            $("select[name=paymethod]").val("D");
            //alert( $("select[name=taxCd]").val() ) ;
        }
    }

    function fn_paymethod(evdGbValue)
    {
        let params = {
            menuId : "${menuId}",
            evdGb : evdGbValue
        };

        $.ajax({
            url: "/payDoc/paymentmethod",
            type: 'GET',
            async: false,
            data: params
        }).done(function (result) {
            $("select[name=paymethod]").empty();
            for (let data in result) {
                $("select[name=paymethod]").append('<option value="'+result[data].code+'">'+result[data].description+'</option>');
            }
        }).fail(function (jqXHR) {
            alert('데이터 로드에 실패하였습니다.');
            return;
        });
    }

    $(document).ready(function () {
        //작성중인경우를 제외하고는 전체 disabled처리..
        <c:if test="${ !(empty(appcEntity) || appcEntity.apprvStatus eq '1A') }">
        fn_controldisabled(true);
        </c:if>
    });

    function fn_controldisabled(flag) {
        $("#payInform").find("input, select, textarea").prop("readonly", flag);
        $("#payInform").find("button").prop("disabled", flag);
        $(".tui-datepicker-input").find("input, i").prop("disabled", flag);
        $("#journal").find("input, select, button, textarea").prop("readonly", flag);
        $("#journal").find("button").prop("disabled", flag);
    }

</script>