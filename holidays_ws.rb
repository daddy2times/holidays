require 'rubygems'
require 'sinatra'
require 'active_record'
require 'date'

ActiveRecord::Base.establish_connection(
  :adapter => 'postgresql',
  :host => 'localhost',
  :port => '5432',
  :database => 'department',
  :encoding => 'unicode',
  :username => '********',
  :password => '********',
  :schema_search_path => 'protected'
)

class Holiday < ActiveRecord::Base
end

get '/' do
  "Try /holidays or /holidays/yyyymmdd"
end

# Show all holidays
get '/holidays' do
  holidays = Holiday.order(:holiday_date)
  out = '<pre>'
  holidays.each { |h| out += "#{h.id}\t#{h.holiday_date}\t#{h.holiday}\n" }
  out += '</pre>'
end

# Is given date a holiday?
get '/holidays/:yyyymmdd' do
  holiday = Holiday.where( [ "holiday_date = ?", Date.parse(params[:yyyymmdd]) ] )
  result = holiday[0].nil? ? "false" : "true"
end
