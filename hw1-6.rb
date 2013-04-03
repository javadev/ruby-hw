class Class
  def attr_accessor_with_history(attr_name)
    attr_name = attr_name.to_s # make sure it's a string
    attr_reader attr_name # create the attribute's getter
    attr_reader attr_name+"_history"
    
    class_eval %Q{
      def #{attr_name}=(value)
        @#{attr_name} = value
	      @#{attr_name}_history ||= [nil]
	      @#{attr_name}_history << value
      end
      }
  end
end

class Foo
  attr_accessor_with_history :bar
end

class Numeric
  @@currencies = {'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019, 'dollar' => 1.000}

  def method_missing(method_id)
    singular_currency = method_id.to_s.gsub( /s$/, '')
    if @@currencies.has_key?(singular_currency)
      self * @@currencies[singular_currency]
    else
      super
    end
  end
  
  def in(currency_id)
    singular_currency = currency_id.to_s.gsub( /s$/, '')
    if @@currencies.has_key?(singular_currency)
      self / @@currencies[singular_currency]
    else
      super
    end
  end
 
end

class String
  def palindrome?
    sub = self.downcase.gsub(/\W/i, '')
    revsub = self.downcase.reverse.gsub(/\W/i, '')
    sub == revsub
  end
end

module Enumerable
  def palindrome?
    self.zip == self.zip.reverse
  end
  def method_missing(method_id)
    false
  end
end