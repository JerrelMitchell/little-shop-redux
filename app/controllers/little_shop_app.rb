
class LittleShopApp < Sinatra::Base
  get '/items' do
    erb :items, locals: { all_items: Item.all }
  end
end
