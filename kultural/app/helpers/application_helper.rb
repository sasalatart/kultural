module ApplicationHelper
  include Authorizable

  def date_hour(date)
    date.strftime("%d/%m/%Y %l:%M%p")
  end
end
