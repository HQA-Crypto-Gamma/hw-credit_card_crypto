# frozen_string_literal: true

require_relative 'luhn_validator'
require 'json'
require 'digest'
# This class represents a credit card with its methods to serialize, deserialize, and hash the card information.
class CreditCard
  # TODO: mixin the LuhnValidator using an 'include' statement
  include LuhnValidator

  # instance variables with automatic getter/setter methods
  attr_accessor :number, :expiration_date, :owner, :credit_network

  def initialize(number, expiration_date, owner, credit_network)
    # TODO: initialize the instance variables listed above
    @number = number
    @expiration_date = expiration_date
    @owner = owner
    @credit_network = credit_network
  end

  # returns json string
  def to_json(options = {})
    {
      number: @number,
      expiration_date: @expiration_date,
      owner: @owner,
      credit_network: @credit_network
    }.to_json(options)
  end

  # returns all card information as single string
  def to_s
    to_json
  end

  # return a new CreditCard object given a serialized (JSON) representation
  def self.from_s(card_s)
    # TODO: deserializing a CreditCard object
    data = JSON.parse(card_s)
    CreditCard.new(
      data['number'],
      data['expiration_date'],
      data['owner'],
      data['credit_network']
    )
  end

  # return a cryptographically secure hash
  def hash
    # TODO: implement this method
    #   - Use sha256 to create a cryptographically secure hash.
    #   - Credit cards with identical information should produce the same hash
    Digest::SHA256.hexdigest("#{number}|#{expiration_date}|#{owner}|#{credit_network}")
  end
end
