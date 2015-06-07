$(document).ready ->
	$('.hide-button').click ->
		console.log(this)
		$(this).parent().children().fadeOut()
		$(this).parent().slideUp()
