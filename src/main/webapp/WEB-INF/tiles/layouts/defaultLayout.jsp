<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <title>(주)GS eAccounting</title>
  <link rel="icon" href="data:;base64,iVBORw0KGgo=">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <tiles:insertAttribute name="style"/>
  <tiles:insertAttribute name="script"/>
</head>
<body>
<!-- Header -->
<header id="Header" class="header">
  <tiles:insertAttribute name="header" ignore="true" />
</header>
<!-- Header -->
<section class="contents">
  <!-- LNB -->
  <div id="Lnb" class="lnb is-active">
    <tiles:insertAttribute name="left" ignore="true"/>
  </div>
  <!-- //LNB -->
  <!-- Main Navigator -->
  <tiles:insertAttribute name="body" ignore="true"/>
  <!-- //Main Navigator -->
</section>
<footer id="Footer" class="footer">
  <tiles:insertAttribute name="footer" ignore="true"/>
</footer>
</body>

</html>
