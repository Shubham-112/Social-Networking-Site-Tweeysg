<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
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
        <div class="col-md-2" id="main-nav-back"></div>
        <div class="col-md-2" id="nav-user">
            <div id="main-nav">
                <a class="item" href="profile?id=<%=user.getId()%>" id="user">
                    <img height="24px" width="24px" src="../src/resources/user.png" alt="<%= user.getFirst_name() %>">
<!--
                    @if(Storage::disk('local')->has(Auth::user()->first_name.'-'.Auth::user()->id.'.jpg'))
                        <img height="24px" width="24px" src="{{route('account.image', ['filename'=>Auth::user()->first_name.'-'.Auth::user()->id.'.jpg'])}}" alt="{{Auth::user()->first_name}}">
                    @else
                        <img height="24px" width="24px" src="{{route('account.image', ['filename'=>'default-user.png'])}}" alt="{{Auth::user()->first_name}}">
                    @endif
-->
                    <span><%= user.getFirst_name() %></span>
                </a>
                <a class="item">
                    <img height="24px" width="24px" src="../src/resources/news.png">
                    <span>News Feed</span>
                </a>
                <a class="item" href="{{route('messages')}}">
                    <img height="24px" width="24px" src="../src/resources/message.png">
                    <span>Messaging</span>
                </a>
            </div>
            <hr>
            <div id="temp-nav">
                <h2>GROUPS</h2>
                <a class="item">
                    <img height="24px" width="24px" src="../src/resources/group1.png">
                    <span>Group 1</span>
                </a>
                <a class="item">
                    <img height="24px" width="24px" src="../src/resources/group2.png">
                    <span>Group 2</span>
                </a>
                <a class="item">
                    <img height="24px" width="24px" src="../src/resources/group3.png">
                    <span>Group 3</span>
                </a>
                <a class="item">
                    <img height="24px" width="24px" src="../src/resources/group4.png">
                    <span>Group 4</span>
                </a>
            </div>
        </div>
        <div class="col-md-2"></div>
        <div class="col-md-5 new-post" >
            <div id="post">
                <div id="post-options">
                    <span><img height="24px" width="24px" src="../src/resources/pen-post.png" alt="">Create a post</span>
                    <span><img height="24px" width="24px" src="../src/resources/post-cam.png" alt="">Video/Album</span>
                    <span><img height="24px" width="24px" src="../src/resources/post-location.png" alt="">Location</span>
                </div>
                <div class="post-body">
<!--
                    @if(Storage::disk('local')->has(Auth::user()->first_name.'-'.Auth::user()->id.'.jpg'))
                        <img height="44px" width="44px" src="{{route('account.image', ['filename'=>Auth::user()->first_name.'-'.Auth::user()->id.'.jpg'])}}" alt="{{Auth::user()->first_name}}">
                    @endif
-->                 <img height="44px" width="44px" src="../src/resources/user_color.png" alt="<%= user.getFirst_name() %>">
                    <form action="post" method="post" enctype="multipart/form-data">
                        <div class="form-field">
                            <textarea class="form-text" name="postBody" id="new-post" cols="30" placeholder="What's up !! Give way to your thoughts"></textarea>
                        </div>
                        <div class="clearfix"></div>
                        <div class="image-upload">
                            <label for="file-input">
                                <img id="post-image" width="40px" src="../src/resources/if_Sed-16_2232599.png" alt="">
                            </label>
                            <input type="file" name="file-input" id="file-input">
                        </div>
                        <button type="submit" class="btn">Create Post</button>
                    </form>
                </div>
            </div>

            <section class=" posts">
            <% List<PostBean> posts = (List<PostBean>) session.getAttribute("posts");
            for(PostBean post: posts){
                %>
                <article class="post" data-postid="<%=post.getId()%>">
                    <div class="posted-head">
                        <div class="posted-img">
                            <img height="44px" width="44px" src="../src/resources/user_color.png" alt="User">
                        </div>
                        <a href="{{route('user.profile', ['user'=>$post->user['id']])}}"><%=user.getFirst_name()%></a>
                        <div class="clearfix"></div>
                        <p><%=post.getDate()%></p>
                    </div>
                    <p class="posted-body"><%=post.getBody()%></p>
                    <img src="<%=post.getLink()%>" class="post-image img-responsive">
                    <div class="post-react">
                        <div class="row" style="margin-top: 10px !important;">
                            <div class="col-sm-4">
                                <button class="like-btn">Like</button>
                            </div>
                            <div class="col-sm-4">
                                <button class="btn">Wow</button>
                            </div>
                            <div class="col-sm-4">
                                <button class="btn">Love</button>
                            </div>
                        </div>
                    </div>
                </article>
                <%
            }
                request.setAttribute("posts", posts);
            %>

            <section class="posts">
                <c:forEach items="${posts}" var="post">
                    <h2><c:out value="${post.userId}"/></h2>
                </c:forEach>
            </section>



            <%--<section class=" posts">--%>

                <%--@foreach($posts as $post)--%>
                    <%--<?php $post_count = 0; ?>--%>
                    <%--<article class="post" data-postid="{{$post->id}}">--%>
                        <%--<div class="posted-head">--%>
                            <%--<div class="posted-img">--%>
                                <%--@if(Storage::disk('local')->has($post->user['first_name'].'-'.Auth::user()->id.'.jpg'))--%>
                                    <%--<img height="44px" width="44px" src="{{route('account.image', ['filename'=>Auth::user()->first_name.'-'.Auth::user()->id.'.jpg'])}}" alt="{{Auth::user()->first_name}}">--%>
                                <%--@else--%>
                                    <%--<img height="44px" width="44px" src="{{route('account.image', ['filename'=>'default-user.png'])}}" alt="{{Auth::user()->first_name}}">--%>
                                <%--@endif--%>
                            <%--</div>--%>
                            <%--<a href="{{route('user.profile', ['user'=>$post->user['id']])}}">{{$post->user['first_name']}}</a>--%>
                            <%--<div class="clearfix"></div>--%>
                            <%--<p>{{$post->created_at->format('F d Y - G:i')}}</p>--%>
                        <%--</div>--%>
                        <%--<p class="posted-body">{{ $post->body }}</p>--%>
