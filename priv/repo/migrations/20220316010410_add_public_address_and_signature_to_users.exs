defmodule Web3XLiveview.Repo.Migrations.AddPublicAddressAndSignatureToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add(:public_address, :string)
      add(:signature, :string)
    end
  end
end
