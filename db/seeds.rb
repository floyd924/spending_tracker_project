require_relative("../models/budget.rb")
require_relative("../models/category")
require_relative("../models/merchant.rb")
require_relative("../models/transaction.rb")
require("pry")

Budget.delete_all()

budget1 = Budget.new({"amount" => 4})
budget1.save
# budget1.add(10)
# budget1.subtract(5)

binding.pry
nil
