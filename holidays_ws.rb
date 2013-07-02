require 'rubygems'
require 'sinatra'
require 'active_record'
require 'date'

# 134.174.91.187 is read-only hot standby
ActiveRecord::Base.establish_connection(
  :adapter => 'postgresql',
  :host => '134.174.91.187',
  :port => '5432',
  :database => 'department',
  :encoding => 'unicode',
  :username => 'xxxxxxxx',
  :password => '********',
  :schema_search_path => 'protected'
)

class Holiday < ActiveRecord::Base
end

get '/' do
  "Try http://svcs.bwhanesthesia.org/holidays/yyyymmdd"
end

# Show all holidays
get '/holidays' do
  holidays = Holiday.find(:all, :order => :holiday_date)
  out = '<pre>'
  holidays.each { |h| out += "#{h.id}\t#{h.holiday_date}\t#{h.holiday}\n" }
  out += '</pre>'
end

# Is given date a holiday?
get '/holidays/:yyyymmdd' do
  holiday = Holiday.find(:all, :conditions => [ "holiday_date = ?", Date.parse(params[:yyyymmdd]) ] )
  result = holiday[0].nil? ? "false" : "true"
end
