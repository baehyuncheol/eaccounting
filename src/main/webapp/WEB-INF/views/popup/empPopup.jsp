<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- 사원조회  팝업 -->
<article id="empPopup" class="modal">
    <div class="modal-card is-semi-wide">
        <header class="modal-card-head">
            <p class="modal-card-title">직원 조회</p>
            <button class="modal-close" aria-label="close"></button>
        </header>
        <section class="modal-card-body">
            <h1 class="modal-tree-title">GS</h1>
            <div class="modal-card-inner">
                <!-- tree box -->
                <div id="userTree" class="tui-tree-wrap is-employee"></div>
                <!-- //tree box -->

                <div class="field has-addons">
                    <div class="control is-narrow">
                        <div class="select">
                            <select id="userTreeSelect" required>
                                <option value="1">이름</option>
                                <option value="2">사번</option>
                            </select>
                        </div>
                    </div>
                    <div class="control is-expanded">
                        <input class="input" type="text" id="userTreeSearchBox"/>
                    </div>
                    <div class="control">
                        <button class="icon-btn icon-btn--search" type="button" id="btnUserTreeSearch">검색</button>
                    </div>
                </div>

                <div class="modal-subtitle-wrap">
                    <i class="employee-icon" aria-hidden="true"></i>
                    <h2 class="modal-subtitle" id="orgName"></h2>
                    <span class="modal-subtitle-explain" id="userCount"></span>
                </div>
                <div class="tui-grid-container-wrap">
                    <div id="empGrid"></div>
                </div>
            </div>
        </section>
        <footer class="modal-card-foot is-center">
            <button class="modal-btn is-cancel">닫기</button>
        </footer>
    </div>
</article>
<!-- //사원조회 팝업 -->

    <script type="text/javascript">
        var USER_DEPT_CODE = '${SESSION_USERINFO.deptCode}';
        var USER_EMPL_NO = '${SESSION_USERINFO.emplNo}';
        var callbackFunctionName = 'empCallback';

        function convertUserTreeData(dataList, id, parent) {
            let dataMap = {};
            let treeList = [];

            for (let idx in dataList) {
                let data = dataList[idx];
                let key = data[id];
                dataMap[key] = data;
            }

            for (let key in dataMap) {
                let data = dataMap[key];
                let parentKey = data[parent];

                if (parentKey=='0' || parentKey=='' || !parentKey) {
                    treeList.push(data);
                    continue;
                }
                let parentData = dataMap[parentKey];
                if (!parentData.children) {
                    parentData.children = []
                }
                parentData.children.push(data);
            }

            return treeList;
        }

        function loadUserTreeGrid() {
            let params = {};
            $.ajax({
                url: "/getOrgInfo",
                type: 'GET',
                async: false,
                data: params
            }).done(function (result) {
                let treeConvertData = convertUserTreeData(result, 'deptCode', 'orgCodeUp');
                userTree.resetAllData(treeConvertData);
            }).fail(function(jqXHR) {
                alert('데이터 로드에 실패하였습니다.');
                return;
            });
        }

        function logInUserData() {
            userTree.eachAll(function(node, nodeId) {
                let nodeData = userTree.getNodeData(nodeId);
                if(nodeData.deptCode == USER_DEPT_CODE){
                    userTree.select(nodeId);
                }
            });
        }

        function empGridBind(nodeData) {
            let param = {
                deptCode : nodeData.deptCode
            };
            $.ajax({
                url: "/getOrgUser",
                type: 'GET',
                data: param
            }).done(function (resultData) {
                let userCountData = resultData.length;
                $("#userCount").text("("+userCountData+"명)");
                empGrid.clear();
                empGrid.resetData(resultData);
                empGrid.refreshLayout();
            });
        }

        function setCallback(callbackFuncName){
            callbackFunctionName = callbackFuncName;
        }

        const userTree = new tui.Tree('#userTree', {
            nodeDefaultState: 'opened'
        }).enableFeature('Selectable', {
            selectedClassName: 'tui-tree-selected',
        });

        userTree.on('select', function(eventData) {
            let nodeData = userTree.getNodeData(eventData.nodeId);
            $("#orgName").text(nodeData.deptName);
            empGridBind(nodeData);
        });

        const empGrid = new tui.Grid({
            el: document.getElementById('empGrid'),
            bodyHeight: 450,
            minBodyHeight: 50,
            scrollX: false,
            scrollY: true,
            columns: [
                {
                    header: '부서',
                    name: 'deptName',
                    align: 'center'
                },
                {
                    header: '직위',
                    name: 'titleName',
                    align: 'center'
                },
                {
                    header: '직책',
                    name: 'positionName',
                    align: 'center'
                },
                {
                    header: '이름',
                    name: 'userName',
                    align: 'center'
                }
            ]
        });

        // 사원 더블클릭시 부모창 호출
        empGrid.on('dblclick', function(ev) {
            window[callbackFunctionName](empGrid.getRow(ev.rowKey));
            //empCallback(empGrid.getRow(ev.rowKey));
        });

        $(document).on('click', '#btnUserTreeSearch', function(e) {
            let inputData = $('#userTreeSearchBox').val();
            let selectData = $('#userTreeSelect').val();
            if(inputData == null || inputData == "") {
                alert("검색어를 입력해주세요.");
                return;
            }

            let paramData = {};
            if(selectData == 1) {
                paramData = {
                    userName : inputData
                };
            } else if(selectData == 2) {
                paramData = {
                    emplNo : inputData
                };
            }

            $.ajax({
                url: "/searchOrgUser",
                type: 'GET',
                data: paramData
            }).done(function (resultData) {
                let dataLen = resultData.length;
                $("#orgName").text("");
                $("#userCount").text("("+dataLen+"명)");

                empGrid.clear();
                empGrid.resetData(resultData);
                empGrid.refreshLayout();
            });
        });

        $(document).ready(function(e){
            loadUserTreeGrid();
        });
    </script>
