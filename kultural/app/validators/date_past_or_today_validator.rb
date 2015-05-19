class DatePastOrTodayValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    return unless value.present?

    unless value <= Date.today
      record.errors[attribute] << (options[:message] || 
                                   "date should not be in the future")
    end
  end

end