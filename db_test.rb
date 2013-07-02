require 'rubygems'
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
  :password => 'xxxxxxxx',
  :schema_search_path => 'protected'
)

class Holiday < ActiveRecord::Base
end

holidays = Holiday.all
puts holidays.inspect
