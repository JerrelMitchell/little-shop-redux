class LittleShopApp < Sinatra::Base
  get '/items' do
    @all_items = Item.all_formatted
    erb :'items/index'
  end

  get '/item/:id' do
    @item = Item.find(params[:id])
    erb :'items/show'
  end
end
