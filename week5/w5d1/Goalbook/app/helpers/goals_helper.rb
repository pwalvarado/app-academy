module GoalsHelper
  def completion_status
    @goal.completed ? 'Complete' : 'Incomplete'
  end
end
