<%@ page contentType="text/html;charset=UTF-8" language="java"  trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <tiles:insertAttribute name="header" />
</header>
<!-- Header -->
<section class="contents">
    <!-- LNB -->
    <div id="Lnb" class="lnb is-active">
        <tiles:insertAttribute name="left" />
    </div>
    <!-- //LNB -->
    <!-- Main Navigator -->
    <tiles:insertAttribute name="body"/>
    <!-- //Main Navigator -->
</section>
<footer id="Footer" class="footer">
    <tiles:insertAttribute name="footer"/>
</footer>
</body>

</html>