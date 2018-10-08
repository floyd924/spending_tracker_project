require_relative( '../db/sql_runner' )

class Transaction

  attr_reader :id
  attr_accessor :item

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @item = options['item']
    @price = options['price']
    @merchant_id = options['merchant_id']
    @category_id = options['category_id']
    @date = options['date'].to_i #as a string, been told to stay away!
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
    SELECT * FROM transactions;"
    result_hashes = SqlRunner.run(sql)
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
    return transactions_array
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


end
