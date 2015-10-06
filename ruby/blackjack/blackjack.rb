require 'pry'
class Card
  attr_accessor :suite, :name, :value

  def initialize(suite, name, value)
    @suite, @name, @value = suite, name, value
  end
end

class Deck
  attr_accessor :playable_cards
  SUITES = [:hearts, :diamonds, :spades, :clubs]
  NAME_VALUES = {
    :two   => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 10,
    :queen => 10,
    :king  => 10,
    :ace   => [11, 1]}

    def initialize
      shuffle
    end

    def deal_card
      random = rand(@playable_cards.size)
      @playable_cards.delete_at(random)
    end

    def shuffle
      @playable_cards = []
      SUITES.each do |suite|
        NAME_VALUES.each do |name, value|
          @playable_cards << Card.new(suite, name, value)
        end
      end
    end
  end

  class Hand
    attr_accessor :cards

    def initialize
      @cards = []
    end
  end

  class Player
    attr_accessor :deck, :hand

    def initialize(deck)
      get_hand
      @deck = deck
    end

    def hit
      hand.cards << deck.deal_card
    end

    def get_hand
      @hand ||= Hand.new()
    end

    def total
      hand.cards.reduce(0) do |total, card|
        if card.value.class == Fixnum
          total += card.value
        elsif total + 11 > 21
          total += 1
        elsif card.value
          total += 11
        end
      end
    end

    def keep_playing(u_total)
      while self.total < 21 && self.total < u_total
        self.hit
      end
    end
  end

  class Blackjack

    def play
      deck   = Deck.new
      user   = Player.new(deck)
      dealer = Player.new(deck)
      puts 'Welcome to Blackjack!'
      answer = 'hit'
      user.hit
      dealer.hit

      while user.total <= 21 && dealer.total <= 21 && answer == 'hit'
        puts "your hand is :"
        user.hand.cards.each do |h|
          puts "#{h.name.to_s} of #{h.suite.to_s} with a value of #{h.value.to_s}"
        end
        puts "your total is #{user.total}"
        puts "Would you like to keep this or get another card? Type hit or stay."
        answer = gets.chomp
        if answer == 'hit'
          user.hit
        else
          dealer.keep_playing(user.total)
        end
        if dealer.total < 21 && dealer.total < user.total
          dealer.hit
        end
      end

      if user.total > 21 || dealer.total > user.total
        puts "you lose, your total score was #{user.total} and the dealer's score was #{dealer.total}"
      elsif dealer.total > 21 || user.total > dealer.total
        puts "you win! The dealer went up to #{dealer.total} and you has #{user.total}"
      end
    end

  end

  Blackjack.new.play
