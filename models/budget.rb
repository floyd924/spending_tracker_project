#require relative sql runner

class Budget

#attr reader
#attr writer

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @amount = amount
    #input amount of 0 when you start the app
  end

  def self.add(amount_to_add)
    @amount += amount_to_add
    #prompt savings
  end

  def self.subtract(amount_to_subtract)
    @amount -= amount_to_subtract
  end

end
