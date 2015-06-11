$('#comments').html("<%= escape_javascript render partial: 'commentable_comments', locals: { commentable: @commentable } %>");
$('#content').val("");
