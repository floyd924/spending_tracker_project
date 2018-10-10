require_relative("../db/sql_runner.rb")

class Merchant

  attr_reader :id
  attr_accessor :name, :total_spend

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"].capitalize
    @total_spend = options["total_spend"] !=nil ? options["total_spend"] : 0
  end

  def save()
    sql = "INSERT INTO merchants
    (name, total_spend)
    VALUES ($1, $2)
    RETURNING id;
    "
    values = [@name, @total_spend]
    new_merchant = SqlRunner.run(sql, values)[0]
    @id = new_merchant['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM merchants;"
    SqlRunner.run(sql)
  end

  def self.delete(name)
    sql = "DELETE FROM merchants
    WHERE name = $1;"
    values = [name]
    SqlRunner.run(sql, values)
  end

  def self.delete_with_id(id)
    sql = "DELETE FROM merchants
    WHERE id = $1;"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE merchants
    SET (name, total_spend) = ($1, $2)
    "
    values = [@name, @total_spend]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM merchants;"
    results_hash = SqlRunner.run(sql)
    results_objects = results_hash.map { |e| Merchant.new(e) }
    return results_objects
  end


  def increase(amount)
    @total_spend += amount
    update
  end

  def decrease(amount)
    @total_spend -= amount
    update
  end

  def add(amount_to_add)
    prev_amount = @total_spend.to_i
    next_amount = amount_to_add.to_i
    @total_spend = (prev_amount + next_amount)
    #prompt savings
    update
  end

  def subtract(amount_to_subtract)
    prev_amount = @total_spend.to_i
    next_amount = amount_to_subtract.to_i
    @total_spend = (prev_amount - next_amount)
    #prompt savings
    update
  end
  
  def self.return_id(name)
    name.capitalize!
    sql = "
    SELECT * FROM merchants
    WHERE name = $1;"
    values = [name]
    merchant_hash = SqlRunner.run(sql, values)
    merchant_object = merchant_hash.map { |e| Merchant.new(e)  }
    return merchant_object[0].id
  end

  def self.find(id)
    sql = "
    SELECT * FROM merchants
    WHERE id = $1;"
    values = [id]
    m_hashes = SqlRunner.run(sql, values)
    m_array = m_hashes.map { |e| Merchant.new(e)  }
    return m_array[0]
  end


end
