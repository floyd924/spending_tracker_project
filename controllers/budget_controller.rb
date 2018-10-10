
require("pry")
require_relative("../models/transaction.rb")
require_relative("../models/merchant.rb")
require_relative("../models/category.rb")
require_relative("../models/budget.rb")


get '/budgets' do
  @budget1 = Budget.all
  "Hello World"
end

# get("/budgets/budget1/edit") do
#   "hello world"
#   # erb(:"budgets/edit")
# end

post("/budgets") do
  @budget1 = Budget.all
  "hello world"
  # amount = params(amount).to_i
  # @budget1.add(amount)
  # erb(:"budgets/update")
end
