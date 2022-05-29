defmodule TaskrWeb.TaskView do
  use TaskrWeb, :view

  def format_date(%NaiveDateTime{} = date) do
    "#{Timex.month_name(date.month)} #{date.day}, #{date.year}"
  end
end
