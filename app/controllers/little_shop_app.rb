class LittleShopApp < Sinatra::Base
    get ['/invoices', '/invoices/'] do
        @invoices = Invoice.all
        erb :"invoices/index"
    end

    get '/invoices/:id' do
        @invoice = Invoice.find(params['id'])
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
end

