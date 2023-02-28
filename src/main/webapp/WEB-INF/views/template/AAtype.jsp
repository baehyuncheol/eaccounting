<%--
  Created by IntelliJ IDEA.
  User: IT1371
  Date: 2021-03-18
  Time: 오전 11:00
  menu: 기타일반비용
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section class="contents__body">
<nav class="breadcrumb has-succeeds-separator" aria-label="breadcrumbs">
    <ul>
        <li><a href="/">HOME</a></li>
        <c:if test="${naviMap['naviName1'] ne ''}">
            <li><a href="#"><c:out value="${naviMap['naviName1']}"/></a></li>
        </c:if>
        <c:if test="${naviMap['naviName2'] ne ''}">
            <li><a href="#"><c:out value="${naviMap['naviName2']}"/></a></li>
        </c:if>
        <c:if test="${naviMap['naviName3'] ne ''}">
            <li class="is-active"><a href="#" aria-current="page"><c:out value="${naviMap['naviName3']}"/></a></li>
        </c:if>
    </ul>
</nav>
<h1 class="title"><button class="bookmark-btn<c:if test="${!empty favorit.menuId and favorit.menuId ne ''}"> is-active</c:if>" type="button">즐겨찾기</button>${naviMap['naviName3']}</h1>
<div class="table-wrap">
    <div class="table-header">
        <h2 class="subtitle">지급정보</h2>
    </div>
    <table id="payInform" class="table row-type">
        <colgroup>
            <col>
            <col>
            <col>
            <col>
        </colgroup>
        <tbody>
        <tr>
            <th><i class="essential-icon" aria-label="필수"></i>거래처</th>
            <td>
                <div class="field has-addons">
                    <div class="control is-narrow">
                        <input class="input" type="hidden" name="purchaseCode"/>
                        <input class="input" type="hidden" name="groupCode"/>
                        <input class="input" type="text" name="cardCode" readonly="readonly"  />
                    </div>
                    <div class="control is-expanded">
                        <input class="input" type="text" name="purchaseName" readonly="readonly" />
                    </div>
                    <div class="control">
                        <button class="icon-btn icon-btn--search" type="button" onclick="fn_initBusinessPartners();$('#businesspartners').addClass('is-active');">검색</button>
                    </div>
                    <div class="control">
                        <button class="icon-btn icon-btn--delete" type="button" onclick="fn_delBusinessPartners();">삭제</button>
                    </div>
                </div>
            </td>
            <th>세금계산서</th>
            <td>
                <div class="field has-addons">
                    <div class="control is-expanded">
                        <input class="input" type="text" name="compayName" disabled />
                        <input type="hidden" name="strcustNo">
                        <input type="hidden" name="ebill">
                        <input type="hidden" name="ebillInd">
                        <input type="hidden" name="totalAmt">
                    </div>
                    <div class="control">
                        <button class="icon-btn icon-btn--search" type="button" id="taxbillSearch" onclick="fn_initTaxbill();$('#taxbill').addClass('is-active');fn_Taxbill('init', 1);">검색</button>
                    </div>
                    <div class="control">
                        <button class="icon-btn icon-btn--delete" type="button" id="taxbillDelete">삭제</button>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <th>세금코드</th>
            <td>
                <div class="field">
                    <div class="control">
                        <div class="select">
                            <select name="taxCd" required onchange="javascript:fn_CalTax()">
                                <option value="">없음</option>
                                <c:forEach items="${vatgroupsList}" var="list">
                                    <option value="${list.codePk["code"]}">${list.codeName}</option>

                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
            </td>
            <th></th>
            <td></td>
        </tr>
        <tr>
            <th>통화</th>
            <td>
                <div class="field">
                    <div class="control">
                        <div class="select">
                            <select name="transCurrency" onchange="exchangeRateCurByDate()" required>
                                <c:forEach items="${codeCurrencyList}" var="list">
                                    <option value="${list.codePk["code"]}"<c:if test="${list.codePk['code'] eq 'KRW'}"> selected</c:if> >${list.codeName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
            </td>
            <th>환율</th>
            <td>
                <div class="field">
                    <div class="control is-narrow">
                        <input class="input is-align-right" type="text" name="exchangeRate" inputmode="numeric" readonly/>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <th>공급가액</th>
            <td>
                <div class="field">
                    <div class="control is-narrow">
                        <input class="input is-align-right" type="text" name="supplyAmt" inputmode="numeric" onkeyup="javascript:fn_CalTax()" />
                        <input type="hidden" name="calsupplyAmt" value=""/>
                    </div>
                </div>
            </td>

            <th>세금금액</th>
            <td>
                <div class="field">
                    <div class="control is-narrow">
                        <input class="input is-align-right" type="text" name="taxAmt" inputmode="numeric" onkeyup="javascript:fn_TaxSum()" />
                        <input type="hidden" name="caltaxAmt" value=""/>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <th>지급금액</th>
            <td>
                <div class="field">
                    <div class="control is-narrow">
                        <input class="input is-align-right" type="text" name="payAmt" inputmode="numeric" />
                        <input type="hidden" name="calpayAmt" value=""/>
                    </div>
                </div>
            </td>
            <th>예산부서</th>
            <td>
                <div class="field">
                    <div class="control">
                        <div class="select">
                            <select name="budgetDept" required>
                                <c:forEach items="${budgetList}" var="list">
                                    <option value="${list.code}"<c:if test="${list.code eq orgbudgetmap.budgetCode}"> selected</c:if> >${list.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <th><i class="essential-icon" aria-label="필수"></i>증빙일(계산서일)</th>
            <td>
                <div class="tui-datepicker-input">
                    <input type="text" id="evdDate" name="evdDate" class="input" aria-label="달력">
                    <i class="datepicker-icon" aria-hidden="true"></i>
                </div>
                <div id="dEvdDate" class="datepicker-box"></div>
            </td>
            <th><i class="essential-icon" aria-label="필수"></i>전기일</th>
            <td>
                <div class="tui-datepicker-input">
                    <input type="text" id="slipPostingDate" name="slipPostingDate" class="input" aria-label="달력">
                    <i class="datepicker-icon" aria-hidden="true"></i>
                </div>
                <div id="dSlipPostingDate" class="datepicker-box"></div>
            </td>
        </tr>

        <tr>
            <th>지급일</th>
            <td>
                <div class="tui-datepicker-input">
                    <input type="text" id="expireDate" name="expireDate" class="input" aria-label="달력">
                    <i class="datepicker-icon" aria-hidden="true"></i>
                </div>
                <em class="emphasis">정기지급일 : 매월 15일, 말일</em>
                <div id="dExpireDate" class="datepicker-box"></div>
            </td>
            <th><i class="essential-icon" aria-label="필수"></i>적요</th>
            <td>
                <div class="field">
                    <div class="control">
                        <input class="input" type="text" name="slipHeader" />
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <th><i class="essential-icon" aria-label="필수"></i>지급방법</th>
            <td>
                <div class="field has-addons">
                    <div class="control is-narrow">
                        <div class="select">
                            <select name="paymethod" onchange="fn_controlPayaccount();" required>
                                <c:forEach items="${paymentMethodsList}" var="list">
                                    <option value="${list.code}">${list.description}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="control is-expanded">
                        <div class="control">
                            <input name="payaccount" class="input" type="text" readonly="readonly"  />
                        </div>
                    </div>
                    <!--
                    <div class="control">
                        <button class="small-btn" type="button">예금주조회</button>
                    </div>
                    -->
                </div>
            </td>
            <th><i class="essential-icon" aria-label="필수"></i>전표번호</th>
            <td>
                <div class="field">
                    <div class="control">
                        <input class="input" type="text" name="objAcctNo" disabled/>
                    </div>
                </div>
            </td>
        </tr>
        </tbody>
    </table>
</div>
<div class="table-wrap">
    <div class="table-header">
        <h2 class="subtitle">계정선택</h2>
        <div class="grid-btn-wrap">
            <c:if test="${ empty appcEntity || appcEntity.emplNo eq SESSION_USERINFO.emplNo }">
                <c:if test="${ empty(appcEntity) || appcEntity.apprvStatus eq '1A' }">&nbsp;&nbsp;
                    <button class="grid-btn is-dark" type="button" onclick="fn_journalDel($('#journal'))">삭제</button>
                    <button class="grid-btn is-outline" type="button" onclick="fn_journalAdd($('#journal'))">추가</button>
                </c:if>
            </c:if>
        </div>
    </div>
    <table class="table col-type" id="journalTable">
        <colgroup>
            <col width="40px">
            <col width="100px">
            <col width="200px">
            <col width="300px">
            <col width="150px">
            <col width="150px">
            <col width="*">
        </colgroup>
        <thead>
        <tr>
            <th class="check-cell">
                <div class="control">
                    <label class="checkbox" for="AllChk">
                        <input id="AllChk" type="checkbox">
                    </label>
                </div>
            </th>
            <th>차/대 구분</th>
            <th><em class="essential" aria-label="필수 기재 항목"></em> 계정코드</th>
            <th><em class="essential" aria-label="필수 기재 항목"></em> 코스트센터</th>
            <th><em class="essential" aria-label="필수 기재 항목"></em> 전표통화금액</th>
            <th> 장부통화금액</th>
            <th><em class="essential" aria-label="필수 기재 항목"></em> 적요</th>
        </tr>
        </thead>
        <tbody id="journal">

        </tbody>
    </table>
    <div class="table-footer level">
        <div class="level-left">
            <c:if test="${ !empty(appcEntity) && !empty(appcEntity.ebill)  }">
                <a href="#" id="ebillButton" class="button is-dark">세금계산서</a>
                <script>
                    $(document).on('click', '#ebillButton', function(data){
                        var link = "/paydoc/taxbillpopup?issueId="+$("input[name=ebill]").val();
                        window.open(link,"taxWindow", 'scrollbars=no,width=690,height=500,status=no,resizable=no');
                    });
                </script>
            </c:if>
        </div>

        <div class="level-right">
            <c:if test="${ empty appcEntity || appcEntity.emplNo eq SESSION_USERINFO.emplNo }">
                <c:if test="${ empty(appcEntity) || appcEntity.apprvStatus eq '1A' }">
                    <a href="javascript:fn_tempSave();" class="button is-primary is-light">임시저장</a>
                    <a href="javascript:fn_PaymentRequest();" class="button is-primary">결재준비</a>
                </c:if>
            </c:if>
        </div>
    </div>
</div>
</section>
<script type="text/javascript">
    var datepicker1 = new tui.DatePicker('#dEvdDate', {
        language: 'ko',
        date: new Date(),
        input: {
            element: '#evdDate',
            format: 'yyyy-MM-dd',
        }
    });

    var datepicker2 = new tui.DatePicker('#dSlipPostingDate', {
        language: 'ko',
        date: new Date(),
        input: {
            element: '#slipPostingDate',
            format: 'yyyy-MM-dd',
        }
    });

    var datepicker3 = new tui.DatePicker('#dExpireDate', {
        language: 'ko',
        date: new Date(),
        input: {
            element: '#expireDate',
            format: 'yyyy-MM-dd',
        }
    });

    var exdate = new Date(datepicker1.getDate());
    exdate.setDate(exdate.getDate() + 30);

    datepicker3.setDate(new Date(exdate));

    datepicker1.on('change', function() {
        var expireDate = new Date(datepicker1.getDate());
        expireDate.setDate(expireDate.getDate() + 30);

        datepicker3.setDate(new Date(expireDate));
    });



    /* 기존지출결의서 조회*/
    function fn_appcHdAReq(paydocNo)
    {
        var params = {
            "paydocNo"		: paydocNo
        };

        $.ajax({
            async: false,
            url: '/paydoc/appcHdAAReq',
            type: 'POST',
            async: false,
            data: params,
            beforeSend: function(){
                $('#loading').show();
            },
            complete:function(data){
                $('#loading').hide();
            }
        }).done(function (result) {
            //결과세팅
            setResultValues(result);
        }).fail(function(xhr, textStatus, errorThrown) {
            if(xhr.status =='403'){
                alert("해당 기능에 대한 권한이 없습니다.");
            } else if (xhr.status == '501') {
                alert("session정보가 없습니다. 로그인페이지로 이동합니다.");
                window.location.href = "/loginView";
            } else if (xhr.status == '500') {
                alert("에러["+textStatus+"]" + errorThrown );
            }
        });
    }

</script>
