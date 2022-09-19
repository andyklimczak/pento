# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Pento.Repo.insert!(%Pento.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Pento.Catalog

# mix run priv/repo/seeds.exs
products = [
  %{
    name: "Chess",
    description: "chess",
    sku: 5_345_345,
    unit_price: 10.00
  },
  %{
    name: "Tic Tac Toe",
    description: "ttt",
    sku: 5_213,
    unit_price: 7.00,
  },
  %{
    name: "Table Tennis",
    description: "table tennis",
    sku: 1_000,
    unit_price: 14.00,
  }
]

Enum.each(products, fn product ->
  Catalog.create_product(product)
end)
