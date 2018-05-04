#Configuration and Workflow Notes

I just wanted to take some notes along the way as this workflow is full of caveats and pitfalls that have to be avoided in order.

##Testing
1. Make sure you have run `bundle install`
1. Start postgres using `brew services start postgresql`
1. Use ActiveRecords DSL and run `rake db:create` to create the databases in `app/config/databse.yml`
1. Create migrations if necessary using AR's DSL: `rake db:create_migration NAME=<_name here_>`
1. Run migrations using AR's DSL `rake db:migrate`.

##
1. Add seeds to seeds.rb and seed the database `rake db:seed`
