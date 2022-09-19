defmodule TaskrWeb.CollectionsView do
  use TaskrWeb, :view

  def get_task_toggle_button_styles(task) do
    case task.completed do
       false -> "flex h-6 w-6 rounded-full border-2 border-black"
       _ -> "flex items-center justify-center h-6 w-6 rounded-full border-2 border-black bg-black"
    end
  end

  def get_task_text_styles(task) do
    case task.completed do
       false -> nil
       _ -> "line-through"
    end
  end
end
