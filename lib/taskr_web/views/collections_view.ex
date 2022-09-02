defmodule TaskrWeb.CollectionsView do
  use TaskrWeb, :view

  def get_task_toggle_button_styles(task) do
    case task.completed do
       false -> "flex  h-6 w-6 rounded-full border bg-gray-50"
       _ -> "flex items-center justify-center h-6 w-6 rounded-full border border-green-600 bg-green-200"
    end
  end

  def get_task_text_styles(task) do
    case task.completed do
       false -> nil
       _ -> "text-gray-300 line-through"
    end
  end
end
