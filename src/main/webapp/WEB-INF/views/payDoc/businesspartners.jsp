<%--
  Created by IntelliJ IDEA.
  User: IT1806005
  Date: 2020-12-02
  Time: 오전 9:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 거래처 검색 팝업 is-active 클래스로 노출-->
<article id="businesspartners" class="modal">
    <div class="modal-card is-wide">
        <header class="modal-card-head">
            <p class="modal-card-title">거래처 조회</p>
            <button class="modal-close" aria-label="close"></button>
        </header>
        <section class="modal-card-body">
            <div class="table-wrap">
                <div class="table-header is-not-named">
                    <div class="grid-btn-wrap">
                        <button id="btnBusinessPartners" class="search-btn" type="button">조회</button>
                    </div>
                </div>
                <table class="table row-type">
                    <colgroup>
                        <col>
                        <col>
                        <col>
                        <col>
                    </colgroup>
                    <tbody>
                    <tr>
                        <th>구분</th>
                        <td colspan="3">
                            <div class="field has-addons">
                                <div class="control is-narrow">
                                    <div class="select">
                                        <select name="vendorSearch" required>
                                            <option value="cardName">거래처명</option>
                                            <option value="cardCode">거래처코드</option>
                                            <option value="vatRegNum">사업자번호</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="control is-narrow">
                                    <input class="input" type="text" name="txtSearch" />
                                </div>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <div class="table-wrap">
                <div class="table-header">
                    <h2 class="subtitle">조회결과 <span class="subtitle-explain"><div id="searchCount"></div></span></h2>
                </div>
                <table class="table col-type">
                    <colgroup>
                        <col width="40px">
                        <col width="110px">
                        <col width="130px">
                        <col width="150px">
                        <col width="*">
                        <col width="180px">
                        <col style="display:none">
                        <col style="display:none">
                        <col style="display:none">
                        <col style="display:none">
                        <col style="display:none">
                    </colgroup>
                    <thead>
                    <tr>
                        <th>선택</th>
                        <th>계정그룹</th>
                        <th>거래처코드</th>
                        <th>거래처명</th>
                        <th>주소</th>
                        <th>사업자번호</th>
                        <th style="display:none">대표자</th>
                        <th style="display:none">업태</th>
                        <th style="display:none">종목</th>
                        <th style="display:none">계좌번호</th>
                        <th style="display:none">은행명</th>
                    </tr>
                    </thead>
                    <tbody id="trBusiness">
                    </tbody>
                </table>
                <input type="hidden" name="businesspartnersIndex" value="0">
                <div id="paginationBusinessPartners" class="tui-pagination"></div>
            </div>
        </section>
        <footer class="modal-card-foot is-center">
            <button class="modal-btn is-cancel">닫기</button>
            <button class="modal-btn is-primary" onclick="fn_BusinessSelected()">확인</button>
        </footer>
    </div>
</article>
<!-- //거래처 검색 팝업 -->

