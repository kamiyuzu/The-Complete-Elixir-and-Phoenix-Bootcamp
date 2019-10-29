defmodule Cards do
  @moduledoc """
  Documentation for Cards.
  Provides methods for creating and handling a deck of cards.
  """

  @doc """
  Returns a list of strings representing a deck.
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for value <- values, suit <- suits do
        "#{value} of #{suit}"
    end

  end

  @doc """
  Returns a shuffled list from the argument
  """
  def shuffle(deck) do
    deck |>
    Enum.shuffle
  end

  @doc """
  Returns true if the card is in the deck

  ## Examples
      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck,"Ace of Spades")
      true
  """
  def contains?(deck, card) do
    deck |>
    Enum.member?(card)
  end

  @doc """
  Returns a deal from the deck by hand_size
  ## Examples
        iex> deck = Cards.create_deck
        iex> {hand, _deck} = Cards.deal(deck,1)
        iex> hand
        ["Ace of Spades"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
  Saves the deck into the filename given
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
  Loads the filename given
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, reason} -> "That file does not exist. #{reason}"
    end
  end

  @doc """
  Creates a hand from the deck by size of hand_size
  """
  def create_hand(hand_size) do
    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end

end
