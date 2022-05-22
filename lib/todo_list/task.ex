defmodule TodoList.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :name, :string
    field :date, :date
    field :prio, :integer
  end

  def changeset(task, params \\ %{}) do
    task
    |> cast(params, [:name, :date, :prio])
    |> validate_required([:name, :date])
  end

  # def create_task(params) do
  #   changeset()
  # end
end
