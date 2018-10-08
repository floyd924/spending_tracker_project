require_relative("../db/sql_runner.rb")

class Merchant

  attr_reader :id
  attr_accessor :name, :total_spend
  
  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
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


end
