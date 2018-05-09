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

  get '/invoices-dashboard' do
    @status_percent = Invoice.status_percentages
    @max_price_invoice = Invoice.max_invoice_price
    @min_price_invoice = Invoice.min_invoice_price
    @max_quantity_invoice = Invoice.max_invoice_quantity
    @min_quantity_invoice = Invoice.min_invoice_quantity
    erb :invoices/dashboard
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

  get '/item/:id/edit' do
    @item = Item.find(params[:id])
    @merchant_names = Merchant.all.map(&:name)
    erb :"items/edit"
  end

  post '/items' do
    Item.add_item(params[:item])
    redirect '/items'
  end

  put '/item/:id' do
    Item.find(params[:id]).update_item(params[:item])
  end

  delete '/item/:id' do
    Item.destroy(params[:id].to_i)
    redirect '/items'
  end

  get '/items-dashboard' do
    @items_average_price = Item.average_item_price
    @total_items = Item.count
    @newest_item = Item.order("created_at DESC").limit(1).first
    @oldest_item = Item.order("created_at ASC").limit(1).first
    erb :"items/dashboard"
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
    Merchant.create(params[:merchant])
    redirect '/merchants'
  end

  delete '/merchants/:id' do
    Merchant.destroy(params[:id])
    redirect '/merchants'
  end
end
