require_relative( '../db/sql_runner' )

class Budget

  attr_reader :id
  attr_accessor :amount


  def initialize(options)
    @id = options['id'].to_i if options['id']
    @amount = options['amount'] !=nil ? options['amount'] : 0
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

  def update()
    sql = "UPDATE budgets
    SET amount = $1;"
    values = [@amount]
    SqlRunner.run(sql, values)
  end


  def add(amount_to_add)
    @amount += amount_to_add
    #prompt savings
    update
  end

  def subtract(amount_to_subtract)
    @amount -= amount_to_subtract
    # budget.update
    update
  end

end
