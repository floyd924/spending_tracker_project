require_relative("../models/budget.rb")
require_relative("../models/category")
require_relative("../models/merchant.rb")
require_relative("../models/transaction.rb")
require("pry")

Budget.delete_all()
Category.delete_all()
Merchant.delete_all()
Transaction.delete_all()

budget1 = Budget.new({"amount" => 4.79})
budget1.save
# budget1.add(10)
# budget1.subtract(5)

category1 = Category.new({"name" => "Entertainment", "total_spend" => 100.10})
category1.save
category1.increase(45.30)
category1.decrease(120.67)
category2 = Category.new({"name" => "Clothes", "total_spend" => 40})
category2.save
# Category.delete("Clothes")
# Category.all


merchant1 = Merchant.new({"name" => "Sainsburys"})
merchant1.save
merchant1.increase(45.23)
merchant1.decrease(22.66)
merchant2 = Merchant.new({"name" => "Red Dog Music", "total_spend" => 77.99})
merchant2.save
# Merchant.delete("Sainsburys")
Merchant.all

transaction1 = Transaction.new({
  "item" => "pancakes",
  "price" => 3.40,
  "merchant_id" => merchant1.id,
  "category_id" => category1.id,
  "date" => 1})

transaction2 = Transaction.new({
  "item" => "guitar strings",
  "price" => 6.99,
  "merchant_id" => merchant2.id,
  "category_id" => category1.id,
  "date" => 4})

transaction3 = Transaction.new({
  "item" => "guitar case",
  "price" => 39.70,
  "merchant_id" => merchant2.id,
  "category_id" => category1.id,
  "date" => 5})

transaction1.save
transaction2.save
transaction3.save

# Transaction.all
# Transaction.count

# Transaction.span(2, 7)
# Transaction.find("guitar case")
# transaction3.item = "guitar hardcase"
# transaction3.update

# Transaction.delete(57)
# Transaction.all

binding.pry
nil
