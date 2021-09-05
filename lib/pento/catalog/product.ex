defmodule Pento.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  alias Pento.Survey.Rating

  schema "products" do
    field :description, :string
    field :name, :string
    field :sku, :integer
    field :unit_price, :float
    field :image_upload, :string

    timestamps()

    has_many :ratings, Rating
  end

  def changeset(product, %{unit_price: unit_price} = attrs) do
    product
    |> change(attrs)
    |> validate_change(
         :unit_price,
         fn :unit_price, unit_price ->
           if product.unit_price < unit_price do
             [unit_price: "cannot increase"]
           else
             []
           end
         end
       )
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :unit_price, :sku, :image_upload])
    |> validate_required([:name, :description, :unit_price, :sku])
    |> unique_constraint(:sku)
    |> validate_number(:unit_price, greater_than: 0.0)
  end
end
