$("#num-reports").html("<%= escape_javascript render partial: 'num_reports', locals: { reportable: @reportable } %>");
$("#new_report").fadeOut();