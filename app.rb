require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/transactions_controller.rb')
require_relative('controllers/categories_controller.rb')
require_relative('controllers/merchants_controller')
also_reload("./models/*")


@budget1 = Budget.new({"amount" => 0})
@budget1.save

set :budget1, @budget1




get '/' do
  redirect to("/transactions")
end
