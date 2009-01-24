# Helper borrowed from can_search
# and heavily modified for T::U usage
require 'rubygems'

require 'context'

dir = File.dirname(__FILE__)
env = "#{dir}/../../../../config/environment.rb"
$:.unshift "#{dir}/../lib"

if File.exist?(env)
  require env
else
  gem 'activesupport'
  gem 'activerecord'
  
  require 'active_support'
  require 'active_support/test_case'
  
  require 'active_record'
  ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database => ":memory:"
  require 'foundry'
end

Time.zone = "UTC"

module FoundryHelper
  class Record < ActiveRecord::Base
    set_table_name 'foundry_records'

    def self.create_table
      connection.create_table table_name, :force => true do |t|
        t.string   :title
        t.datetime :created_at
      end
    end

    def self.drop_table
      connection.drop_table table_name
    end

    def self.seed_data(now = Time.now.utc)
      transaction do
        create :title => 'default', :created_at => now - 5.minutes
      end
    end
  end

  Record.create_table
end
