<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="g" tagdir="/WEB-INF/tags" %>--%>

<section class="contents__body">
    <nav class="breadcrumb has-succeeds-separator" aria-label="breadcrumbs">
        <ul>
            <li><a href="/">HOME</a></li>
            <li><a href="#">환경설정</a></li>
            <li class="is-active"><a href="#" aria-current="page">메뉴 관리</a></li>
        </ul>
    </nav>
    <h1 class="title">메뉴 관리</h1>

    <div class="table-header">
        <h2 class="subtitle">메뉴</h2>
    </div>
    <div class="table-inner">
        <!-- tree box -->
        <div id="tree" class="tui-tree-wrap is-menu"></div>
        <!-- //tree box -->

        <div class="table-contents">
            <div class="table-wrap">
                <table class="table">
                    <colgroup>
                        <col>
                        <col>
                        <col>
                        <col>
                    </colgroup>
                    <tbody>
                    <tr>
                        <th>메뉴</th>
                        <td colspan="3" id="menuName">
                        </td>
                        <th colspan="3" id="">
                            <button class="grid-btn is-outline" id="btnMenuAuth">메뉴별 권한등록</button>
                        </th>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="table-wrap">
                <div class="table-header is-not-named">
                    <div class="grid-btn-wrap">
                        <button class="grid-btn is-dark" type="button" id="btnDeleteRow">삭제</button>
                        <button class="grid-btn is-outline" type="button" id="btnNewRow">추가</button>
                        <!-- <div class="arrow-btn-wrap">
                          <button class="arrow-btn is-up" type="button">위로 보내기</button>
                          <button class="arrow-btn is-down" type="button">아래로 보내기</button>
                        </div> -->
                    </div>
                </div>
                <div class="tui-grid-container-wrap">
                    <div id="menuGrid" style="width: 1000px"></div>
                </div>
                <div class="table-footer is-right">
                    <div class="level-right">
                        <button class="button is-primary" id="btnSave">저장</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- 메뉴별 권한등록 팝업 -->
<article id="menuAuthPopup" class="modal">
    <div class="modal-card is-wide">
        <header class="modal-card-head">
            <p class="modal-card-title">메뉴별 권한등록</p>
            <button class="modal-close" aria-label="close"></button>
        </header>
        <section class="modal-card-body">
            <div class="table-wrap">
                <table class="table">
                    <colgroup>
                        <col>
                        <col>
                        <col>
                        <col>
                    </colgroup>
                    <tbody>
                    <tr>
                        <th>메뉴</th>
                        <td colspan="3" id="menuAuthName">
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="tui-grid-container-wrap">
                <div id="menuAuthGrid"></div>
            </div>
        </section>
        <footer class="modal-card-foot is-center">
            <button class="modal-btn is-cancel">닫기</button>
            <button class="modal-btn is-primary" id="btnPopupSave">저장</button>
        </footer>
    </div>
</article>
<!-- //메뉴별 권한등록 팝업 -->

