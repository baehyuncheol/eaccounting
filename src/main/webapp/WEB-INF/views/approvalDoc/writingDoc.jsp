<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section class="contents__body">
    <nav class="breadcrumb has-succeeds-separator" aria-label="breadcrumbs">
        <ul>
            <li><a href="/">HOME</a></li>
            <li class="is-active"><a href="#" aria-current="page">작성중 문서</a></li>
        </ul>
    </nav>
    <h1 class="title">작성중 문서</h1>
    <div class="table-wrap">
        <div class="table-header">
            <h2 class="subtitle">작성중 문서</h2>
            <div class="grid-btn-wrap">
                <button class="search-btn" type="button" id="btnApprovalSearch">조회</button>
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
                <th>기안자</th>
                <td>
                    <div class="field has-addons">
                        <div class="control is-narrow">
                            <input class="input" type="text" placeholder="기안자" name="emplNo"/>
                        </div>
                        <div class="control is-expanded">
                            <input class="input" type="text" placeholder="이름" name="userName"/>
                        </div>
                        <div class="control">
                            <button class="icon-btn icon-btn--search" type="button" onclick="fn_SearchEmp()" id="searchBox">검색</button>
                        </div>
                        <div class="control">
                            <button class="icon-btn icon-btn--delete" type="button" onclick="fn_delSearchEmp()" id="delSearchBox">삭제</button>
                        </div>
                    </div>
                </td>
                <th>검색기간</th>
                <td>
                    <div class="field has-addons">
                        <div class="control is-narrow">
                            <div class="select">
                                <select name="searchDate" required>
                                    <option value="paydocCreateDate">기안일</option>
                                </select>
                            </div>
                        </div>
                        <div class="datepicker-range">
                            <div class="tui-datepicker-input">
                                <input id="startpicker-input" type="text" class="input" aria-label="Date">
                                <i class="datepicker-icon" aria-hidden="true"></i>
                                <div id="startpicker-container" class="datepicker-box"></div>
                            </div>
                            <span>~</span>
                            <div class="tui-datepicker-input">
                                <input id="endpicker-input" type="text" class="input" aria-label="Date">
                                <i class="datepicker-icon" aria-hidden="true"></i>
                                <div id="endpicker-container" class="datepicker-box"></div>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <th>양식명</th>
                <td>
                    <div class="field has-addons">
                        <div class="control is-expanded">
                            <div class="select">
                                <select name="depthOne" required>
                                    <option value="">선택</option>
                                    <%--<c:forEach items="${codeDepthOneList}" var="list">
                                        <option value="${list.codePk["code"]}">${list.codeName}</option>
                                    </c:forEach>--%>
                                </select>
                            </div>
                        </div>
                        <div class="control is-expanded">
                            <div class="select">
                                <select name="depthTwo" required>
                                    <option value="">선택</option>
                                </select>
                            </div>
                        </div>
                        <div class="control is-expanded">
                            <div class="select">
                                <select name="depthThree" required>
                                    <option value="">선택</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </td>
                <th>검색어</th>
                <td>
                    <div class="field has-addons">
                        <div class="control is-narrow">
                            <div class="select">
                                <select name="searchName" required>
                                    <%--<option value="">선택</option>--%>
                                    <option value="purchaseName">거래처명</option>
                                    <%--<option value="objAcctNo">전표번호</option>--%>
                                </select>
                            </div>
                        </div>
                        <div class="control is-expanded">
                            <input class="input" type="text" name="txtSearch"/>
                        </div>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
    <div class="table-header">
        <div class="subtitle-wrap">
            <h2 class="subtitle">조회결과
                <span class="subtitle-explain"><div id="searchApprovalCount"></div></span>
            </h2>
        </div>
        <div class="grid-btn-wrap">
            <button class="grid-btn is-dark" type="button" id="btnDelete">삭제</button>
        </div>
    </div>
    <div class="tui-grid-container-wrap">
        <div id="approvalListGrid"></div>
    </div>
    <div id="paginationApprovalDoc" class="tui-pagination"></div>
</section>

