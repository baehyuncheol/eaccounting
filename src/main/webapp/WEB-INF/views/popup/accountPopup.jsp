<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- 계정 조회 팝업 -->
<article id="accountsPopup" class="modal">
    <div class="modal-card is-semi-wide">
        <header class="modal-card-head">
            <p class="modal-card-title">계정 조회</p>
            <button class="modal-close" aria-label="close"></button>
        </header>
        <section class="modal-card-body">
            <div class="table-wrap">
                <div class="table-header">
                    <h2 class="subtitle">계정 조회</h2>
                    <div class="grid-btn-wrap">
                        <button class="search-btn" type="button" id="btnSearch">조회</button>
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
                                        <select id="select" required>
                                            <option value="1">계정명</option>
                                            <option value="2">계정코드</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="control is-expanded">
                                    <div>
                                        <input class="input" type="text" id="searchBox"/>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <%--<th>거래유형</th>
                        <td>전체</td>--%>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="table-header">
                <%--<div id="totalCount" style="margin-right: 735px;"></div>--%>
                <span class="subtitle-explain" id="totalCount"></span>
                <%--<div class="grid-btn-wrap">
                    <button class="grid-btn is-outline" type="button" >검색</button>
                </div>--%>
            </div>
            <div class="tui-grid-container-wrap">
                <div id="accountsGrid"></div>
            </div>
        </section>
        <footer class="modal-card-foot is-center">
            <button class="modal-btn is-cancel">닫기</button>
            <button class="modal-btn is-primary" id="btnPopupConfirm">확인</button>
        </footer>
    </div>
</article>
<!-- //계정 조회 팝업 -->

    <script type="text/javascript">
        const accountsGrid = new tui.Grid({
            el: document.getElementById('accountsGrid'),
            rowHeaders: [
                {
                    type: 'checkbox',
                    header: "선택",
                    renderer: {
                        type: CheckboxRenderer
                    }
                }
            ],
            bodyHeight: 450,
            scrollX: false,
            scrollY: true,
            columns: [
                {
                    header: '계정코드',
                    name: 'acctCode',
                    align: 'center'
                },
                {
                    header: '계정명',
                    name: 'acctName'
                }
            ]
        });

        accountsGrid.on('check', function(ev) {
            const checkedRowKeys = accountsGrid.getCheckedRowKeys();
            for(let cdx=0; cdx < checkedRowKeys.length; cdx++){
                const rowKey = checkedRowKeys[cdx];
                if(ev.rowKey != rowKey){
                    accountsGrid.uncheck(rowKey);
                }
            }
        });

        function accountsPopupGridBind() {
            let inputData = $('#searchBox').val();
            let selectData = $('#select').val();

            let paramData = {};
            if(selectData == 1) {
                paramData = {
                    acctName : inputData
                };
            }else if(selectData == 2) {
                paramData = {
                    acctCode : inputData
                };
            }
            $.ajax({
                url: "/searchAccountPopup",
                type: 'GET',
                data: paramData
            }).done(function (resultData) {
                let resultDataCount = resultData.length;
                accountsGrid.clear();
                accountsGrid.resetData(resultData);
                $("#totalCount").text("총 "+resultDataCount+"건");
            });
        };

        $(document).on('keydown', 'input', function(key){
            if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
                accountsPopupGridBind();

                key.stopPropagation();
            }
        });

        //팝업 검색 버튼
        $(document).on('click', '#btnSearch', function(e) {
            accountsPopupGridBind();
        });

        $(document).on('click', '#btnPopupConfirm', function(e) {
            const checkedData = accountsGrid.getCheckedRows();
            accountCallback(checkedData);
        });

        $(document).ready(function(e){
            accountsPopupGridBind();
        });
    </script>
