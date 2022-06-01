defmodule TaskrWeb.TaskView do
  use TaskrWeb, :view

  @doc """
  Returns a string of either "completed" or "inprogress"
  to be applied to as a class to a html element depending on
  the status of the task.
  """
  def get_status_class(task) do
    case task.completed do
      false -> "inprogress"
      _ -> "completed"
    end
  end

  def get_status(task) do
    case task.completed do
      false -> "In Progress"
      _ -> "Completed"
    end
  end

  @doc """
  Formats a datetime struct into a readable sentence.
  """
  def format_date(%NaiveDateTime{} = date) do
    "#{Timex.month_name(date.month)} #{date.day}, #{date.year}"
  end
end
