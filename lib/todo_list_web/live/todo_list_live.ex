defmodule TodoListWeb.TodoListLive do
  use TodoListWeb, :live_view
  alias TodoList.Task

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
      todo_list: TodoList.Repo.all(Task),
      username: "",
      # name: "",
      # date: "",
      # prio: 0,
      changeset: Task.changeset(%Task{}, %{})
      )
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Todo List</h1>
    <%= if @username != "" do %>
      <h2><%= @username %>'s List</h2>
    <% end %>
    <div id="light">
      <div class="todo-list">
        <table style="width:100%" position="flex">
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
      <br>



      <.form let={f} for={@changeset} phx-submit="save">
        <%= label f, :name %>
        <%= text_input f, :name %>
        <%= error_tag f, :name %>

        <label>
          Date: <%= date_input f, :date %>
        </label>

        <label>
          Priority: <%= select f, :prio, 1..5 %>
        </label>

        <%= submit "Save" %>
      </.form>

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
        socket = assign(socket, todo_list: [%{name: "task 1", date: "123", prio: "1"}], username: "Godwin")
        {:noreply, socket}
      _list ->
        socket = socket
        |> update(:todo_list, &(&1 ++ [%{name: "task 1", date: "123", prio: "1"}] ))
        {:noreply, socket}
    end
  end

  def handle_event("save", %{"task" => task}, socket) do
    task = Task.changeset(%Task{}, task)
    case TodoList.Repo.insert(task) do
      {:ok, _struct} ->
        socket = add_task(socket, task)
        {:noreply, socket}
      {:error, _changeset} ->
        socket = socket
        |> put_flash(:info, "Bad input")
        {:noreply, socket}
    end
  end

  def add_task(socket, task) do
    task = task.changes
    # %{date: date, name: name, prio: prio} = task
    case socket.assigns.todo_list do
      [] ->
        socket = assign(socket, todo_list: [task], name: "Godwin")
        socket
      _list ->
        socket = socket
        |> update(:todo_list, &(&1 ++ [task] ))
        socket
    end
  end
end
