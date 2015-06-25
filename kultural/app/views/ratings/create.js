$('#avg-rating').replaceWith("<%= escape_javascript render partial: 'avg_rating', locals: { rateable: @rateable } %>");
$('#user-rating').data('url', "<%= url_for([@rateable, @rating]) %>");
$('#user-rating').data('method', "<%= @rating.value ? 'PATCH' : 'POST' %>");
$('#user-rating').data('stars', <%= @rating.value || 0 %>);