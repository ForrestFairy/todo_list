defmodule TodoList.Repo.Migrations.Tasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :name, :string
      add :date, :date
      add :prio, :integer
    end
  end
end
