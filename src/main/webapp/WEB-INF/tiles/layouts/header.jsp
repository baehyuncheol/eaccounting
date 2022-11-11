<%@ page contentType="text/html;charset=UTF-8" language="java" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="header__inner level">
  <h1 class="header__title level-left">
    <a href="/">GS E-Accounting</a>
  </h1>
  <div class="etc-menu level-right">
    <p class="etc-menu__guide">
    <c:if test="${!empty(SESSION_USERINFO.userName)}">
      ${SESSION_USERINFO.userName} 님&nbsp;&nbsp;안녕하세요 :)
    </c:if>
    </p>
    <p id="--monitor"></p>
    <p id="--config"></p>
    <c:if test="${SESSION_USERINFO.authorId eq '1' || SESSION_USERINFO.authorId eq '2' || SESSION_USERINFO.authorId eq '9'}">
        <p class="level-item">
          <a href="#" class="etc-btn etc-btn--manual">매뉴얼</a>
        </p>
    </c:if>
    <p class="level-item">
      <c:if test="${!empty(SESSION_USERINFO.userName)}">
      <a href="/logout " class="etc-btn etc-btn--log">로그아웃</a>
      </c:if>
      <c:if test="${empty(SESSION_USERINFO.userName)}">
        <a href="/loginView" class="etc-btn etc-btn--log">로그인</a>
      </c:if>
    </p>
    <c:if test="${!empty(SESSION_USERINFO.userName) && (SESSION_USERINFO.authorId eq '1' || SESSION_USERINFO.authorId eq '2' || SESSION_USERINFO.authorId eq '9')}">
    <p class="level-item">
       <a href="#" onclick="javascript:window.open('/taxbillPopup','taxWindow', 'scrollbars=no,width=1600,height=1000,status=no,resizable=no');" class="etc-btn etc-btn--monitor">세금계산서</a>
    </p>
    </c:if>
    <c:if test="${!empty(SESSION_USERINFO.userName) && (SESSION_USERINFO.authorId eq '1' || SESSION_USERINFO.authorId eq '2' || SESSION_USERINFO.authorId eq '9')}">
      <p class="level-item">
        <a href="/admin/setting" class="etc-btn etc-btn--config">환경설정</a>
      </p>
    </c:if>
  </div>
</div>