<script type="text/javascript">
    var treeData;
    var tree;
    let countData = 0;

    let menuList = [];
    let codeList = [];

    function convertTreeData (dataList, id, parent) {
        let dataMap = {};
        let treeList = [];

        for (let idx in dataList) {
            let data = dataList[idx];
            let key = data[id];
            dataMap[key] = data;
        }

        for (let key in dataList) {
            let data = dataList[key];
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

    function getModifiedDataJson(grid, fieldName) {
        const modifiedData = grid.getModifiedRows();
        const createData = modifiedData.createdRows;
        const updateData = modifiedData.updatedRows;
        const deleteData = modifiedData.deletedRows;
        let modified = new Array();
        for(let cdx in createData){
            const cData = createData[cdx];
            cData.rowStatus = 'C';
            modified.push(cData);
        }
        for(let udx in updateData){
            const uData = updateData[udx];
            uData.rowStatus = 'U';
            modified.push(uData);
        }
        for(let ddx in deleteData){
            const dData = deleteData[ddx];
            dData.rowStatus = 'D';
            modified.push(dData);
        }

        let dataSet = {};
        for (let idx in modified) {
            const row = modified[idx];
            for (let cidx in row) {
                const col = row[cidx];
                if (col && col != '' && cidx.indexOf('_') < 0) {
                    dataSet[fieldName + '[' + idx + '].' + cidx] = col;
                }
            }
        }
        if(Object.keys(dataSet).length == 0){
            dataSet = null;
        }
        return dataSet;
    };

    // 메뉴 리스트 조회
    function getMenuList(items){
        $.ajax({
            url: "/admin/menus",
            type: 'GET',
            async: false
        }).done(function (result) {
            for(let data in result) {
                items.push({text: '[' + result[data].menuId + '] ' + result[data].menuName, value: result[data].menuId});
            }
        }).fail(function(jqXHR) {
            alert('데이터 로드에 실패하였습니다.');
            return;
        });
    }

    // 코드 리스트 조회
    function getCodeList(list){
        let param = {
            codeKind : '1600'
        }

        $.ajax({
            url: "/getCodeDes",
            type: 'GET',
            async: false,
            data: param
        }).done(function (result) {
            for(let data in result) {
                list.push({text: result[data].codeName, value: result[data].code});
            }
        }).fail(function(jqXHR) {
            alert('데이터 로드에 실패하였습니다.');
            return;
        });
    }

    // 메뉴리스트 조회
    getMenuList(menuList);
    // 코드리스트 조회
    //getCodeList(codeList);

    const menuGrid = new tui.Grid({
        el: document.getElementById('menuGrid'), // 그리드 id
        //rowHeaders: ["checkbox"],
        rowHeaders: [
            {
                type: 'checkbox',
                header: "\n<label for=\"all-checkbox\" class=\"custom-checkbox-wrap\">\n<input type=\"checkbox\" id=\"all-checkbox\" class=\"hidden-input\" name=\"_checked\" />\n<span class=\"custom-checkbox\"></span>\n</label>\n",
                renderer: {
                    type: CheckboxRenderer
                }
            }
        ],
        //rowHeight: 20,
        /*header: {
            height: 50
        },*/
        bodyHeight: 450,
        scrollX: true,
        scrollY: true,
        editingEvent: "click",
        columns: [
            {
                header: '상위메뉴',
                name: 'menuIdUp',
                width: 150,
                formatter: 'listItemText',
                editor: {
                    type: 'select',
                    options: {
                        listItems: menuList
                    }
                },
                validation: { required: true }
            },
            /*{
                header: '하위메뉴ID',
                name: 'menuId',
                editor: 'text',
                align: 'center',
                width: 140,
                validation: { required: true },
                disabled : true
            },*/
            {
                header: '하위메뉴명',
                name: 'menuName',
                editor: 'text',
                width: 180,
                validation: { required: true }
            },
            {
                header: '하위메뉴URL',
                name: 'menuUrl',
                editor: 'text',
                width : 300
            },
            {
                header: '사용여부',
                name: 'usageInd',
                align: 'center',
                width: 85,
                formatter: 'listItemText',
                editor: {
                    type: 'select',
                    options: {
                        listItems: codeList
                    }
                }
            },
            {
                header: '정렬순서',
                name: 'sortSeq',
                editor: 'text',
                align: 'right',
                width: 140,
                validation: { dataType: 'number' }
            },
            {
                header: 'FILTER1',
                name: 'filter1',
                editor: 'text',
                width: 140
            },
            {
                header: 'ICON_CSS',
                name: 'iconCss',
                editor: 'text',
                width: 140
            }
        ]
    });

    const util = {
        addEventListener: function (element, eventName, handler) {
            if (element.addEventListener) {
                element.addEventListener(eventName, handler, false);
            } else {
                element.attachEvent("on" + eventName, handler);
            }
        }
    };


    tree = new tui.Tree('#tree', {
        nodeDefaultState: 'opened'
    }).enableFeature('Selectable', {
        selectedClassName: 'tui-tree-selected',
    });

    tree.on('select', function(eventData) {
        var nodeData = tree.getNodeData(eventData.nodeId);
        $('#menuName').text('['+nodeData.menuId+'] '+nodeData.text);
        //const codeData = nodeData.code;
        menuGridBind(nodeData.menuId);
    });

    const menuAuthGrid = new tui.Grid({
        el: document.getElementById('menuAuthGrid'),
        rowHeaders: [
            {
                type: 'checkbox',
                header: "\n<label for=\"all-checkbox\" class=\"custom-checkbox-wrap\">\n<input type=\"checkbox\" id=\"all-checkbox\" class=\"hidden-input\" name=\"_checked\" />\n<span class=\"custom-checkbox\"></span>\n</label>\n",
                renderer: {
                    type: CheckboxRenderer
                }
            }
        ],
        //rowHeaders: ['checkbox'],
        //rowHeight: 50,
        bodyHeight: 450,
        scrollX: false,
        scrollY: true,
        columns: [
            {
                header: '권한',
                name: 'authorName',
                align: 'center'
            }
        ]
    });


    function loadTreeGrid() {
        let params = {};
        $.ajax({
            url: "/admin/getMenu",
            type: 'GET',
            async: false,
            data: params
        }).done(function (result) {
            countData = result.length;
            treeData = result;

            treeData = convertTreeData(treeData, 'menuId', 'menuIdUp');
            tree.resetAllData(treeData);
            //initTree(treeData);
        }).fail(function(jqXHR, textStatus, errorThrown) {
            alert('데이터 로드에 실패하였습니다.');
            return;
        });
    };

    function menuGridBind(data) {
        let param = {
            menuIdUp : data
        };
        $.ajax({
            url: "/getMenuDes",
            type: 'GET',
            //cache: false,
            data: param,
            beforeSend: function(){
                $('#loading').show();
            },
            complete:function(data){
                $('#loading').hide();
            }
        }).done(function (resultData) {
            menuGrid.clear();
            menuGrid.resetData(resultData);
        });
    };

    //메뉴별 권한등록 팝업 그리드 데이터 바인딩
    let menuAuthData;
    let realAuthData;
    function menuAuthGridBind() {
        let param = {};
        $.ajax({
            url: "/getAllMenuAuth",
            type: 'GET',
            async: false,
            //cache: false,
            data: param
        }).done(function (resultData) {
            menuAuthData = resultData;
            menuAuthGrid.clear();
            menuAuthGrid.resetData(menuAuthData);
            menuAuthGrid.refreshLayout();
        });
    }

    // 저장 전 중복값 체크
    function chkValidKey(paramList) {
        let chkFlag = true;

        $.each(paramList, function(paramIdx, paramObj) {
            const chkMenuIdUp = paramObj.menuIdUp;
            const chkMenuName = paramObj.menuName;

            for(let compIdx=paramIdx+1; compIdx<paramList.length; compIdx++) {
                const compObj = paramList[compIdx];
                const compMenuIdUp = compObj.menuIdUp;
                const compMenuName = compObj.menuName;

                if(chkMenuIdUp == compMenuIdUp && chkMenuName == compMenuName) {
                    chkFlag = false;
                    break;
                }
            }
            if(!chkFlag) {
                alert("중복된 값이 있습니다.");
                menuGrid.focusAt(paramIdx, 0, true);
                return false;
            }
        });

        return chkFlag;
    }

    function delRow(grid) {
        const chkRows = grid.getCheckedRows();
        const selectedData = tree.getSelectedNodeId();
        if(chkRows.length == 0) {
            alert('행을 선택해주세요.');
            return;
        }
        if( confirm("하위메뉴까지 삭제하시겠습니까?")){
            $.ajax({
                url: "/deleteMenu",
                contentType: "application/json",
                type: "POST",
                async: false,
                data: JSON.stringify(chkRows),
                success: function() {
                    alert('삭제되었습니다.');
                    grid.removeCheckedRows(false);

                    var strArray = selectedData.split('-');
                    var strArrayInt = countData + (strArray[3]*1);
                    var newSelectedData = 'tui-tree-node-'+strArrayInt;
                    loadTreeGrid();
                    tree.select(newSelectedData);
                }
            }).fail(function(jqXHR, textStatus, errorThrown) {
                alert('데이터 삭제에 실패하였습니다.');
                return;
            });
        }else {
            return;
        }
    };

    function renameKey ( obj, oldKey, newKey ) {
        obj[newKey] = obj[oldKey];
        delete obj[oldKey];
    };

    $(document).ready(function(e){
        loadTreeGrid();
        /*treeData.forEach( function(obj){
            renameKey( obj, 'menuName', 'text' );
        });
        for(let idx in treeData) {
            let childrenArray = treeData[idx].children;
            console.log(childrenArray);
            if(childrenArray){
                childrenArray.forEach( function(obj) {
                    renameKey( obj, 'menuName', 'text' );
                });
                for(let jdx in childrenArray){
                    let childrenLists = childrenArray[jdx].children;
                    if(childrenLists){
                        childrenLists.forEach( function(obj) {
                            renameKey( obj, 'menuName', 'text' );
                        });
                    }
                }
            }
        }
        const treeUpdatedData = treeData;*/
    });

    $('#menuGrid').on('mouseleave',function(){
        if(typeof menuGrid.el !== "undefined") {
            menuGrid.finishEditing();
        }
    });

    //행 추가
    $(document).on('click', '#btnNewRow', function(e) {
        const selectedData = tree.getSelectedNodeId();
        const selectData = tree.getNodeData(selectedData);
        if(selectedData == null) {
            alert("상위메뉴를 선택해주세요.");
            return;
        }

        const appendRowKey = menuGrid.getData().length;
        let appendRowIndex = menuGrid.appendRow({
            'menuIdUp': selectData.menuId
        }, {focus: true});
        menuGrid.enableRow(appendRowKey);
    });

    // 행 삭제
    $(document).on('click', '#btnDeleteRow', function(e) {
        delRow(menuGrid);
    });

    // 그리드 데이터 저장
    $(document).on('click', '#btnSave', function(e) {
        let putMenuInfo = menuGrid.getData();
        const paramList = putMenuInfo;
        let modifiedData = getModifiedDataJson(menuGrid, 'tbMenuDtoList');

        if(menuGrid.validate().length > 0) {
            alert('필수값을 확인해주세요.');
            return;
        }
        if(modifiedData == null) {
            alert('저장할 데이터가 없습니다.');
            return;
        }
        const selectedData = tree.getSelectedNodeId();
        const selectData = tree.getNodeData(selectedData);
        if( confirm("저장하시겠습니까?")) {
            if(chkValidKey(paramList) == true) {
                $.ajax({
                    url: "/setMenu",
                    type: 'POST',
                    async: false,
                    data: modifiedData
                }).done(function (result) {
                    alert('저장되었습니다.');
                    //menuGridBind(selectData.menuId);

                    var strArray = selectedData.split('-');
                    var strArrayInt = countData + (strArray[3] * 1);
                    var newSelectedData = 'tui-tree-node-' + strArrayInt;
                    loadTreeGrid();
                    tree.select(newSelectedData);
                }).fail(function (jqXHR, textStatus, errorThrown) {
                    alert('데이터 저장에 실패하였습니다.');
                    return;
                });
            };
        }else {
            return;
        }
    });

    //메뉴별 권한등록 팝업 open
    $(document).on('click', '#btnMenuAuth', function(e) {

        const selectedData = tree.getSelectedNodeId();
        const selectData = tree.getNodeData(selectedData);
        if(selectedData == null) {
            alert("상위메뉴를 선택해주세요.");
            return;
        }

        $('#menuAuthPopup').addClass('is-active');
        $('#menuAuthName').text('['+selectData.menuId+'] '+selectData.menuName);
        menuAuthGridBind();
        menuAuthGrid.refreshLayout();

        let param = {
            menuId : selectData.menuId
        };
        $.ajax({
            url: "/getMenuAuth",
            type: 'GET',
            async: false,
            //cache: false,
            data: param
        }).done(function (resultData) {
            realAuthData = resultData;
        });
        for(let midx = 0; midx<menuAuthData.length; midx++){
            for(let ridx = 0; ridx<realAuthData.length; ridx++){
                if(menuAuthData[midx].authorId == realAuthData[ridx].authorId){
                    let authGridRowKey = menuAuthData[midx].rowKey;
                    menuAuthGrid.check(authGridRowKey);
                }
            }
        }
    });

    let checkedData;
    function getCheckedDataJson(fieldName) {

        let dataSet = {};
        for (let idx in checkedData) {
            const row = checkedData[idx];
            for (let cidx in row) {
                const col = row[cidx];
                if (col && col != '' && cidx.indexOf('_') < 0) {
                    dataSet[fieldName + '[' + idx + '].' + cidx] = col;
                }
            }
        }
        if(Object.keys(dataSet).length == 0){
            dataSet = null;
        }
        return dataSet;
    };

    //메뉴별 권한등록 팝업 저장
    $(document).on('click', '#btnPopupSave', function(e) {
        const selectedData = tree.getSelectedNodeId();
        const selectData = tree.getNodeData(selectedData);
        let menuIdData = selectData.menuId;
        checkedData = menuAuthGrid.getCheckedRows();
        if(checkedData.length == 0) {
            checkedData = [{ menuId : menuIdData , nullFlag : "Y" }];
        }else {
            for(let jdx = 0; jdx < checkedData.length; jdx++) {
                checkedData[jdx].menuId = menuIdData;
                checkedData[jdx].nullFlag = "N";
            }
        }
        let realCheckData = getCheckedDataJson('tbMenuAuthMapDtoList');
        $.ajax({
            url: "/insertAuth",
            //contentType: "application/json; charset=utf-8",
            type: "POST",
            async: false,
            data: realCheckData,
            success: function(result) {
                alert('저장되었습니다.');
                $('#menuAuthPopup').removeClass('is-active');
            }
        }).fail(function(jqXHR, textStatus, errorThrown) {
            alert('저장에 실패하였습니다.');
            return;
        });
    });

    // Checkbox
    /*$(document).on("click", ".tui-grid-row-header-checkbox input, .tui-grid-cell-row-header input", function () {
        var chk = $(this).is(":checked");
        if (chk) {
            $(this).parent().addClass("is-active");
        } else {
            $(this).parent().removeClass("is-active");
        }
    });*/

</script>
