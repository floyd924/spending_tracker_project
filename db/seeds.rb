require_relative("../models/budget.rb")
require_relative("../models/category")
require_relative("../models/merchant.rb")
require_relative("../models/transaction.rb")
require("pry")

Budget.delete_all()
Category.delete_all()
Merchant.delete_all()
Transaction.delete_all()

# budget1 = Budget.new({"amount" => 500})
# budget1.save

# budget1.add(10)
# budget1.subtract(5)

category1 = Category.new({"name" => "Entertainment", "total_spend" => 100})
category1.save
category1.increase(45)
category1.decrease(121)
category2 = Category.new({"name" => "Clothes", "total_spend" => 40})
category2.save





merchant1 = Merchant.new({"name" => "Sainsburys"})
merchant1.save
merchant1.increase(51)
merchant1.decrease(22)
merchant2 = Merchant.new({"name" => "Red Dog Music", "total_spend" => 77})
merchant2.save
# Merchant.delete("Sainsburys")
# Merchant.all
# binding.pry

transaction1 = Transaction.new({
  "item" => "pancakes",
  "price" => 3,
  "merchant_id" => merchant1.id,
  "category_id" => category1.id,
  "date" => 1})

transaction2 = Transaction.new({
  "item" => "guitar strings",
  "price" => 6,
  "merchant_id" => merchant2.id,
  "category_id" => category1.id,
  "date" => 4})

transaction3 = Transaction.new({
  "item" => "guitar case",
  "price" => 39,
  "merchant_id" => merchant2.id,
  "category_id" => category1.id,
  "date" => 5})

transaction1.save
transaction2.save
transaction3.save

# Category.find(59)
#
# Transaction.find_by_category_id(59)


# Transaction.all
# Transaction.count

# Transaction.span(2, 7)
# Transaction.find("guitar case")
# binding.pry
# nil
# transaction3.item = "guitar hardcase"
# transaction3.update

# Transaction.delete(57)
# Transaction.all
# Merchant.return_id("Red Dog Music")
# Category.return_id("Entertainment")
# binding.pry
# Transaction.merchant_name(merchant1.id)
# transaction1.merchant.name

# Transaction.merchant_name(transaction1.merchant_id)
# Transaction.category_name(transaction1.category_id)

# Category.increase_with_id(transaction1.category_id, 100)
# Category.exists("sainsburys")
binding.pry
nil

Transaction.price_with_id(109)
# binding.pry
