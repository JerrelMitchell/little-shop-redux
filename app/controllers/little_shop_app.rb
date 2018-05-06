class LittleShopApp < Sinatra::Base
    get '/invoices' do
        @invoices = Invoice.all
        erb :invoices
    end

   
    get '/invoices/:id' do
        @invoice = Invoice.find(params['id'])
        erb :"merchants/show"
    end
end