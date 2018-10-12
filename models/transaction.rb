require_relative( '../db/sql_runner' )
require_relative('./merchant.rb')
require_relative('./category.rb')

class Transaction

  attr_reader :id, :category_id, :merchant_id
  attr_accessor :item, :price, :date

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @item = options['item']
    @price = options['price']
    @merchant_id = options['merchant_id'].to_i
    @category_id = options['category_id'].to_i
    # @date = options["date"] !=nil ? options["total_spend"] : DateTime.now
    @date = options['date'].to_i #as a string, been told to stay away!
  end



  def merchant()
    sql = "SELECT * FROM merchants
    WHERE id = $1;"
    values = [@merchant_id]
    results = SqlRunner.run(sql, values)
    results_array = results.map { |e| Merchant.new(e)  }
    object = results_array[0]
    return object
  end


  def category()
    sql = "SELECT * FROM categories
    WHERE id = $1;"
    values = [@category_id]
    results = SqlRunner.run(sql, values)
    results_array = results.map {|e| Category.new(e)}
    object = results_array[0]
    return object
  end



  def self.delete_all
    sql = "
    DELETE FROM transactions;"
    SqlRunner.run(sql)
  end

  def self.delete(id)
    sql = "
    DELETE FROM transactions
    WHERE id = $1;"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def save()
    sql = "
    INSERT INTO transactions(item, price, merchant_id, category_id, date)
    VALUES ($1, $2, $3, $4, $5)
    RETURNING id;"
    values = [@item, @price, @merchant_id, @category_id, @date]
    new_transaction = SqlRunner.run(sql, values)[0]
    @id = new_transaction['id'].to_i
    #@category.total_spend increase
    #@budget.total decrease
  end

  def update()
    sql = "UPDATE transactions
    SET (item, price, merchant_id, category_id, date) = ($1, $2, $3, $4, $5)
    WHERE id = $6"
    values = [@item, @price, @merchant_id, @category_id, @date, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "
    SELECT * FROM transactions
    ORDER BY date DESC;"
    result_hashes = SqlRunner.run(sql)
    result_array = result_hashes.map { |e| Transaction.new(e)  }
    return result_array
  end

  def self.filter(a, b)
    sql = "
    SELECT * FROM transactions
    WHERE date BETWEEN $1 AND $2
    ORDER BY date DESC;"
    values = [a, b]
    result_hashes = SqlRunner.run(sql, values)
    result_array = result_hashes.map { |e| Transaction.new(e)  }
    return result_array
  end

  def self.find(item)
    sql = "
    SELECT * FROM transactions
    WHERE item = $1;"
    values = [item]
    transactions_hashes = SqlRunner.run(sql, values)
    transactions_array = transactions_hashes.map { |e| Transaction.new(e)  }
    return transactions_array[0]
  end

  def self.find_by_id(id)
    sql = "
    SELECT * FROM transactions
    WHERE id = $1;"
    values = [id]
    transactions_hashes = SqlRunner.run(sql, values)
    transactions_array = transactions_hashes.map { |e| Transaction.new(e)  }
    return transactions_array[0]
  end

  def self.span(from, to)
    sql = "SELECT * FROM transactions
    WHERE date BETWEEN $1 AND $2;"
    values = [from.to_i, to.to_i]
    #IS THIS LINE CORRECT OR WRONG?!?!?!
    answer_rows = SqlRunner.run(sql, values)
    answer_objects = answer_rows.map { |e| Transaction.new(e)  }
    return answer_objects
  end

  def self.count()
    sql = "
    SELECT * FROM transactions;"
    result_hashes = SqlRunner.run(sql)
    result_array = result_hashes.map { |e| Transaction.new(e)  }
    rows = result_array.count
    return rows
  end

  def self.merchant_name(merchant_id)
    input = merchant_id.to_i
    sql = "SELECT * FROM merchants
    WHERE id = $1;"
    values = [input]
    merchant_hash = SqlRunner.run(sql, values)
    merchant_object = merchant_hash.map { |e| Merchant.new(e)  }
    return merchant_object[0].name
  end


  def self.category_name(category_id)
    input = category_id.to_i
    sql = "SELECT * FROM categories
    WHERE id = $1;"
    values = [input]
    category_hash = SqlRunner.run(sql, values)
    category_object = category_hash.map { |e| Category.new(e)  }
    return category_object[0].name
  end

  def self.find_by_merchant_id(id)
    sql = "SELECT * FROM transactions
    WHERE merchant_id = $1;"
    values = [id]
    results = SqlRunner.run(sql, values)
    result_array = results.map { |e| Transaction.new(e) }
    return result_array
  end

  def self.find_by_category_id(id)
    sql = "SELECT * FROM transactions
    WHERE category_id = $1;"
    values = [id]
    results = SqlRunner.run(sql, values)
    result_array = results.map { |e| Transaction.new(e) }
    return result_array
  end

  def self.price_with_id(id)
    sql = "SELECT * FROM transactions
    WHERE id = $1;"
    values = [id]
    results = SqlRunner.run(sql, values)
    result_array = results.map { |e| Transaction.new(e) }
    return result_array[0].price.to_i
  end



end
