require_relative( '../db/sql_runner' )

class Budget

  attr_reader :id
  attr_accessor :amount


  def initialize(options)
    @id = options['id'].to_i if options['id']
    @amount = options['amount'] !=nil ? options['amount'] : 0
  end

  # def self.find_first()
  #   sql = "
  #   SELECT * FROM budgets;"
  #   result_hashes = SqlRunner.run(sql)
  #   result_array = result_hashes.map { |e| Budget.new(e)  }
  #   return result_array[0]
  # end

  def self.all()
    sql = "
    SELECT * FROM budgets;"
    result_hashes = SqlRunner.run(sql)
    result_array = result_hashes.map { |e| Budget.new(e)  }
    return result_array[0]
  end

  def save()
    sql = "INSERT INTO budgets(amount)
    VALUES ($1)
    RETURNING id;"
    values = [@amount]
    new_budget = SqlRunner.run(sql, values)[0]
    @id = new_budget['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM budgets;"
    SqlRunner.run(sql)
  end

  def self.find_by_id(id)
    sql = "
    SELECT * FROM budgets
    WHERE id = $1;"
    values = [id]
    b_hashes = SqlRunner.run(sql, values)
    b_array = b_hashes.map { |e| Budget.new(e)  }
    return b_array[0]
  end

  def update()
    sql = "UPDATE budgets
    SET amount = $1;"
    values = [@amount]
    SqlRunner.run(sql, values)
  end


  def add(amount_to_add)
    prev_amount = @amount.to_i
    next_amount = amount_to_add.to_i
    @amount = (prev_amount + next_amount)
    #prompt savings
    update
  end



  def subtract(amount_to_subtract)
    prev_amount = @amount.to_i
    next_amount = amount_to_subtract.to_i
    @amount = (prev_amount - next_amount)
    #prompt savings
    update
  end

end
