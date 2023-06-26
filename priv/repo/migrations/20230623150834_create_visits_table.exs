defmodule Core.Repo.Migrations.CreateVisitsTable do
  use Ecto.Migration

  def change do
    create table(:visits, primary_key: false) do
      add :counter, :integer, default: 0
      add :date, :date, primary_key: true
      add :path, :string, primary_key: true
    end
  end
end