<script>
    $("#searchApprovalCount").text("");

    var today = new Date();

    var prevdate = new Date(today.getFullYear(), today.getMonth()-1, "01");
    var picker = tui.DatePicker.createRangePicker({
        startpicker: {
            date: prevdate,
            input: '#startpicker-input',
            container: '#startpicker-container'
        },
        endpicker: {
            date: today,
            input: '#endpicker-input',
            container: '#endpicker-container'
        },
    });

    const perPageNum = 10;
    let approvalListParams = {
        page: 1
        ,perPage: perPageNum
        ,sortColumn: ''
        ,sortAscending: ''
        ,apprvStatus : '1A' //작성중인 문서
        ,apprvStatus2 : 'IH' //반려 문서
        ,emplNo : $("input[name=emplNo]").val()
        ,searchDate	: $("select[name=searchDate]").val()
        ,startDate : $("#startpicker-input").val()
        ,endDate : $("#endpicker-input").val()
        ,searchName		: $("select[name=searchName]").val()
        ,purchaseName : $("input[name=txtSearch]").val()
        ,apprvTitle : $("input[name=txtSearch]").val()
        ,objAcctNo : $("input[name=txtSearch]").val()
        ,depthOne : $("select[name=depthOne]").val()
        ,depthTwo	: $("select[name=depthTwo]").val()
        ,depthThree	: $("select[name=depthThree]").val()
    };

    function setApprovalListParams(page, perPageNum, sortColumn, sortAscending, apprvStatus,
                                   apprvStatus2, emplNo, searchDate, startDate, endDate,
                                   searchName, purchaseName, apprvTitle, objAcctNo, depthOne, depthTwo, depthThree){
        approvalListParams.page = page;
        approvalListParams.perPage = perPageNum;
        approvalListParams.sortColumn = sortColumn;
        approvalListParams.sortAscending = sortAscending;
        approvalListParams.apprvStatus = apprvStatus;
        approvalListParams.apprvStatus2 = apprvStatus2;
        approvalListParams.emplNo = emplNo;
        approvalListParams.searchDate = searchDate;
        approvalListParams.startDate = startDate;
        approvalListParams.endDate = endDate;
        approvalListParams.searchName = searchName;
        approvalListParams.purchaseName = purchaseName;
        approvalListParams.apprvTitle = apprvTitle;
        approvalListParams.objAcctNo = objAcctNo;
        approvalListParams.depthOne = depthOne;
        approvalListParams.depthTwo = depthTwo;
        approvalListParams.depthThree = depthThree;
    }

    if("${SESSION_USERINFO.authorId}" == 1 || "${SESSION_USERINFO.authorId}" == 2){
        $("#searchBox").show();
        $("#delSearchBox").show();
        $("input[name=emplNo]").val("${SESSION_USERINFO.emplNo}");
        $("input[name=userName]").val("${SESSION_USERINFO.userName}");
        $("input[name=emplNo]").attr('readonly', true);
        $("input[name=userName]").attr('readonly', true);
    }else {
        $("#searchBox").hide();
        $("#delSearchBox").hide();
        $("input[name=emplNo]").val("${SESSION_USERINFO.emplNo}");
        $("input[name=userName]").val("${SESSION_USERINFO.userName}");
        $("input[name=emplNo]").attr('readonly', true);
        $("input[name=userName]").attr('readonly', true);
    }
