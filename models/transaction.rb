#require sqlrunner

class Transaction

#attr_reader
#attr_writer

  def initialize
    @id = options['id'].to_i if options['id']
    @item = options['item']
    @merchant_name = options['merchant_name']
    @category_name = options['category_name']
    @date = options['date'].to_i #as a string, been told to stay away!
  end

  def self.delete_all
    sql = "
    DELETE FROM transactions;"
    SqlRunner.run(sql)
  end

  def delf.delete(id)
    sql = "
    DELETE FROM transactions
    WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def save()
    sql = "
    INSERT INTO transactions(item, merchant_name, category_name, date)
    VALUES ($1, $2, $3, $4)
    RETURNING id;"
    values = [@item, @merchant_name, @category_name, @date]
    new_transaction = SqlRunner.run(sql, values)[0]
    @id = transaction['id'].to_i
  end
end
