// FUNCTIONS
var monthToNumber;
var messageMaker, messageDeleter, messageMgr;
var dateValidator, mailValidator, lengthValidator, equalsValidator, regexValidator;
//var dateHandler, mailHandler, lengthHandler, passHandler, regexHandler;

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
  var mailRegex = /^(([a-zA-Z]|[0-9])|([-]|[_]|[.]))+[@](([a-zA-Z0-9])|([-])){2,63}[.](([a-zA-Z0-9]){2,63})+$/;
  return regexValidator.call($(this), mailRegex, 'Not valid');
}

lengthValidator = function(min, max, message){
  message = message || 'Out of range';

  valid = !($(this).val().length < min || $(this).val().length > max);
  messageMgr.call($(this), valid, message);
  return valid;
};

equalsValidator = function(field, message){
  message = message || 'Fields do not match';

  valid = $(this).val() === $(field).val();
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
  console.log(dayField);
  console.log(monthField);
  console.log(yearField);
  day = +$(dayField).val();
  month = monthToNumber($(monthField).val());
  year = +$(yearField).val();
  date = new Date(year, month, day);

  valid = (from === undefined || date >= from) && (to === undefined || date <= to);
  messageMgr.call($(this), valid, message);
  return valid;
};

$.fn.validateSingle = function(rules, async){

  if(rules['required'] === true){
    if(!lengthValidator.call(this, 1, undefined, 'This field is mandatory')){
      return false;
    }   
  }

  if(rules['regex']){
    var regex = rules['regex']['regex'];
    var message = rules['regex']['message'];
    if(!regexValidator.call(this, regex, message)){
      return false;
    }
  }

  if(rules['mail'] === true){
    if(!mailValidator.call(this)){
      return false;
    }
  }

  if(rules['length']){
    var min = rules['length']['min'];
    var max = rules['length']['max'];
    var message = rules['length']['message'];
    if(!lengthValidator.call(this, min, max, message)){
      return false;
    }
  }

  if(rules['equals']){
    var field = "#" + rules['equals']['field'];
    var message = rules['equals']['message'];
    if(!equalsValidator.call(this, field, message)){
      return false;
    }
  }

  if(rules['date']){
    var year = this.parent().children('select')[0];
    var month = this.parent().children('select')[1];
    var day = this.parent().children('select')[2];
    var from = rules['date']['from'];
    var to = rules['date']['to'];
    var message = rules['date']['message'];
    if(!dateValidator.call(this, day, month, year, from, to, message)){
      return false;
    }
  }

  if(rules['remote']){
    var that = this;
    var uri = rules['remote']['uri'];
    var message = rules['remote']['message'];
    var valid = false;

    var request = $.ajax({
      url: uri,
      data: {mail: this.val()},
      async: async
    });
    
    request.done(function(res){
      valid = res['valid'];
      messageMgr.call($(that), valid, message);
    });

    if(!async){
      return valid;
    }
  }

  return true;
};

var validateSingleHandler = function(event){
  $(this).validateSingle(event.data.rules, true);
};

$.fn.validate = function(rules){
  for (var key in rules) {
    if ($("select[id^='" + key + "']").length > 0){
      $("select[id^='" + key + "']").bind('click', {rules: rules[key]}, validateSingleHandler);
    }
    else{
      $("#" + key).bind('focusout', {rules: rules[key]}, validateSingleHandler);
    }
  }

  this.find("[name='commit']").bindFirst('click', function(event){
    var valid = true;
    for (var key in rules) {
      if ($("select[id^='" + key + "']").length > 0){
        valid = valid && $("select[id^='" + key + "']").validateSingle(rules[key], false);
      }
      else{
        valid = valid && $("#" + key).validateSingle(rules[key], false);
      }
    }

    if(!valid){
      event.preventDefault();
      event.stopPropagation();
    }
  });
};
