
require("pry")
# require_relative("../models/budget.rb")
require_relative("../models/transaction.rb")
require_relative("../models/merchant.rb")
require_relative("../models/category.rb")
require_relative("../app.rb")

#index route

get("/transactions") do
  @budget1 = Budget.all
  @transactions = Transaction.all()
  @total = 0
  for transaction in @transactions
    prix = transaction.price.to_i
    @total += prix
  end
  erb(:index)
end









get("/transactions/new") do
  @budget1 = Budget.all
  @merchants = Merchant.all()
  @categories = Category.all()
  erb(:"transactions/new")
end

get("/transactions/:id/edit") do

  id = params[:id].to_i
  @budget1 = Budget.all
  @transaction = Transaction.find_by_id(id)
  @merchants = Merchant.all
  @categories = Category.all
  erb(:"transactions/edit")
end

post '/transactions/a/b/filter' do
  a = params[:a]
  b = params[:b]
  @budget1 = Budget.all
  @transactions = Transaction.filter(a, b)
  @total = 0
  for transaction in @transactions
    prix = transaction.price.to_i
    @total += prix
  end
  erb(:index)
end

post("/transactions/:id") do
  @budget1 = Budget.all
  @transaction = Transaction.new(params)
  @transaction.update()
  erb(:"transactions/update")
end






get("/transactions/:id") do
  @budget1 = Budget.all
  id = params[:id].to_i()
  @transaction = Transaction.find_by_id(id)
  erb(:"transactions/show")
end

post("/transactions/:id/delete") do
  id = params[:id].to_i()
  prix = Transaction.price_with_id(id)
  @budget1 = Budget.all
  @budget1.add(prix)
  @transaction = Transaction.find_by_id(id)
  cat_id = @transaction.category_id
  cat = Category.find(cat_id)
  cat.subtract(prix)
  mer_id = @transaction.merchant_id
  mer = Merchant.find(mer_id)
  mer.subtract(prix)
  Transaction.delete(id)

  erb(:"transactions/delete")
end

# get("/transactions/:item") do
#   item = params[:item].downcase
#   @transaction = Transaction.find(item)
#   erb(:show)
# end

post("/transactions") do
  amount = params[:price].to_i
  @budget1 = Budget.all

  @transaction = Transaction.new(params)
  @transaction.save()
  @budget1.subtract(amount)

  category = Category.find(@transaction.category_id)
  category.add(amount)
  merchant = Merchant.find(@transaction.merchant_id)
  merchant.add(amount)

  if @budget1.amount >= 20
    erb(:"transactions/create")
  elsif @budget1.amount < 0
    erb(:"transactions/warning_0")
  else
    erb(:"transactions/warning_20")
  end
end




post("/transactions/:id/delete") do
  @budget1 = Budget.all
  id = params[:id].to_i()
  @transaction = Transaction.find_by_id(id)
  @transaction.delete()
  erb(:"transactions/delete")
end

get("/transactions/:id") do
  @budget1 = Budget.all
  id = params[:id].to_i()
  @transaction = Transaction.find_by_id(id)
  erb(:"transactions/show")
end
