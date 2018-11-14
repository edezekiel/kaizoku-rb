require 'bundler'
Bundler.require
require 'nokogiri'
require 'pastel'
require 'open-uri'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'

ActiveRecord::Base.logger = nil
