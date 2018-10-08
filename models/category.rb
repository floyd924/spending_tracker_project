require_relative('../db/sql_runner.rb')

class Category

  attr_reader :id
  attr_accessor :name, :total_spend

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @total_spend = options['total_spend'] !=nil ? options['total_spend'] : 0
    # i have set total spend to be 0 from beginnnig
  end

  def self.delete_all()
    sql = "
    DELETE FROM categories;"
    SqlRunner.run(sql)
  end

  def self.delete(name)
    sql = "
    DELETE FROM categories
    WHERE name = $1;"
    values = [name]
    SqlRunner.run(sql, values)
  end

  def save()
    sql = "INSERT INTO
    categories(name, total_spend)
    VALUES ($1, $2)
    RETURNING id;"
    values = [@name, @total_spend]
    new_category = SqlRunner.run(sql, values)[0]
    @id = new_category['id'].to_i
  end

  def self.all()
    sql = "
    SELECT * FROM categories;"
    result_hashes = SqlRunner.run(sql)
    result_array = result_hashes.map { |e| Category.new(e)  }
    return result_array
  end

  def increase(amount_to_increase)
    @total_spend += amount_to_increase
    update
  end


  def decrease(amount_to_decrease)
    @total_spend -= amount_to_decrease
    update
  end


  def update()
    sql = "UPDATE categories
    SET (name, total_spend) = ($1, $2);"
    values = [@name, @total_spend]
    SqlRunner.run(sql, values)
  end




end
