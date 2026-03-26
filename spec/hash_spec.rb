# frozen_string_literal: true

require_relative '../credit_card'
require 'minitest/autorun'
require 'minitest/rg'

# Feel free to replace the contents of cards with data from your own yaml file
card_details = [
  { num: '4916603231464963',
    exp: 'Mar-30-2020',
    name: 'Soumya Ray',
    net: 'Visa' },
  { num: '6011580789725897',
    exp: 'Sep-30-2020',
    name: 'Nick Danks',
    net: 'Visa' },
  { num: '5423661657234057',
    exp: 'Feb-30-2020',
    name: 'Lee Chen',
    net: 'Mastercard' }
]

cards = card_details.map do |c|
  CreditCard.new(c[:num], c[:exp], c[:name], c[:net])
end

describe 'Test hashing requirements' do
  describe 'Check hashes are consistently produced' do
    # TODO: Check that each card produces the same hash if hashed repeatedly
    it 'works on all cards' do
      cards.each do |card|
        _(card.hash).must_equal card.hash
      end
    end

    # Check that cards with identical information produce identical hashes
    it 'works on cards with identical information' do
      card_copy = CreditCard.new(cards.first.number, cards.first.expiration_date,
                                 cards.first.owner, cards.first.credit_network)

      _(card_copy.hash).must_equal cards.first.hash
    end
  end

  describe 'Check for unique hashes' do
    # TODO: Check that each card produces a different hash than other cards
    it 'works on all cards' do
      hashes = cards.map(&:hash) # &:hash is shorthand for { |card| card.hash }
      _(hashes.uniq.length).must_equal cards.length
    end

    # Check that changing card information changes the hash
    it 'works when one card field changes' do
      original_card = cards.first
      updated_card = CreditCard.new(original_card.number, original_card.expiration_date,
                                    'Different Owner', original_card.credit_network)

      _(updated_card.hash).wont_equal original_card.hash
    end
  end
end
