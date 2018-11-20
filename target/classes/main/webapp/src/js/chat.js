$.ajaxSetup({
    headers: {
        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
    }
});

var chat = {}

chat.throwMessage = function (message, receiver) {
    $.ajax({
        method: 'POST',
        url: send,
        data: { body:message, receiver: receiver, _token: token},
        headers: {'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')}
    }).done(function (msg) {
        $('')
    }).error(function(data) { // the data parameter here is a jqXHR instance
        var errors = data;
        console.log('server errors',errors);
    });
};

chat.fetchMessages = function () {
    var receiver = $('#chats').find('#id').text();
    $.ajax({
        method: 'POST',
        url: getm,
        data: { receiver: receiver , _token: token },
        success: function (data) {
            console.log(data['all']);
            $('.chat').empty();
            for(var i in data['all'])
            {
                if((data['all'][i][1])==receiver)
                    $('.chat').append("<div class='messages'>"+ data['all'][i][0] +"</div>");
                else
                    $('.chat').append("<div class='sent'>"+ data['all'][i][0] +"</div>");
            }
        }
    });
};

chat.entry = $('.entry');
chat.entry.bind('keydown', function (e) {
   if(e.keyCode===13 && e.shiftKey === false)
   {
       var id = $('#id').text();
       chat.throwMessage($(this).val(),id);
       e.preventDefault();
       chat.fetchMessages();
       $('.entry').val('');
   }
});

$('.receiver').on('click', function (event) {
    event.preventDefault();
    var id = event.target.parentNode.dataset['id'];
    var name = event.target.parentNode.dataset['name'];
    $('#receiver').text(name);
    $('#id').text(id);
});

chat.interval = setInterval(chat.fetchMessages, 1000);
chat.fetchMessages();

$('.receiver').on('click', function (event) {
    chat.fetchMessages();
});