/*
    const approvalListGrid = new tui.Grid({
        el: document.getElementById('approvalListGrid'), // 그리드 id
        scrollX: false,
        scrollY: false,
        rowHeaders: [
            {
                type: 'checkbox',
                header: "삭제",
                /*renderer: {
                    type: CheckboxRenderer
                }
            }
        ],
        columns: [
            {
                header: '문서번호',
                name: 'paydocNo',
                align: 'center'
            },
            {
                header: '대분류',
                name: 'codeNameOne',
                align: 'center'
            },
            {
                header: '중분류',
                name: 'codeNameTwo',
                align: 'center'
            },
            {
                header: '소분류',
                name: 'codeNameThree',
                align: 'center'
            },
            {
                header: '거래처',
                name: 'purchaseName',
                align: 'center'
            },
            {
                header: '전표번호',
                name: 'objAcctNo',
                align: 'center'
            },
            {
                header: '기안자',
                name: 'userName',
                align: 'center'
            },
            {
                header: '기안일',
                name: 'apprvReqTime',
                align: 'center',
                sortable: true,
                editor: {
                    type: 'datePicker'
                }
            },
            {
                header: '상태',
                name: 'apprvStatus',
                align: 'center',
                disabled : true,
                formatter: 'listItemText',
                editor: {
                    type: 'select',
                    options: {
                        listItems: [
                            { text: '작성중', value: '1A' },
                            { text: '결재진행중', value: 'IE' },
                            { text: '결재완료', value: 'IG' },
                            { text: '반려', value: 'IH' }
                        ]
                    }
                }
            },
            {
                header: '결재완료일',
                name: 'apprvCompleteTime',
                align: 'center',
                sortable: true,
                editor: {
                    type: 'datePicker'
                }
            }
        ]
    });
*/
    $('#approvalListGrid').on("click", function(ev) {
        const rowKeyData = approvalListGrid.getFocusedCell().rowKey;
        const getRowData = approvalListGrid.getRow(rowKeyData);
        if(getRowData == null) { //체크박스 행만 클릭 시 나타나는 null 오류 처리
            return;
        }
        if(getRowData.menuUrl){
            window.location.href = updateQueryStringParameter(getRowData.menuUrl, 'paydocNo', getRowData.paydocNo);
        } else {
            window.location.href = "/paydoc?paydocNo=" + getRowData.paydocNo;
        }
    });

    $('#approvalListGrid').on('mouseover',function(){
        $('#approvalListGrid').css("cursor", "pointer");
    });

    approvalListGrid.on("editingStart", function(ev){
        if(ev.columnName == "apprvReqTime" || ev.columnName == "apprvCompleteTime") {
            ev.stop();
        }
    });

    approvalListGrid.on('beforeSort', function(ev) {
        setApprovalListParams(approvalListParams.page, approvalListParams.perPage, ev.columnName, ev.ascending,
            approvalListParams.apprvStatus, approvalListParams.apprvStatus2, approvalListParams.emplNo,
            approvalListParams.searchDate, approvalListParams.startDate, approvalListParams.endDate,
            approvalListParams.searchName, approvalListParams.purchaseName, approvalListParams.apprvTitle,
            approvalListParams.objAcctNo, approvalListParams.depthOne, approvalListParams.depthTwo, approvalListParams.depthThree);

        let sortState = {
            sortState : {
                columnName: ev.columnName,
                ascending: ev.ascending,
                multiple: ev.multiple,
            }
        };

        fn_ApprovalDoc('sort', sortState);

        ev.stop();
    });

    // Pagination
    var paginationApprovalDoc = new tui.Pagination('paginationApprovalDoc', {
        itemsPerPage: perPageNum
    });

    paginationApprovalDoc.on('beforeMove', function(ev) {
        setApprovalListParams(ev.page, approvalListParams.perPage, approvalListParams.sortColumn, approvalListParams.sortAscending,
            approvalListParams.apprvStatus, approvalListParams.apprvStatus2, approvalListParams.emplNo,
            approvalListParams.searchDate, approvalListParams.startDate, approvalListParams.endDate,
            approvalListParams.searchName, approvalListParams.purchaseName, approvalListParams.apprvTitle,
            approvalListParams.objAcctNo, approvalListParams.depthOne, approvalListParams.depthTwo, approvalListParams.depthThree);
        fn_ApprovalDoc("move");
    });

    function fn_dropDown_depth1()
    {
        $.ajax({
            url: "/approvalDoc/depth1",
            type: 'GET',
            async: false
        }).done(function (result) {
            for(let data in result){
                $("select[name=depthOne]").append('<option value="'+result[data].code+'">'+result[data].codeName+'</option>');
            }
        }).fail(function(jqXHR) {
            alert('데이터 로드에 실패하였습니다.');
            return;
        });
    }

    function fn_ApprovalDoc(type, sortState)
    {
        $.ajax({
            url: '/approvalDoc/list',
            type: 'GET',
            data: approvalListParams,
        }).done(function (result) {
            approvalListGrid.clear();
            for(var data in result.data.contents) {
                if(result.data.contents[data].apprvReqTime != null) {
                    //작성중 상태에서 결재요청시간이 없는 경우만 삭제가능하도록 설계했으나...
                    //(주)GS 요청으로 결재요청 상관없이 다 삭제 가능하도록 수정...
                    //result.data.contents[data]._attributes = {checkDisabled: true};
                }

                //to 심연식과장님 반려인 경우는 삭제하지 않습니다.~~ㅋㅋ
                if( result.data.contents[data].apprvStatus == 'IH'){
                    result.data.contents[data]._attributes = {checkDisabled: true};
                }
            }
            approvalListGrid.resetData(result.data.contents, sortState);
            if(type == "init") {
                paginationApprovalDoc.reset(result.data.pagination.totalCount);
            }else {
                paginationApprovalDoc.setTotalItems(result.data.pagination.totalCount);
            }
            $("#searchApprovalCount").text("(총 "+result.data.pagination.totalCount+"건)");
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

    function fn_initApprovalSearch()
    {
        $("#searchApprovalCount").text("");
        $("#trApprovalDoc").empty();
    }

    function fn_SearchEmp()
    {
        $('#userTreeSelect').val("1");
        $('#userTreeSearchBox').val("");
        $('#empPopup').addClass('is-active');
        logInUserData();
    }

    function fn_delSearchEmp()
    {
        $("input[name=emplNo]").val("");
        $("input[name=userName]").val("");
    }

    // 사원팝업에서 호출
    function empCallback(selEmp){
        $("input[name=emplNo]").val(selEmp.emplNo);
        $("input[name=userName]").val(selEmp.userName);

        $('#empPopup').removeClass('is-active');
    }

    $(document).on('keydown', 'input', function(key){
        if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
            setApprovalListParams(1, perPageNum, '', '', '1A', 'IH', $("input[name=emplNo]").val(),
                $("select[name=searchDate]").val(), $("#startpicker-input").val(), $("#endpicker-input").val(),
                $("select[name=searchName]").val(), $("input[name=txtSearch]").val(), $("input[name=txtSearch]").val(),
                $("input[name=txtSearch]").val(), $("select[name=depthOne]").val(), $("select[name=depthTwo]").val(), $("select[name=depthThree]").val());
            fn_ApprovalDoc("init");

            key.stopPropagation();
        }
    });

    $(document).on('click', '#btnApprovalSearch', function(){
        fn_SearchList();
    });

    $("select[name=depthOne]").on('change', function() {
        $("select[name=depthTwo]").empty().append('<option value="">선택</option>') ;
        $("select[name=depthThree]").empty().append('<option value="">선택</option>') ;
        let depthOneData = $(this).val();

        if(depthOneData == "" || depthOneData == null){
            return;
        }else{
            var param = {
                code: depthOneData
            };

            $.ajax({
                url: "/approvalDoc/depth2",
                type: 'GET',
                async: false,
                data: param
            }).done(function (result) {
                for(let data in result){
                    $("select[name=depthTwo]").append('<option value="'+result[data].code+'">'+result[data].codeName+'</option>');
                }
            }).fail(function(jqXHR) {
                alert('데이터 로드에 실패하였습니다.');
                return;
            });
        }
    });

    $("select[name=depthTwo]").on('change', function() {
        $("select[name=depthThree]").empty().append('<option value="">선택</option>') ;
        let depthTwoData = $(this).val();

        if(depthTwoData == "" || depthTwoData == null){
            return;
        }else{
            var param = {
                code: depthTwoData
            };

            $.ajax({
                url: "/approvalDoc/depth3",
                type: 'GET',
                async: false,
                data: param
            }).done(function (result) {
                for(let data in result){
                    $("select[name=depthThree]").append('<option value="'+result[data].code+'">'+result[data].codeName+'</option>');
                }
            }).fail(function(jqXHR) {
                alert('데이터 로드에 실패하였습니다.');
                return;
            });
        }
    });

    //기안일 비어있는 데이터만 삭제
    $(document).on('click', '#btnDelete', function(e) {
        const chkRows = approvalListGrid.getCheckedRows();
        if(chkRows.length == 0) {
            alert('행을 선택해주세요.');
            return;
        }
        let paydocNoList = new Array();
        for(let data in chkRows){
            //if(chkRows[data].apprvReqTime != null) {
            //    alert("기안일이 없는 데이터만 삭제 가능합니다.");
            //    return;
            //}else {
            paydocNoList.push({ paydocNo : chkRows[data].paydocNo,
                docType : chkRows[data].docType });
            //}
        }

        if(confirm("삭제하시겠습니까?")) {
            $.ajax({
                url: '/approvalDoc/updateStatus',
                type: 'POST',
                contentType: "application/json",
                data: JSON.stringify(paydocNoList)
            }).done(function (result) {
                //approvalListGrid.removeCheckedRows(false);
                setApprovalListParams(1, perPageNum, '', '', '1A', 'IH', $("input[name=emplNo]").val(),
                    $("select[name=searchDate]").val(), $("#startpicker-input").val(), $("#endpicker-input").val(),
                    $("select[name=searchName]").val(), $("input[name=txtSearch]").val(), $("input[name=txtSearch]").val(),
                    $("input[name=txtSearch]").val(), $("select[name=depthOne]").val(), $("select[name=depthTwo]").val(), $("select[name=depthThree]").val());
                fn_ApprovalDoc("init");

                alert("삭제되었습니다.");

            }).fail(function (xhr, textStatus, errorThrown) {
                if (xhr.status == '403') {
                    alert("해당 기능에 대한 권한이 없습니다.");
                } else if (xhr.status == '501') {
                    alert("session정보가 없습니다. 로그인페이지로 이동합니다.");
                    window.location.href = "/loginView";
                }else if (xhr.status == '500') {
                    alert("에러["+textStatus+"]" + errorThrown );
                }
            });
        }

    });

    //리스트 조회 버튼이벤트
    function fn_SearchList()
    {
        setApprovalListParams(1, perPageNum, '', '', '1A', 'IH', $("input[name=emplNo]").val(),
            $("select[name=searchDate]").val(), $("#startpicker-input").val(), $("#endpicker-input").val(),
            $("select[name=searchName]").val(), $("input[name=txtSearch]").val(), $("input[name=txtSearch]").val(),
            $("input[name=txtSearch]").val(), $("select[name=depthOne]").val(), $("select[name=depthTwo]").val(), $("select[name=depthThree]").val());
        fn_ApprovalDoc("init");
    }

    $(document).ready(function() {
        fn_dropDown_depth1();

        //페이지 로딩시 조회버튼 이벤트..
        fn_SearchList();
    });
</script>

<jsp:include page="/WEB-INF/views/popup/empPopup.jsp"/>