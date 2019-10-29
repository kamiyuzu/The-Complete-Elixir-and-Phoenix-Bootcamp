defmodule Identicon do
  @moduledoc """
  Documentation for Identicon.
  """

  @doc """
  Hello world.

  ## Examples

      iex>

  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end

  def pick_color(previous_image = %Identicon.Image{hex: [red, green, blue | _tail]}) do
    %Identicon.Image{previous_image | color: {red, green, blue}}
  end

  def build_grid(previous_image = %Identicon.Image{hex: hex}) do
    grid =
      hex
      |> Enum.chunk_every(3,3,:discard)
      |> Enum.flat_map(&mirror_row/1)
      |> Enum.with_index
    %Identicon.Image{previous_image | grid: grid}
  end

  def mirror_row([one, two, three]) do
    [one, two, three, two, one]
  end

  def filter_odd_squares(previous_image = %Identicon.Image{grid: previous_grid}) do
    new_grid =
      previous_grid
      |> Enum.filter(fn {code, _index} ->
        rem(code,2) == 0
      end)
    %Identicon.Image{previous_image | grid: new_grid}
  end

  def build_pixel_map(previous_image = %Identicon.Image{grid: previous_grid}) do
    pixel_map =
      Enum.map(previous_grid, fn {_code, index} ->
        horizontal = rem(index, 5) * 50
        vertical = div(index, 5) * 50

        top_left = {horizontal, vertical}
        bottom_rigth = {horizontal+50, vertical+50}

        {top_left, bottom_rigth}
      end)
    %Identicon.Image{previous_image | pixel_map: pixel_map}
  end

  def draw_image(%Identicon.Image{pixel_map: pixel_map, color: color}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)
    pixel_map
    |> Enum.each(fn {start, stop} ->
      :egd.filledRectangle(image, start, stop, fill)
    end)
    :egd.render(image)
  end

  def save_image(image, input) do
    File.write("#{input}.jpeg", image)
  end

end
