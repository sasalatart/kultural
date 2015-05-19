$('#comments').html("<%= escape_javascript render('commentable_comments') %>");
$('#content').val("");