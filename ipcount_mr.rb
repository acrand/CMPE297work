get '/ipcount' do  
  
  map = "function() {
    emit(this.ip, {count: 1});
  };"
  
  reduce = "function(key, values) {
    
    var result = {count: 0};
    
    values.forEach(function(value) {
      
      result.count += value.count;
      
    });
    return result;
  };"
  
  @results = CloudIP.collection.map_reduce(map,reduce,{out: "ipcount_results"})
  
 
  print("Here is a count of the IP's that hit the site: #{@results.find().to_a}")
 
  
  @returnstr
end

=begin
get '/' do  
  
  #map = "function() {
   # emit(this.thedate, {ips: this['cloud_ips']});
  #};"
  
  map = "function() {
    emit(this.thedate, {count:1, CloudDateIP:this._id});
  };"
  
  reduce = "function(key, values) {
    
    var result = {count: 0, CloudIP: []};
    
    values.forEach(function(value) {
      
      result.count += value.count;
      
      result.CloudIP.push(value.CloudIP.ip);
    });
    return result;
  };"
  
  @results = CloudDate.collection.map_reduce(map,reduce,{out: "ipmr_results"})
  #@results = CloudDate.collection.map_reduce(map,reduce,{out: { inline: 1}})
  
  
 puts @results
 puts @results.find().to_a
end
=end