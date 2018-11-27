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
                <a class="navbar-brand" href="dashboard.jsp"><img src="../src/resources/logo_32.png" alt=""> <span>TWEEYSG</span></a>
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
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href="{{route('account')}}" id="head-user">
                            <img height="35px" width="35px" src="../src/resources/user_color.png" alt="{{Auth::user()->first_name}}">
                            <% UserBean user = (UserBean) session.getAttribute("user"); %>
                            <%= user.getFirst_name() %>
                            <!--
                                                                @if(Auth::user())
                                                                    @if(Storage::disk('local')->has(Auth::user()->first_name.'-'.Auth::user()->id.'.jpg'))
                                                                        <img height="35px" width="35px" src="{{route('account.image', ['filename'=>Auth::user()->first_name.'-'.Auth::user()->id.'.jpg'])}}" alt="{{Auth::user()->first_name}}">
                                                                    @else

                                                                    @endif
                                                                    <span>{{Auth::user()->first_name}}</span>
                                                                @endif
                            -->
                        </a>
                    </li>
                    <li><a href="{{route('account')}}"><img height="28px" width="28px" src="../src/resources/settings_32.png" alt=""></a></li>
                    <li id="notifis">
                        <a href="{{route('notifications')}}"><img src="../src/resources/notifications.png" height="28px" width="28px" alt=""></a>
                        <!--
                                                        @if(isset($notifs))
                                                            <div id="notifications">
                                                                <h2>Notifications</h2>
                                                                @foreach($notifs as $notif)
                                                                        <p>{{$notif->body}}</p>
                                                                @endforeach
                                                            </div>
                                                        @endif
                        -->
                    </li>
                    <li id="logout-li">
                        <a href="{{route('logout')}}"><img height="28px" width="28px" src="../src/resources/logout_32.png" alt=""></a>
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

<section class="row pictures">
    <div class="container">
        <div class="col-md-12" style="background-image: url('../src/resources/theme1.jpeg'); margin-top: 30px; padding: 30px; padding-bottom: 100px">

            <img src="../src/resources/user_color.png" style="height:300px; margin: 0 auto; margin-top: 50px" alt="{{$user->first_name}}" class="img-responsive profile">

        </div>
    </div>
</section>

<section class="row new-post">
    <div class="container">
        <div class="col-md-12" style="background-color: #fff">
            <%
                String getid = (String)request.getParameter("id");
                int igetid = Integer.parseInt(getid);

                if(igetid == user.getId()) {
            %>
            <h3><%=user.getFirst_name()%></h3>
            <header><h3>Your Account</h3></header>
            <form action="profile" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="first_name">First Name</label>
                    <input type="text" name="first_name" class="form-control" value="<%=user.getFirst_name()%>" id="first_name">
                </div>
                <div class="form-group">
                    <label for="first_name">First Name</label>
                    <input type="text" name="first_name" class="form-control" value="<%=user.getLast_name()%>" id="last_name">
                </div>
                <div class="form-group">
                    <label for="image">Image (only .jpg)</label>
                    <input type="file" name="image" class="form-control" id="image">
                </div>
                <div class="form-group">
                    <label for="cover">Cover (only .jpg)</label>
                    <input type="file" name="cover" class="form-control" id="cover">
                </div>
                <button type="submit" class="btn btn-primary">Update Account</button>
            </form>

            <%
                }else{
                    %>

            <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
                               url = "jdbc:mysql://localhost/tweeysg"
                               user = "root"  password = "root"/>

            <sql:query dataSource = "${snapshot}" var = "result">
                SELECT * from user WHERE id=<%=igetid%>;
            </sql:query>

            <c:forEach var = "row" items = "${result.rows}">
                <h3><c:out value = "${row.first_name}"/> <c:out value = "${row.last_name}"/></h3>
                <h4>Contact me at: <c:out value = "${row.email}"/></h4>
            </c:forEach>

                    <%
                }
            %>
        </div>
    </div>

</section>

</body>


</html>
