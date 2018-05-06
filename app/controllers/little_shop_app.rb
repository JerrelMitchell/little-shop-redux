class LittleShopApp < Sinatra::Base

  get '/items' do
    @all_items = Item.all_formatted
    erb :'items/index'
  end

  get '/item/:id' do
    @item = Item.find(params[:id])
    @item.price = @item.price / 100
    erb :'items/show'
  end

  get '/items/new' do
  end

  get ['/', '/merchants'] do
    @merchants = Merchant.all
    erb :"merchants/index"
  end

  get '/merchants/new' do
    erb :'merchants/create'
  end

  get '/merchants/:id' do
    @merchant = Merchant.find(params['id'])
    erb :"merchants/show"
  end

  get '/merchants/:id/edit' do
    @merchant = Merchant.find(params['id'])
    erb :"merchants/edit"
  end

  put '/merchants/:id' do
    merchant = Merchant.find(params['id'])
    merchant.update(params['merchant'])
    redirect '/merchants'
  end

  post '/merchants' do
    @merchants = Merchant.all
    new_id = (@merchants.max_by(&:id).id + 1)
    params[:merchant][:id] = new_id
    Merchant.create(params[:merchant])
    redirect '/merchants'
  end

  delete '/merchants/:id' do
    Merchant.destroy(params[:id])
    redirect '/merchants'
  end
end
