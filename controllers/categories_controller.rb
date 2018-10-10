
require("pry")
require_relative("../models/transaction.rb")
require_relative("../models/merchant.rb")
require_relative("../models/category.rb")
require_relative("../models/budget.rb")

get("/categories") do
  @budget1 = Budget.all
  @categories = Category.all()
  erb(:"categories/index")
end

post("/categories") do
  @budget1 = Budget.all
  @category = Category.new(params)
  @category.save
  erb(:"categories/create")
end

get("/categories/new") do
  @budget1 = Budget.all
  erb(:"categories/new")
end

get("/categories/:id") do
  @budget1 = Budget.all
  bob = params[:id].to_i
  @category = Category.find(bob)
  @transactions = Transaction.find_by_category_id(bob)
  erb(:"categories/show")
end

get("/categories/:id/edit") do
  @budget1 = Budget.all
  id = params[:id].to_i
  @category = Category.find(id)
  erb(:"categories/edit")
end

post("/categories/:id") do
  @budget1 = Budget.all
  # "hello"
  @category = Category.new(params)
  @category.update()
  erb(:"categories/update")
end

post("/categories/:id/delete") do
  @budget1 = Budget.all
  id = params[:id].to_i
  Category.delete_with_id(id)
  erb(:"categories/delete")
end