<%--<!----%>
                        <%--@if(Storage::disk('local')->has('post-'.$post->id.'-image.jpg'))--%>
                            <%--<a class="posted-post-image" data-lightbox="image-{{$post->id}}" data-title="{{$post->body}}" href="{{route('post.image', ['filename'=>'post-'.$post->id.'-image.jpg'])}}" alt="" class="img-responsive"><div class="contain"><img--%>
                                            <%--src="{{route('post.image', ['filename'=>'post-'.$post->id.'-image.jpg'])}}" class="post-image img-responsive" alt=""></div></a>--%>
                        <%--@endif--%>
<%---->--%>
                        <%--<hr>--%>
                        <%--<div class="post-react">--%>
<%--<!----%>
                            <%--<p>--%>
                                <%--<?php $id = Auth::user()->id; ?>--%>
                                <%--<span>{{Auth::user()->likes()->where('post_id', $post->id)->first() ? Auth::user()->likes()->where('post_id', $post->id)->first()->like==1? 'You': '' : ''}}</span>--%>
                                <%--<span>--%>
                                            <%--@if(\App\Like::where('post_id', $post->id)->where('user_id', '!=', $id)->count()>0 && Auth::user()->likes()->where('post_id', $post->id)->first() ? Auth::user()->likes()->where('post_id', $post->id)->first()->like==1? true: false: false)--%>
                                        <%--and--%>
                                    <%--@endif--%>
                                        <%--</span>--%>
                                <%--<span>--%>
                                    <%--<span>--%>
                                                <%--@if((\App\Like::where('post_id', $post->id)->where('user_id','!=', $id)->count())>0)--%>
                                                    <%--{{\App\Like::where('post_id', $post->id)->where('user_id','!=', $id)->count()}}--%>
                                                <%--@endif--%>
                                    <%--</span>--%>
                                    <%--<span>--%>
                                                <%--@if(\App\Like::where('post_id', $post->id)->where('user_id', '!=', $id)->count()==1)--%>
                                                    <%--person like this--%>
                                                <%--@elseif(\App\Like::where('post_id', $post->id)->count()>1)--%>
                                                    <%--other people like this--%>
                                                <%--@elseif(\App\Like::where('post_id', $post->id)->where('user_id', '!=', $id)->count()==0 && Auth::user()->likes()->where('post_id', $post->id)->first() ? Auth::user()->likes()->where('post_id', $post->id)->first()->like==1 : false)--%>
                                                    <%--like this--%>
                                                <%--@endif--%>
                                            <%--</span>--%>
                                <%--</span>--%>
                            <%--</p>--%>
<%---->--%>
                        <%--</div>--%>
                        <%--<div class="interaction">--%>
