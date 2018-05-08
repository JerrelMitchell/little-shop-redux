class LittleShopApp < Sinatra::Base

  # Invoice Paths

  get ['/invoices', '/invoices/'] do
    @invoices = Invoice.all
    erb :"invoices/index"
  end

  get '/invoices/:id' do
    @invoice = Invoice.find(params['id'])
    # require 'pry';binding.pry
    erb :"invoices/show"
  end

  get '/invoices/:id/edit' do
    @invoice = Invoice.find(params['id'])
    erb :"invoices/edit"
  end

  delete '/invoices/:id/delete' do
    invoice = Invoice.find(params['id'])

    Invoice.delete(invoice)

    redirect '/invoices'
  end

  post '/invoices/:id' do
    invoice = Invoice.find(params['id'])
    invoice.update(params['invoice'])
    invoice.save
    redirect "/invoices/#{invoice.id}"
  end

  # Item Paths

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
    @merchant_names = Merchant.all.map(&:name)
    erb :"items/new"
  end

  post '/items' do
    Item.add_item(params[:item])
    redirect '/items'
  end

  # Merchant Paths

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
