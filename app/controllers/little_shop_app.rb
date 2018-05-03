class LittleShopApp < Sinatra::Base
  get ['/', '/merchants', '/merchants/'] do
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

  delete '/merchants/:id/delete' do
    merchant = Merchant.find(params['id'])

    Merchant.delete(merchant)

    redirect '/merchants'
  end

  post '/merchants' do
    new_id = Merchant.last.id + 1
    params['merchant'] = new_id
    merchant = Merchant.create(params['merchant'])

    redirect "/merchants/#{merchant.id}"
  end

  post '/merchants/:id' do
    merchant = Merchant.find(params['id'])
    merchant.update(params['merchant'])
    merchant.save
    redirect "/merchants/#{merchant.id}"
  end
end
