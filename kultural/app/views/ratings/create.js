$('#avg-rating').html("<%= escape_javascript render partial: 'avg_rating', locals: { rateable: @rateable } %>");
