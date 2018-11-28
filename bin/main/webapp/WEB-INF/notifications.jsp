<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<%@ page import="Beans.UserBean" %>
<%@ page import="java.util.List" %>
<%@ page import="Beans.PostBean" %>

<!DOCTYPE html>
<html>
<head>
    <title>TWEEYSG</title>
    <!--        <meta name="csrf-token" content="{{ csrf_token() }}">-->

    <link rel="icon" href="../src/resources/logo_32.png">

    <link rel="stylesheet" href="../src/css/message.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="../src/css/main.css">
    <link rel="stylesheet" href="../src/resources/lightbox2-master/src/css/lightbox.css">
    <link rel="stylesheet" href="../src/css/profile.css">

    <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Zilla+Slab" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Zilla+Slab" rel="stylesheet">

    <style>
        .like-btn{
            width: 100%;
            border: 1px solid #00bfff;
            padding: 10px;
            margin-bottom: 10px;
            background-color: #0080ff;
            color: #fff;
        }
    </style>

</head>

<body>

<sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
                   url = "jdbc:mysql://localhost/tweeysg"
                   user = "root"  password = "root"/>

<header>
    <nav class="navbar navbar-default navbar-fixed-top">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="/index.jsp"><img src="../src/resources/logo_32.png" alt=""> <span>TWEEYSG</span></a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-left">
                    <div class="search">
                        <form action="" method="post">
                            <input type="text" name="search-bar" id="search-bar" placeholder="Search">
                            <div class="search-result">
                                <p class="result">Type your search keywords</p>
                            </div>
                            <button type="submit" value="Search"><img width="25px" height="24px" src="../src/resources/search-1.png"></button>
                        </form>
                    </div>
                </ul>
                <% UserBean user = (UserBean) session.getAttribute("user"); %>
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href="profile?id=<%=user.getId()%>" id="head-user">
                            <img height="35px" width="35px" src="../src/resources/user_color.png" alt="{{Auth::user()->first_name}}">

                            <%= user.getFirst_name() %>
                        </a>
                    </li>
                    <li><a href="{{route('account')}}"><img height="28px" width="28px" src="../src/resources/settings_32.png" alt=""></a></li>

                    <c:set var = "count" scope = "page" value = "${0}"/>
                    <sql:query dataSource = "${snapshot}" var = "request">
                        SELECT * from friendrequests WHERE requestTo=<%=user.getId()%> AND status="pending";
                    </sql:query>
                    <c:forEach var = "row" items = "${request.rows}">
                        <c:set var="count" value="${count + 1}" scope="page"/>
                    </c:forEach>

                    <c:if test="${count>0}">
                        <li id="notifis" style="background-color: orange">
                            <a href="notifications"><img src="../src/resources/notifications.png" height="28px" width="28px" alt=""><c:out value="${count}"/></a>
                        </li>
                    </c:if>
                    <c:if test="${count==0}">
                        <li id="notifis">
                            <a href="notifications"><img src="../src/resources/notifications.png" height="28px" width="28px" alt=""></a>
                        </li>
                    </c:if>

                    <li id="logout-li">
                        <a href="logout"><img height="28px" width="28px" src="../src/resources/logout_32.png" alt=""></a>
                        <div class="logout-down">
                            <a href="">Logout</a>
                        </div>
                    </li>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>
</header>
<div class="background-image"></div>

<div class="row">
    <div class="container">
        <div class="col-sm-12" style="background-color: #fff; padding: 30px; margin-top: 30px;">
            <h3>Friend Requests</h3>
            <c:if test="${count>0}">
                <c:forEach var = "row" items = "${request.rows}">
                        <c:if test="${row.status == 'pending'}">
                            <sql:query dataSource = "${snapshot}" var = "result">
                                SELECT * from user WHERE id=${row.requestBy};
                            </sql:query>
                            <c:forEach var = "us" items = "${result.rows}">
                                <a href="/profile?id=${row.requestBy}" class="btn">${us.first_name}</a>
                                <form action="notifications" method="post">
                                    <input type="hidden" value="${row.requestBy}" name="reqBy">
                                    <input type="submit" class="btn btn-primary" name="action" value="Accept">
                                    <input type="submit" class="btn btn-danger" name="action" value="Decline">
                                </form>
                            </c:forEach>
                        </c:if>

                </c:forEach>
            </c:if>
        </div>
    </div>
</div>





<script
        src="https://code.jquery.com/jquery-3.2.1.min.js"
        integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
        crossorigin="anonymous"></script>
<script
        src="https://code.jquery.com/jquery-migrate-3.0.0.min.js"
        integrity="sha256-JklDYODbg0X+8sPiKkcFURb5z7RvlNMIaE3RA2z97vw="
        crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<script src="../src/js/app.js"></script>
<script src="../src/resources/lightbox2-master/src/js/lightbox.js"></script>
</body>


</html>
