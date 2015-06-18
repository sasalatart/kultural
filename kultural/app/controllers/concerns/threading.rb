module Threading
# Thanks, https://www.agileplannerapp.com/blog/building-agile-planner/rails-background-jobs-in-threads

  def background(&block)
    Thread.new do
      yield
      ActiveRecord::Base.connection.close
    end
  end

end