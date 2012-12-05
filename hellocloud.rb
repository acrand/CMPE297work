require "bundler/setup"
require 'rubygems'
require 'sinatra'
#require 'socket'

require './mongocloud'
  
get '/' do
  
  print("Hello Cloud ") 
 
  #IPSocket.getaddress(Socket.gethostname).gsub!(/.\d{1,3}$/, '.255')
 
  thetime = Time.new
  print("Currnt time is :#{thetime}")
  
  tday = "#{thetime.to_date}::#{thetime.hour}::#{thetime.min}"
  
  puts tday
  
  @date = CloudDate.where(thedate: tday).first
  
  if(@date == nil) then
    @date = CloudDate.new
  end
  
  @date.thedate =tday
  
  @cip  = CloudIP.new
  @cip.ip = request.ip
  
  @date.cloudips << @cip
  
  @date.save
  
  CloudDate.all.each do |cdate|
   print( "#{cdate.thedate} - #{cdate.cloudips.count}" )
  end
  
  #'made it here'
  @returnstr   
end
