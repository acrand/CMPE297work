require 'rubygems'
require 'sinatra'
#require 'socket'

require './mongocloud'

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
  
  
get '/' do
  
  print("Hello Cloud ") 
 
  #IPSocket.getaddress(Socket.gethostname).gsub!(/.\d{1,3}$/, '.255')
 
  tday = Time.now.to_date
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
