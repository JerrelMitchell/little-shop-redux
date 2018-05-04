class LittleShopApp < Sinatra::Base
  get '/items' do
    @all_items = Item.all
    # require 'pry';binding.pry
    erb :items
  end
end
