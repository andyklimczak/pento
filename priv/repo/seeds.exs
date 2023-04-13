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

products = [
  %{
    name: "Chess",
    description: "The classic",
    sku: 6_213_123,
    unit_price: 10,
  },
  %{
    name: "Tic Tac Toe",
    description: "X and Os",
    sku: 123_432,
    unit_price: 12.00,
  },
  %{
    name: "Table Tennis",
    description: "Small tennis",
    sku: 32_213_263,
    unit_price: 12.00,
  },
]

Enum.each(products, fn product ->
  Catalog.create_product(product)
end)
