require_relative("../models/budget.rb")
require_relative("../models/category")
require_relative("../models/merchant.rb")
require_relative("../models/transaction.rb")
require("pry")

# Budget.delete_all()
Category.delete_all()
Merchant.delete_all()
Transaction.delete_all()

# budget1 = Budget.new({"amount" => 500})
# budget1.save

# budget1.add(10)
# budget1.subtract(5)

category1 = Category.new({"name" => "Entertainment", "total_spend" => 0})
category1.save
# category1.increase(45)
# category1.decrease(121)
category2 = Category.new({"name" => "Clothes", "total_spend" => 0})
category2.save

category3 = Category.new({"name" => "Food", "total_spend" => 0})
category3.save

category4 = Category.new({"name" => "Alcohol", "total_spend" => 0})
category4.save

category5 = Category.new({"name" => "Music", "total_spend" => 0})
category5.save




merchant1 = Merchant.new({"name" => "Sainsburys"})
merchant1.save
# merchant1.increase(51)
# merchant1.decrease(22)
merchant2 = Merchant.new({"name" => "Red Dog Music", "total_spend" => 0})
merchant2.save
# Merchant.delete("Sainsburys")
# Merchant.all
# binding.pry

merchant3 = Merchant.new({"name" => "Tesco"})
merchant3.save

merchant4 = Merchant.new({"name" => "Argyll Bar"})
merchant4.save

merchant5 = Merchant.new({"name" => "Southsider"})
merchant5.save

merchant6 = Merchant.new({"name" => "Primark"})
merchant6.save

transaction1 = Transaction.new({
  "item" => "pancakes",
  "price" => 3,
  "merchant_id" => merchant1.id,
  "category_id" => category3.id,
  "date" => 1})

merchant1.add(3)
category3.add(3)
# merchant1.total_spend = merchant1.total_spend.to_i + 3
# merchant1.update
# binding.pry

transaction2 = Transaction.new({
  "item" => "guitar strings",
  "price" => 6,
  "merchant_id" => merchant2.id,
  "category_id" => category5.id,
  "date" => 4})
merchant2.add(6)
category5.add(6)

# merchant2.increase(6)

transaction3 = Transaction.new({
  "item" => "guitar case",
  "price" => 39,
  "merchant_id" => merchant2.id,
  "category_id" => category5.id,
  "date" => 5})
merchant2.add(39)
category5.add(39)

# merchant2.increase(39)

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


# binding.pry
# nil
#
# Transaction.price_with_id(109)
# binding.pry

transaction4 = Transaction.new({
  "item" => "pint",
  "price" => 4,
  "merchant_id" => merchant4.id,
  "category_id" => category4.id,
  "date" => 7})
merchant4.add(4)
category4.add(4)
transaction4.save

transaction5 = Transaction.new({
  "item" => "pint",
  "price" => 3,
  "merchant_id" => merchant5.id,
  "category_id" => category4.id,
  "date" => 7})
merchant5.add(3)
category4.add(3)
transaction5.save

transaction6 = Transaction.new({
  "item" => "burger",
  "price" => 7,
  "merchant_id" => merchant5.id,
  "category_id" => category3.id,
  "date" => 7})
merchant5.add(7)
category3.add(7)
transaction6.save

transaction7 = Transaction.new({
  "item" => "jeans",
  "price" => 12,
  "merchant_id" => merchant6.id,
  "category_id" => category2.id,
  "date" => 8})
merchant6.add(12)
category2.add(12)
transaction7.save

transaction8 = Transaction.new({
  "item" => "garlic bread",
  "price" => 1,
  "merchant_id" => merchant3.id,
  "category_id" => category3.id,
  "date" => 5})
merchant3.add(1)
category3.add(1)
transaction8.save
