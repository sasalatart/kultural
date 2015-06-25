module ApplicationHelper
  include Sessionable

  def date_hour(date)
    date.strftime("%d/%m/%Y %l:%M%p")
  end
end
