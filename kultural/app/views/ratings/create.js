$('#avg-rating').replaceWith("<%= escape_javascript render partial: 'avg_rating', locals: { rateable: @rateable } %>");
$('#user-rating').replaceWith("<%= escape_javascript render partial: 'form', locals: { rateable: @rateable } %>");
