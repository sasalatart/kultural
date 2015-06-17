// FUNCTIONS
var monthToNumber;
var messageMaker, messageDeleter, messageMgr;
var dateValidator, mailValidator, lengthValidator, passValidator, regexValidator;
var dateHandler, mailHandler, lengthHandler, passHandler, regexHandler;

var mailRegex = /^(([a-zA-Z]|[0-9])|([-]|[_]|[.]))+[@](([a-zA-Z0-9])|([-])){2,63}[.](([a-zA-Z0-9]){2,63})+$/;
var uniqueMail;

// HELPERS

// THANKS: http://stackoverflow.com/questions/13979961/how-do-you-force-your-javascript-event-to-run-first-regardless-of-the-order-in

$.fn.bindFirst = function(name, fn) {
  var elem, handlers, i, _len;
  this.bind(name, fn);
  for (i = 0, _len = this.length; i < _len; i++) {
    elem = this[i];
    handlers = jQuery._data(elem).events[name.split('.')[0]];
    handlers.unshift(handlers.pop());
  }
};


monthToNumber = function(month){
  return new Date(Date.parse(month +" 1, 2012")).getMonth();
};

// SHOW ERRORS

messageMaker = function(message, caller){
  if($(this).siblings('.form-error').length === 0){
    $(this).parent().append('<div class="form-error">' + message + '</div>');
  }
  else if($(this).siblings('.form-error').text() !== message){
    $(this).siblings('.form-error').text(message);
  }
}

messageDeleter = function(message){
  if($(this).siblings('.form-error').text() === message){
    $(this).siblings('.form-error').remove();
  }
}

messageMgr = function(truth, message){
  if(!truth){
    messageMaker.call($(this), message);
  }
  else{
    messageDeleter.call($(this), message);
  }
}

// VALIDATORS

mailValidator = function(){
  var that = $(this);

  var callback = function(r){
    uniqueMail = r['valid'];
    messageMgr.call($(that), uniqueMail, 'Email already exists');
  }

  if(regexValidator.call($(this), mailRegex, 'Not valid') && lengthValidator.call($(this), 1, 50, 'Mail is too long (max: 50 characters)')){
    return $.getJSON('/validator/mail', {mail: $(this).val()}, callback);
  } 

  return false;
}

lengthValidator = function(min, max, message){
  message = message || 'Out of range';

  valid = !($(this).val().length < min || $(this).val().length > max);
  messageMgr.call($(this), valid, message);
  return valid;
};

passValidator = function(passField, message){
  message = message || 'Passwords do not match';

  valid = $(this).val() === $(passField).val();
  messageMgr.call($(this), valid, message);
  return valid;
};

regexValidator = function(kind, message){
  message = message || 'REGEX does not match';

  valid = kind.test($(this).val());
  messageMgr.call($(this), valid, message);
  return valid;
};

dateValidator = function(dayField, monthField, yearField, from, to, message){
  message = message || 'Date out of range';

  day = +$(dayField).val();
  month = monthToNumber($(monthField).val());
  year = +$(yearField).val();
  date = new Date(year, month, day);

  valid = (from === undefined || date >= from) && (to === undefined || date <= to);
  messageMgr.call($(this), valid, message);
  return valid;
};

// HANDLERS

mailHandler = function(event){
  mailValidator.call($(this));
};

lengthHandler = function(event){
  lengthValidator.call($(this), event.data.min, event.data.max, event.data.message);
}

passHandler = function(event){
  passValidator.call($(this), event.data.passField, event.data.message);
}

regexHandler = function(event){
  regexValidator.call($(this), event.data.regex, event.data.message);
}

dateHandler = function(event){
  var day = event.data.day;
  var month = event.data.month;
  var year = event.data.year;
  var from = event.data.from;
  var to = event.data.to;
  var message = event.data.message;

  dateValidator.call($(this), day, month, year, from, to, message);
}


$(document).ready(function(){
  $("#user_name").bind('focusout', {min: 5, max: 50, message: 'Your name should contain between 5 and 50 characters'}, lengthHandler);
  $("#user_mail").bind('focusout', mailHandler);
  $("#user_password").bind('focusout', {min: 6, message: 'Password too short'}, lengthHandler);
  $("#user_password_confirmation").bind('focusout', {passField: '#user_password'}, passHandler);
  $("#user_phone").bind('focusout', {regex: /^\d{5,15}$/, message: 'Phone number should contain between 5 and 15 numbers'}, regexHandler);
  $("#user_birthday_3i, #user_birthday_2i, #user_birthday_1i").bind('click', 
    {day: '#user_birthday_3i',
    month: '#user_birthday_2i',
    year: '#user_birthday_1i',
    from: new Date(1900, 1, 1),
    to: new Date(),
    message: 'Your birthday should not be in the future'
  }, dateHandler);

  $("#user-form .actions input").bindFirst('click', function(event){
    var valid = true;
    var ajax = mailValidator.call($("#user_mail"));
    valid = valid && ajax;
    valid = valid && lengthValidator.call($("#user_mail"), 5, 50, 'Your name should contain between 5 and 50 characters');
    valid = valid && lengthValidator.call($("#user_password"), 6, undefined, 'Password too short');
    valid = valid && passValidator.call($("#user_password_confirmation"), '#user_password');
    valid = valid && regexValidator.call($("#user_phone"), /^\d{5,15}$/, 'Phone number should contain between 5 and 15 numbers');
    valid = valid && dateValidator.call($("#user_birthday_3i"), '#user_birthday_3i', '#user_birthday_2i', '#user_birthday_1i', new Date(1900, 1, 1), new Date(), 'Your birthday should not be in the future');

    valid = valid && uniqueMail;
    if(!valid){
      event.preventDefault();
      event.stopPropagation();
    }
  });
});