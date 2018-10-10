require_relative('../db/sql_runner.rb')

class Category

  attr_reader :id
  attr_accessor :name, :total_spend

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name'].capitalize
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

  def self.delete_with_id(id)
    sql = "
    DELETE FROM categories
    WHERE id = $1;"
    values = [id]
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



  def self.return_id(name)
    name.capitalize!
    sql = "
    SELECT * FROM categories
    WHERE name = $1;"
    values = [name]
    category_hash = SqlRunner.run(sql, values)
    category_object = category_hash.map { |e| Category.new(e)  }
    return category_object[0].id
  end

  def self.increase_with_id(id, amount)
    a = id.to_i
    sql = "SELECT * FROM categories
    WHERE id = $1;"
    values = [a]
    category_hash = SqlRunner.run(sql, values)
    # binding.pry
    array = category_hash.map { |e| Category.new(e)  }
    object = array[0]
    # binding.pry
    c = object.total_spend.to_i
    c += amount
    # binding.pry

    object.update
  end

  def self.exists(name_to_check)
    sql = "SELECT * FROM categories
    WHERE name = $1;"
    values = [name_to_check.capitalize]
    result = SqlRunner.run(sql, values)

    array = result.map { |e| Category.new(e) }
    binding.pry
  end

  def self.find(id)
    sql = "
    SELECT * FROM categories
    WHERE id = $1;"
    values = [id]
    cat_hashes = SqlRunner.run(sql, values)
    cat_array = cat_hashes.map { |e| Category.new(e)  }
    return cat_array[0]
  end




end
