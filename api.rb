require 'rubygems'
require 'bundler'
Bundler.require

require 'sinatra/json'


if ENV['MONGOLAB_URI']
  mongo = Mongo::MongoClient.from_uri(ENV['MONGOLAB_URI']).db()
else
  mongo = Mongo::MongoClient.new().db('crm')
end

customers = mongo.collection("customers")

get '/' do
  "CRM Sinatra"
end

get '/api/v1/customers.json' do
  customers = customers.find().map do |c|
    {
      id: c["_id"].to_s,
      name: c["name"],
      phone: c["phone"]
    }
  end
  json customers
end
