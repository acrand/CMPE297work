require 'sinatra'
require 'mongo'
require 'mongoid'

=begin
Mongoid.configure do |config|
    # Mongoid
  name = "mongocloud-db"
  host = "localhost"
  config.master = Mongo::Connection.new.db(name)
end
=end

mongoid_conf = Mongoid.load!("mongoid.yml")

# This is a CloudDate
class CloudDate
 include Mongoid::Document

 field :thedate, type: Date
 
 has_many :cloudips,  class_name: 'CloudIP', inverse_of: :clouddate
 
 validates_uniqueness_of :thedate
 
end

class CloudIP
 include Mongoid::Document
 
 field :ip, type: String
 
 belongs_to :clouddate, class_name: 'CloudDate', index: true
 
end
