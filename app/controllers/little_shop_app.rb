class LittleShopApp < Sinatra::Base
  get ['/', '/merchants'] do
    @merchants = Merchant.all

    erb :"merchant/index"
  end
end
