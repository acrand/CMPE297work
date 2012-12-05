#require 'rubygems'
#gem 'mongoid' , '=2.5.1'
require 'mongoid'
require 'mongo'

#Configure MongoDB block

configure do
  Mongoid.configure do |config|
    # Mongoid
    name = "mongocloud-db"
    host = "localhost"
    config.master = Mongo::Connection.new.db(name)
  end
 end


helpers do
  
  def print(text)
         
      puts text
      if(@returnstr == nil) then
        @returnstr =  String.new
        @returnstr = "#{text} <br/>" 
      else   
        @returnstr = "#{@returnstr} #{text} <br/>"
      end
  end  

end  
#mongoid_conf = Mongoid.load!("mongoid.yml")

# This is a CloudDate
class CloudDate
 include Mongoid::Document
 include Mongoid::Timestamps
 
 #counter_cache :name => 'ips', :field => 'ipcount'
 
 #field :thedate, type: Date
 field :thedate, type: String # need to be more grandular
 
 has_many :cloudips,  class_name: 'CloudIP', inverse_of: :clouddate
 
 validates_uniqueness_of :thedate
  
end

class CloudIP
 include Mongoid::Document
 
 field :ip, type: String
 
 belongs_to :clouddate, class_name: 'CloudDate', index: true
 
end