<script>
    $("#searchCount").text("");
    const perPageNum = 10;

    // Pagination
    var pagination = new tui.Pagination('paginationBusinessPartners', {
        itemsPerPage: perPageNum,
        visiblePages: perPageNum,
        centerAlign: false
    });

    pagination.on('beforeMove', function(ev) {
        fn_BusinessPartners('move', ev.page-1);
    });

    $(document).on('click', '#btnBusinessPartners', function(){
        fn_BusinessPartners("init", 0);
    });

    $(document).on('keydown', 'input', function(key){
        if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
            fn_BusinessPartners("init", 0);

            key.stopPropagation();
        }
    });

    function fn_BusinessPartners(type, page)
    {
        if( page == '')
            page = 0;

        var params = {
            "vendorSearch"		: $("select[name=vendorSearch]").val()
            ,"txtSearch"		: $("select[name=vendorSearch]").val()=="vatRegNum"?regNumFormat($("input[name=txtSearch]").val()):$("input[name=txtSearch]").val()
            ,"page"             : page
        };

        if($("select[name=purchaseGroup]").length > 0) {
            var groupCode = $("select[name=purchaseGroup]").val();
            $.extend(params, {"groupCode" : groupCode});
        }

        $.ajax({
            url: '/paydoc/businesspartners',
            type: 'POST',
            data: params,
            beforeSend: function(){
                $("#btnBusinessPartners").attr('disabled', true);
            },
            complete:function(data){
                $("#btnBusinessPartners").attr('disabled', false);
            }
        }).done(function (result) {
            generateTable(result.content, $("#trBusiness"));
            //alert( result.totalElements);
            if(type == 'init'){
                pagination.reset(result.totalElements);
            } else {
                pagination.setTotalItems(result.totalElements);
            }
            $("#searchCount").text("(총 "+result.totalElements+"건)");
            //검색결과 한건일때 자동 선택되게..
            if(result.totalElements == 1){
                $('label.radio[for=Chk0]').addClass("is-active");
                $('#Chk0:radio[name="result"]').attr("checked","checked");
            }
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

    function generateTable(data, obj)
    {
        var generateHtml = "";
        obj.empty();
        $.each(data, function (i, el) {
            generateHtml += "<tr>";
            generateHtml += "<td>";
            generateHtml += "<div class=\"control\">";
            generateHtml += "<label class=\"radio\" for=\"Chk"+i+"\">";
            generateHtml += "<input id=\"Chk"+i+"\" type=\"radio\" name=\"result\">";
            generateHtml += "</label>";
            generateHtml += "</div>";
            generateHtml += "</td>";
            generateHtml += "<td>"+el.groupName+"</td>";
            generateHtml += "<td>"+el.cardCode+"</td>";
            generateHtml += "<td>"+el.cardName+"</td>";
            generateHtml += "<td>"+el.address+"</td>";
            generateHtml += "<td>"+el.vatRegNum+"</td>";
            generateHtml += "<td style=\"display:none\">"+el.repName+"</td>";
            generateHtml += "<td style=\"display:none\">"+el.business+"</td>";
            generateHtml += "<td style=\"display:none\">"+el.industry+"</td>";
            generateHtml += "<td style=\"display:none\">"+el.account+"</td>";
            generateHtml += "<td style=\"display:none\">"+el.bankName+"</td>";
            generateHtml += "<td style=\"display:none\">"+el.groupCode+"</td>";
            generateHtml += "<td style=\"display:none\">"+el.juminNumber+"</td>";
            generateHtml += "<td style=\"display:none\">"+el.bankCode+"</td>";
            generateHtml += "<td style=\"display:none\">"+el.dflBranch+"</td>";
            generateHtml += "</tr>";
        });
        obj.html(generateHtml);
    }

    //라디오버튼 선택 후 확인 버튼 눌렀을때..
    function fn_BusinessSelected() {
        if( $(':radio[name="result"]:checked').length < 1)
        {
            alert( "거래처를 선택해주세요!" );
            return ;
        }
        $(':radio[name="result"]:checked').each(function(i){
            var tr = $(this).parent().parent().parent().parent();
            var td = tr.children();

            if( "${cat.docType}" == "Q" || "${cat.docType}" == "R" ){
                var idx = $("input[name=businesspartnersIndex]").val();

                $("input[name=cardCode]").eq(idx).val(td.eq(2).text());
                $("input[name=purchaseCode]").eq(idx).val(td.eq(5).text().replace(/-/g,''));
                $("input[name=purchaseName]").eq(idx).val(td.eq(3).text());
            }else {

                $("input[name=spurchaseName]").val(td.eq(3).text());
                $("input[name=spurchaseCode]").val(td.eq(5).text().replace(/-/g,''));
                $("input[name=scardCode]").val(td.eq(2).text());
                //공급업체 조회가 아닌경우
                if( $("input[name=sflag]").val() != "S" ){
                    $("input[name=cardCode]").val(td.eq(2).text());

                    if( "${cat.docType}" == "V" ) {
                        if(td.eq(11).text() == '106') {
                            $("input[name=purchaseCode]").val(td.eq(2).text());
                        }else if(td.eq(11).text() == '107' && td.eq(12).text() != ''){
                            $("input[name=purchaseCode]").val(td.eq(2).text());
                            $("input[name=juminNo]").val(td.eq(12).text());
                        }else {
                            $("input[name=purchaseCode]").val(td.eq(5).text().replace(/-/g,''));
                        }
                    }else {
                        $("input[name=purchaseCode]").val(td.eq(5).text().replace(/-/g,''));
                    }

                    $("input[name=purchaseName]").val(td.eq(3).text());
                    $("input[name=groupCode]").val(td.eq(11).text());
                    $("input[name=bizNo]").val(td.eq(5).text());         //사업자번호
                    $("input[name=presidentName]").val(td.eq(6).text()); //대표자명
                    $("input[name=bizStatus]").val(td.eq(7).text());     //업태
                    $("input[name=item]").val(td.eq(8).text());          //종목
                    $("input[name=payaccount]").val(td.eq(10).text() + "-" + td.eq(9).text()); //은행명-계좌번호
                    $("select[name=bankKey]").val(td.eq(13).text()); //은행코드
                    $("input[name=accntNoBank]").val(td.eq(9).text()); //계좌번호
                    $("input[name=bankEmplName]").val(td.eq(14).text()); //계좌소유자
                }

            }
            //팝업 닫기..
            $("#businesspartners").removeClass("is-active");

            if( "${cat.docType}" == "A" || "${cat.docType}" == "AA" ) {
                if($("select[name=evdGb]").val() == "02" && $("input[name=groupCode]").val() == "108" && $("select[name=paymethod]").val() == "D") {
                    $("input[name=payaccount]").hide();
                }else {
                    if( $("select[name=paymethod]").val() == '1') {
                        $("input[name=payaccount]").hide();
                    }else {
                        $("input[name=payaccount]").show();
                    }
                }
            }
            if( "${cat.docType}" == "P" ) {
                if($("select[name=evdGb]").val() == "03" && $("input[name=groupCode]").val() == "108" && $("select[name=paymethod]").val() == "D") {
                    $("input[name=payaccount]").hide();
                }else {
                    $("input[name=payaccount]").show();
                }

            }

            //거래처 팝업 초기화
            if( "${cat.docType}" == "Q" ) {
                fn_initBusinessPartnersLine();
            }else {
                fn_initBusinessPartners();
            }

            $('input:radio[name="applySp"][value="U"]').attr('checked', 'checked');
            $('label.radio[name="lb_applySp"][for=Chk2]').addClass("is-active");
            $('input:radio[name="applySp"][value="I"]').removeAttr('checked');
            $('label.radio[name="lb_applySp"][for=Chk1]').removeClass("is-active");
            //거래처등록시 이미 등록된 거래처의 경우 신청구분을 수정으로 바꿔준다.
            if( "${cat.docType}" == "V" ) {
                $("input[name=gubunCode]").val("U");
            }

            if( "${cat.docType}" == "B" || "${cat.docType}" == "D"
                || "${cat.docType}" == "C" || "${cat.docType}" == "E"){
                var params = {
                    "purchaseCode"	: $("input[name=purchaseCode]").val()
                    ,"docType"		: "${cat.docType}"
                };                //임차보증금이나 임대보증금인 경우 디비 호출해야함..
                $.ajax({
                    url: '/paydoc/rentalvendorcountcheck',
                    type: 'POST',
                    data: params
                }).done(function (result) {
                    //신규로 거래처명을 가져왔을때 이미 rental 테이블에 값이 있는경우
                    //기존거래처명 + _1 _2로 추가 되어져야함...
                    $("input[name=rentalId]").val(td.eq(5).text().replace(/-/g,''));
                    if( result.totalCount > 0){
                        alert( "동일한 사업자번호로 된 임대보증금 거래처가 "+result.totalCount+ " 건 존재합니다." );
                        $("input[name=vdName]").val(td.eq(3).text() + "_" +result.totalCount);
                    }
                    else {
                        $("input[name=vdName]").val(td.eq(3).text() );
                    }
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

        });
    }

    function fn_initBusinessPartners()
    {
        $("#searchCount").text("");

        if($("input[name=purchaseCode]").length > 0 && $("input[name=purchaseCode]").val().length > 0){
            $("select[name=vendorSearch]").val("cardCode");
            $("input[name=txtSearch]").val($("input[name=purchaseCode]").val());
        }else if($("input[name=bizNo]").length > 0 && $("input[name=bizNo]").val().length > 0){
            $("select[name=vendorSearch]").val("vatRegNum");
            $("input[name=txtSearch]").val($("input[name=bizNo]").val());
        }else if($("input[name=cardNo]").length > 0 && $("input[name=cardNo]").val().length > 0){
            $("select[name=vendorSearch]").val("cardCode");
            $("input[name=txtSearch]").val($("input[name=bizNo]").val());
        }else if($("input[name=purchaseName]").length > 0 && $("input[name=purchaseName]").val().length > 0){
            $("select[name=vendorSearch]").val("cardName");
            $("input[name=txtSearch]").val($("input[name=purchaseName]").val());
        }else{
            $("select[name=vendorSearch]").val("cardName");
            $("input[name=txtSearch]").val("");
        }
        $("#trBusiness").empty();
        pagination.reset(0);

        fn_BusinessPartners("init", 0);
        //조회조건이 입력됐을 경우, 즉시 조회
        if($("input[name=txtSearch]").val().length > 0){
            fn_BusinessPartners("init", 0);
        }

    }

    function fn_delBusinessPartners(obj)
    {
        if( obj == 'S') {
            $("input[name=spurchaseCode]").val("");
            $("input[name=spurchaseName]").val("");
            $("input[name=scardCode]").val("");
        } else {
            $("input[name=purchaseCode]").val("");
            $("input[name=purchaseName]").val("");
            $("input[name=cardCode]").val("");
            $("input[name=bizNo]").val("");
            $("input[name=presidentName]").val(""); //대표자명
            $("input[name=bizStatus]").val("");     //업태
            $("input[name=item]").val("");         //종목
            if( "${cat.docType}" == "B" || "${cat.docType}" == "D"
                || "${cat.docType}" == "C" || "${cat.docType}" == "E"){
                $("input[name=vdName]").val("");
                $("input[name=rentalId]").val("");
            }
        }
    }

    //분개장 용
    function fn_initBusinessPartnersLine()
    {
        $("#searchCount").text("");
        $("#trBusiness").empty();
        $("select[name=vendorSearch]").val("cardName");
        $("input[name=txtSearch]").val("");
        $("input[name=businesspartnersIndex]").val(0);

        pagination.reset(0);
    }

    //분개장 용
    function fn_BusinessPartnersDivCreate(obj)
    {
        fn_inputselectControl(false);
        var idx = $("button[name=btnPurchaseCode]").index(obj);  // 존재하는 모든 버튼을 기준으로 index

        fn_initBusinessPartnersLine();
        $("input[name=businesspartnersIndex]").val(idx);
        fn_BusinessPartners("init", 0);
        $('#businesspartners').addClass('is-active');
    }

    //분개장 용
    function fn_BusinessPartnersValueDelete(obj)
    {
        var idx = $("button[name=btnPurchaseCodeDelete]").index(obj);  // 존재하는 모든 버튼을 기준으로 index

        $("input[name=businesspartnersIndex]").val(idx);
        $("input[name=purchaseCode]").eq(idx).val("");
        $("input[name=purchaseName]").eq(idx).val("");
    }

    /* 거래처명 엔터접근시*/
    function fn_businesspartnersKeyDown(obj)
    {
        if(event.keyCode == 13){
            var idx = $("input[name=purchaseName]").index(obj);  // 존재하는 모든 버튼을 기준으로 index

            $("select[name=vendorSearch]").val("cardName");
            $("input[name=txtSearch]").val(obj.value);
            $("input[name=businesspartnersIndex]").val(idx);
            $('#businesspartners').addClass('is-active');

            fn_BusinessPartners('init', 0);
            return;
        }else if( event.keyCode === 8 ) {
            //백스페이스일시
            var idx = $("input[name=purchaseName]").index(obj);
            $("input[name=purchaseName]")[idx].value = '';
            $("input[name=purchaseCode]")[idx].value = '';
        }
    }

</script>