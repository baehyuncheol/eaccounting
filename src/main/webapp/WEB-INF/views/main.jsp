<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

<!-- Main Contents -->
<section class="main-body">
    <section class="main-mid-body">
        <div class="main-doc">
            <h1 class="doc-title">결재문서함</h1>
            <div class="doc-wrap">
                <div class="doc-box doc-box--ing">
                    <!--<h2 class="doc-subtitle">
                        <a href="${menuWriteUrl}">작성중 <span class="cnt"></span></a>
                    </h2>
                    <ul class="doc-list" id="apprWriteList">-->
                        <li class="doc-item">
                            <a href="#">
                                <span class="badge">임시저장</span>
                                <span class="doc-item-text">11월 경비사용보고서</span>
                            </a>
                        </li>
                        <li class="doc-item">
                            <a href="#">
                                <span class="badge">임시저장</span>
                                <span class="doc-item-text">11월 경비사용보고서</span>
                            </a>
                        </li>
                        <li class="doc-item">
                            <a href="#">
                                <span class="badge">임시저장</span>
                                <span class="doc-item-text">11월 경비사용보고서</span>
                            </a>
                        </li>
                        <li class="doc-item">
                            <a href="#">
                                <span class="badge">임시저장</span>
                                <span class="doc-item-text">11월 경비사용보고서</span>
                            </a>
                        </li>
                    </ul>
                </div>

                <div class="doc-box doc-box--unresolved">
                    <!--<h2 class="doc-subtitle">
                        <a href="${menuIngUrl}">결재중 <span class="cnt"></span></a>
                    </h2>-->
                    <ul class="doc-list" id="apprIngList">
                        <li class="doc-item" >
                            <a href="#">
                                <span class="badge">1차</span>
                                <span class="doc-item-text">12월 경비사용보고서</span>
                            </a>
                        </li>
                    </ul>
                </div>

                <div class="doc-box doc-box--complete">
                    <!--<h2 class="doc-subtitle">
                        <a href="${menuEndUrl}">결재완료 <span class="cnt"></span></a>
                    </h2>-->
                    <ul class="doc-list" id="apprEndist">
                        <li class="doc-item">
                            <a href="#">
                                <span class="badge">완료</span>
                                <span class="doc-item-text">11월 경비사용보고서</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <section class="search-body">
            <div class="search">
                <div class="field">
                    <button class="search-input-btn" type="button">검색</button>
                    <div class="control search-box">
                        <input class="input" type="text" id="txtSearch" />
                    </div>
                    <!-- 검색 자동완성 기능 -->
                    <ul class="search-result-list" style="display:none">
                    </ul>
                    <!-- 검색 자동완성 기능 -->
                </div>

                <ul class="search-list">
                </ul>
            </div>

            <div class="bookmark">
                <div class="bookmark-head">
                    <h2>즐겨찾기</h2>
                    <span id="bookmarkCnt"></span>
                </div>
                <ul class="bookmark-list" id="bookmarkList">
                </ul>
            </div>
        </section>
    </section>
</section>