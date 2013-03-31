require 'rubygems'

# This is allowing us to do the `pluralize` calls below
require 'active_support/inflector'

module Currency
  CONVERSION_TABLE = { dollars: { dollars: 1, euros: 0.75 }, euros: { dollars: 1.3333334, euros: 1 } }.freeze
  attr_accessor :currency

  def method_missing(method_name, *args, &block)
    # standardize on pluralized currency names internally so both singular
    # and plural methods are handled
    method_name = method_name.to_s.pluralize.to_sym

    # Use the "from" keys in the conversion table to verify this is a valid 
    # source currency
    if CONVERSION_TABLE.key?(method_name)
      @currency = method_name
      self # return self so a call to `1.dollar` returns `1` and not `:dollars`
    else
      super
    end
  end

  # Convert `self` from type of `@currency` to type of `destination_currency`, mark the result with
  # the appropriate currency type, and return. Example:
  def to(destination_currency)
    # Again, standardize on plural currency names internally
    destination_currency = destination_currency.to_s.pluralize.to_sym

    # Do some sanity checking
    raise UnspecifiedSourceCurrency unless defined?(@currency)
    raise UnsupportedDestinationCurrency unless CONVERSION_TABLE.key?(destination_currency)

    # Do the actual conversion, and round for sanity, though a better
    # option would be to use BigDecimal which is more suited to handling money
    result = (self * CONVERSION_TABLE[@currency][destination_currency]).round(2)

    # note that this is setting @currency through the accessor that
    # was created by calling `attr_accessor :currency` above
    result.currency = destination_currency
    result
  end
end

class Numeric
  # Take all the functionality from Currency and mix it into Numeric
  # 
  # Normally this would help us encapsulate, but right now it's just making
  # for cleaner reading. My original example contained more encapsulation
  # that avoided littering the Numeric clas, but it's harder for a beginner
  # to understand. For now, just start here and you will learn more later.
  include Currency
end
