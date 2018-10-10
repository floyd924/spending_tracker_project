
require("pry")
require_relative("../models/transaction.rb")
require_relative("../models/merchant.rb")
require_relative("../models/category.rb")
require_relative("../models/budget.rb")

get("/merchants") do
  @budget1 = Budget.all
  @merchants = Merchant.all()
  erb(:"merchants/index")
end

get("/merchants/new") do
  @budget1 = Budget.all
  erb(:"merchants/new")
end

post("/merchants") do
  @budget1 = Budget.all
  @merchant = Merchant.new(params)
  @merchant.save
  erb(:"merchants/create")
end

get("/merchants/:id") do
  @budget1 = Budget.all
  id = params[:id].to_i
  @merchant = Merchant.find(id)
  @transactions = Transaction.find_by_merchant_id(id)
  erb(:"merchants/show")
end

get("/merchants/:id/edit") do
  @budget1 = Budget.all
  id = params[:id].to_i
  @merchant = Merchant.find(id)
  erb(:"merchants/edit")
end

post("/merchants/:id") do
  @budget1 = Budget.all
  @merchant = Merchant.new(params)
  @merchant.update()
  erb(:"merchants/update")
end




post("/merchants/:id/delete") do
  @budget1 = Budget.all
  id = params[:id].to_i
  Merchant.delete_with_id(id)
  erb(:"merchants/delete")
end
