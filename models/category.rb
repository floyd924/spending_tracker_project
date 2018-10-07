require_relative('../db/sql_runner.rb')

class Category

  attr_reader :id
  attr_accessor :name, :total_spend

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @total_spend = options['total_spend']= 0
    #set total spend to be 0 from beginnnig
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
    values = [@name]
    SqlRunner.run(sql, values)
  end

  def save()
    sql = "INSERT INTO
    categories(name)
    VALUES ($1)
    RETURNING id;"
    values = [@name]
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


end