<%--<!----%>
                            <%--<a href="#" class="btn like {{Auth::user()->likes()->where('post_id', $post->id)->first() ? Auth::user()->likes()->where('post_id', $post->id)->first()->like==1? 'liked' : 'normal' : 'normal'}}"><img--%>
                                        <%--src="{{URL::to('src/resources/if_like-01_186399.png')}}" alt=""> Like</a> |--%>
                            <%--<a href="#" class="btn like {{Auth::user()->likes()->where('post_id', $post->id)->first() ? Auth::user()->likes()->where('post_id', $post->id)->first()->like==0? 'disliked': 'normal' : 'normal' }}"><img--%>
                                        <%--src="{{URL::to('src/resources/if_dislike-01_186406 .png')}}" alt=""> Dislike</a>--%>
                            <%--@if(Auth::user() == $post->user)--%>
                                <%--|--%>
                                <%--<a href="#" class="btn edit normal"><img src="{{URL::to('src/resources/if_edit_2199097.png')}}" alt=""> Edit</a> |--%>
                                <%--<a href="{{route('post.delete', ['post_id' => $post->id])}}" class=" delete btn normal"><img--%>
                                            <%--src="{{URL::to('src/resources/if_Bin_2202256 .png')}}" alt=""> Delete</a>--%>
                            <%--@endif--%>
<%---->--%>
                        <%--</div>--%>
                        <%--<div class="add-comment">--%>
                            <%--<form method="post" action="{{route('comment.add')}}">--%>
                                <%--<div class="comment-field">--%>
                                    <%--<textarea name="comment" id="comment" cols="60" rows="3" placeholder="Type your comment here..."></textarea>--%>
                                <%--</div>--%>
                                <%--<button type="submit" class="btn btn-primary">Comment</button>--%>
                                <%--<input type="hidden" value="{{$post->id}}" name="post_id">--%>
                                <%--<input type="hidden" value="{{Session::token()}}" name="_token">--%>
                            <%--</form>--%>
                        <%--</div>--%>
                        <%--<div class="get-comments">--%>
                            <%--<p>Comments</p>--%>
                            <%--@foreach($comments as $comment)--%>
                                <%--@if($comment->post_id == $post->id)--%>
                                    <%--<div class="comment">--%>
                                        <%--<div class="posted-comment-img">--%>
                                            <%--@if(Storage::disk('local')->has($comment->user['first_name'].'-'.Auth::user()->id.'.jpg'))--%>
                                                <%--<img height="38px" width="38px" src="{{route('account.image', ['filename'=>Auth::user()->first_name.'-'.Auth::user()->id.'.jpg'])}}" alt="{{Auth::user()->first_name}}">--%>
                                            <%--@else--%>
                                                <%--<img height="38px" width="38px" src="{{route('account.image', ['filename'=>'default-user.png'])}}" alt="{{Auth::user()->first_name}}">--%>
                                            <%--@endif--%>
                                        <%--</div>--%>
                                        <%--<h3>{{$comment->user['first_name']}}</h3>--%>
                                        <%--<p>{{$comment->body}}</p>--%>
                                    <%--</div>--%>
                                <%--@endif--%>
                            <%--@endforeach--%>
                        <%--</div>--%>
                    <%--</article>--%>
                <%--@endforeach--%>
            <%--</section>--%>
        </div>
        <div class="col-md-2"></div>
        <div id="online">
            <div class="col-md-3">
                <h2>BUDDIES</h2>
                <div class="users">
                    <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
                                       url = "jdbc:mysql://localhost/tweeysg"
                                       user = "root"  password = "root"/>
                    <c:set var = "count" scope = "page" value = "${0}"/>
                    <sql:query dataSource = "${snapshot}" var = "request">
                        SELECT * from friendrequests WHERE AND requestBy=<%=user.getId()%>;
                    </sql:query>
                    <c:forEach var = "row" items = "${request.rows}">
                        <c:set var="count" value="${count + 1}" scope="page"/>
                        <c:if test="${row.status == 'accepted'}">
                            <sql:query dataSource = "${snapshot}" var = "result">
                                SELECT * from user WHERE id=${row.requestTo};
                            </sql:query>
                            <c:forEach var = "us" items = "${result.rows}">
                                <a href="profile/${row.requestTo}" class="btn">${us.first_name}</a>
                            </c:forEach>
                        </c:if>
                    </c:forEach>
                    @foreach($users as $user)
                        @if(Auth::user() != $user)
                            <a href="{{route('user.profile', ['user'=>$user->id])}}" class="btn">{{$user->first_name}}</a>
                        @endif
                    @endforeach
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" tabindex="-1" role="dialog" id="edit-modal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Edit Post</h4>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="post-body">Edit the Post</label>
                            <textarea name="post-body" class="form-control" id="post-body" cols="30" rows="5"></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="modal-save">Save changes</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    <script>
        var token = '{{ Session::token() }}';
        var urlEdit = '{{route('edit')}}';
        var urlLike = '{{route('post.like')}}';
    </script>

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
        <script src="../src/js/chat.js"></script>
        <script>
            var searchUrl = '{{route('search.bar')}}';
        </script>

    </body>
</html>