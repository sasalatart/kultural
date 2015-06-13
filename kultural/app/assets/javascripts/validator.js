var messageMaker, messageDeleter, messageMgr;
var mailValidator, presenceValidator, lengthValidator, passValidator;
var validateAll;
var mailRegex = /^(([a-zA-Z]|[0-9])|([-]|[_]|[.]))+[@](([a-zA-Z0-9])|([-])){2,63}[.](([a-zA-Z0-9]){2,63})+$/;

var uniqueMail;

messageMaker = function(message){
  $(this).after('<div class="form-error">' + message + '</div>');
}

messageDeleter = function(){
  $(this).siblings('.form-error').remove();
}

messageMgr = function(truth, message){
  messageDeleter.call($(this));
  if(!truth){
    messageMaker.call($(this), message);
  }
}

mailValidator = function(){
  var that = $(this);

  var callback = function(r){
    uniqueMail = r['valid'];
    messageMgr.call($(that), uniqueMail, 'Email already exists');
  }

  if(regexValidator.call($(this), mailRegex)){
    return ajax = $.getJSON('/validator/mail', {mail: $(this).val()}, callback);
  }
}

presenceValidator = function(message){
  return lengthValidator(1);
};

lengthValidator = function(min, max, message){
  valid = !($(this).val().length < min || $(this).val().length > max);
  messageMgr.call($(this), valid, 'Out of range');
  return valid;
};

passValidator = function(passField, message){
  valid = $(this).val() !== $(passField).val();
  messageMgr.call($(this), valid, 'Pass should be equal');
  return valid;
};

regexValidator = function(kind, message){
  valid = kind.test($(this).val());
  messageMgr.call($(this), valid, 'REGEX does not match');
  return valid;
};

validateAll = function(){
  mailValidator.call($("#user_mail"));
};

$(document).ready(function(){
  $("#user_mail").bind('focusout', mailValidator);
});


