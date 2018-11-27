<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

<div class="row">
    <div class="col-md-3"></div>
    <div id="messages">
        <div class="col-md-3">
            <h2>Messages</h2>
            <div class="messages">
                @foreach($users as $user)
                @if(Auth::user() != $user)
                <div data-id="{{$user->id}}" data-name="{{$user->first_name}}">
                    <p href="{{route('user.profile', ['user'=>$user->id])}}" class="receiver btn msg-user">{{$user->first_name}}</p>
                </div>
                @endif
                @endforeach
            </div>
        </div>
    </div>
    <div class="col-md-6" id="chats">
        <h2 id="receiver"><a href="{{route('user.profile', $users[0]['id'])}}">{{$users[0]['first_name']}}</a></h2>
        <p class="hidden" id="id">{{$users[0]['id']}}</p>
        <div class="chat">
            <div class="messages">Chats</div>
        </div>
        <textarea class="entry" rows="5" cols="60"></textarea>
    </div>
    <div id="online">
        <div class="col-md-3">
            <h2>BUDDIES</h2>
            <div class="users">
                @foreach($users as $user)
                @if(Auth::user() != $user)
                <a href="{{route('user.profile', ['user'=>$user->id])}}" class="btn">{{$user->first_name}}</a>
                @endif
                @endforeach
            </div>
        </div>
    </div>
</div>

</body>


</html>
