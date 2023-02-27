<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<section class="contents__body">
    <nav class="breadcrumb has-succeeds-separator" aria-label="breadcrumbs">
        <ul>
            <li><a href="/">HOME</a></li>
            <li class="is-active"><a href="#" aria-current="page">결재완료 문서</a></li>
        </ul>
    </nav>
    <h1 class="title">결재완료 문서</h1>
    <div class="table-wrap">
        <div class="table-header">
            <h2 class="subtitle">결재완료 문서</h2>
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
                                    <%--<option value="">선택</option>
                                    <option value="apprvTitle">제목</option>--%>
                                    <option value="purchaseName">거래처명</option>
                                    <option value="objAcctNo">전표번호</option>
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
    </div>
    <div class="tui-grid-container-wrap">
        <div id="approvalListGrid"></div>
    </div>
    <div id="paginationApprovalDoc" class="tui-pagination"></div>
</section>
