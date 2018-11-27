var postId = 0;
var postBodyElement = null;

$.ajaxSetup({
    headers: {
        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
    }
});
$('.post').find('.interaction').find('.edit').on('click', function (event) {
    event.preventDefault();
    postBodyElement = event.target.parentNode.parentNode.childNodes[3];
    console.log(postBodyElement);
    var postBody = postBodyElement.textContent;
    postId = event.target.parentNode.parentNode.dataset['postid'];
    $('#post-body').val(postBody);
    $('#edit-modal').modal();
});

$('#modal-save').on('click', function () {
    $.ajax({
        method: 'POST',
        url: urlEdit,
        data: { body: $('#post-body').val(), postId: postId, _token: token }
    }).done(function (msg) {
        $(postBodyElement).text(msg['post_body']);
        $('#edit-modal').modal('hide');
    });
});



$('.like').on('click', function (event) {
    event.preventDefault();
    postId = event.target.parentNode.parentNode.dataset['postid'];
    var you = event.target.parentNode.previousElementSibling.firstElementChild.childNodes[1];
    var and = event.target.parentNode.previousElementSibling.firstElementChild.childNodes[3];
    var other = event.target.parentNode.previousElementSibling.firstElementChild.childNodes[5];
    var isLike = event.target.previousElementSibling == null;
    $.ajax({
        method:'POST',
        url: urlLike,
        data: {isLike: isLike, postId: postId, _token: token}
    })
        .done(function () {
            if(isLike)
            {
                if($(event.target).hasClass('liked'))
                {
                    $(event.target).removeClass('liked');
                    $(event.target).addClass('normal');
                    $(you).text('');
                    $(and).text('');
                    var num = $(other.childNodes[3]);
                    if(($(num).text()).trim()=='like this')
                    {
                        $(num).text('');
                    }
                }
                else
                {
                    $(event.target).removeClass('normal');
                    $(event.target).addClass('liked');
                    $(you).text('You');
                    var num = $(other.childNodes[3]);
                    if((num.text()).trim()!='' && (num.text()).trim()!='like this')
                    {
                        $(and).text('and');
                    }
                    if((num.text()).trim()=='')
                    {
                        $(num).text('like this');
                    }

                }
                var next = event.target.nextElementSibling;
                if($(next).hasClass('disliked'))
                {
                    $(next).removeClass('disliked');
                    $(next).addClass('normal');
                }
            }
            else
            {
                if($(event.target).hasClass('disliked'))
                {
                    $(event.target).removeClass('disliked');
                    $(event.target).addClass('normal');
                }
                else
                {
                    $(event.target).removeClass('normal');
                    $(event.target).addClass('disliked');
                    $(you).text('');
                    $(and).text('');
                    var num = $(other.childNodes[3]);
                    if(($(num).text()).trim()=='like this')
                    {
                        $(num).text('');
                    }
                }

                var pre = event.target.previousElementSibling;
                if($(pre).hasClass('liked'))
                {
                    $(pre).removeClass('liked');
                    $(pre).addClass('normal');
                }
            }

        });
});

$('#logout-li').on('click', function () {
    if($('.logout-down').css('display')=='block')
    {
        $('.logout-down').css('display', 'none');
    }
    else
    {
        $('.logout-down').css('display', 'block');
    }
});

$('#search-bar').click(function () {
    if($('#search-bar').val() == '')
    {
        $('.result').text('Type your search keywords');
    }
});

$('#search-bar').keyup(function () {
    if($('#search-bar').val() == '')
    {
        $('.search-result').empty();
        $('.search-result').append("<p class='result'>Type your search keywords</p>");
    }
    else{
        $.ajax({
            method: 'POST',
            url: searchUrl,
            data: {query: $('#search-bar').val(), _token: token}
        }).done(function (msg) {
            $('.search-result').empty();
            if(msg['result']=='No result')
            {
                $('.search-result').empty();
                $('.search-result').append("<p class='result'>No result found !</p>");
            }
            else{
                var count=0;
                for(var ans in msg['result'])
                {
                    $('.search-result').append("<a href='/profile/" + msg['result'][count]['id'] + "' class='result'>" + msg['result'][count]['first_name'] + "</a>");
                    count++;
                }
            }
        });
    }
});

$('#search-bar').on('click', function () {
    $('.search-result').css("display", "block");
});

$('body').on('click', function () {

    if(($('#search-bar').is(':focus')==true))
    {

    }else{
        $('.search-result').css("display", "none");
    }
});

$('#notifis').on('click', function (event) {
    event.preventDefault();
    if(($('#notifications').css("display"))=='none')
    {
        $('#notifications').css("display", "block");
    }else{
        $('#notifications').css("display", "none");
    }
});

