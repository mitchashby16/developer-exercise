require_relative 'blackjack'
require 'minitest/autorun'

class CardTest < Minitest::Test
  def setup
    @card = Card.new(:hearts, :ten, 10)
  end

  def test_card_suite_is_correct
    assert_equal @card.suite, :hearts
  end

  def test_card_name_is_correct
    assert_equal @card.name, :ten
  end
  def test_card_value_is_correct
    assert_equal @card.value, 10
  end
end

class DeckTest < Minitest::Test
  def setup
    @deck = Deck.new
  end

  def test_new_deck_has_52_playable_cards
    assert_equal @deck.playable_cards.size, 52
  end

  def test_dealt_card_should_not_be_included_in_playable_cards
    card = @deck.deal_card
    refute(@deck.playable_cards.include?(card))
  end

  def test_shuffled_deck_has_52_playable_cards
    @deck.shuffle
    assert_equal @deck.playable_cards.size, 52
  end
end

class PlayerTest < Minitest::Test
  def setup
    @player = Player.new(Deck.new)
  end

  def test_the_player_can_be_given_a_card
    assert_equal [], @player.hand.cards

    @player.hit

    assert_equal 1, @player.hand.cards.size
  end

  def test_the_player_has_a_total
    @player.hit

    assert_equal @player.hand.cards.first.value, @player.total
  end

  def test_the_dealer_will_keep_playing_until_it_passes_the_other_score
    @player.keep_playing(5)

    assert @player.total > 5
  end
end

class BlackJackTest < Minitest::Test

  def setup
    @blackjack = Blackjack.new
  end

  def test_it_can_inititlize_the_players
    assert_equal nil, @blackjack.user

    @blackjack.start

    assert_equal Player, @blackjack.user.class
  end
end
