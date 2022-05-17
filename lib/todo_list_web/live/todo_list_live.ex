defmodule TodoListWeb.TodoListLive do
  use TodoListWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
      todo_list: [],
      name: ""#,
      #id: 0
      )
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Todo List</h1>
    <%= if @name != "" do %>
      <h2><%= @name %>'s List</h2>
    <% end %>
    <div id="light">
      <div class="todo-list">
        <table style="width:100%">
          <tr>
            <th>Task</th>
            <th>Due Date</th>
            <th>Priority</th>
          </tr>
          <%= for task <- @todo_list do %>
            <tr>
              <th><%= task.name %></th>
              <th><%= task.date %></th>
              <th><%= task.prio %></th>
            </tr>
          <% end %>
        </table>
      </div>


      <button phx-click="new_task">
        <img src="images/light-on.svg">
      </button>
    </div>

    """
  end

  # <%= for task <- @todo_list do %>
        # <li><%= task.name %> - <%= task.time %> - <%= task.priority %></li>
      # <% end %>

  def handle_event("new_task", _, socket) do
    case socket.assigns.todo_list do
      [] ->
        socket = assign(socket, todo_list: [%{name: "task 1", date: "123", prio: "1"}], name: "Godwin")
        {:noreply, socket}
      _list ->
        socket = socket
        |> update(:todo_list, &(&1 ++ [%{name: "task 1", date: "123", prio: "1"}] ))
        {:noreply, socket}
    end
  end
end
