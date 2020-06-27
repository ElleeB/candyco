# README

Install RVM 
  * \curl -sSL https://get.rvm.io | bash
    [options here https://rvm.io/rvm/install]  

Install Ruby
---
* rvm install 2.6.3

Please navigate into the project folder and run:
---
* bundle install

* rails/rake db:create db:migrate db:seed

To launch:

* run rails s

* localhost:3000/reports

To run tests:
---
* rspec spec/models/order_spec.rb

* rspec spec/requests/api/data_api_request_spec.rb
