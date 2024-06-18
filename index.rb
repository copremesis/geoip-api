require 'sinatra'
require 'json'
require 'yaml'
require 'csv'
require 'sinatra/cross_origin'
require 'sinatra/reloader'
require 'maxmind/db'
set :bind, '0.0.0.0'
load './cors-enable.rb'
load './log-files.rb' 

GEODB = MaxMind::DB.new('MaxMind/GeoLite2-City.mmdb', mode: MaxMind::DB::MODE_MEMORY)

#load from a DB perhaps
#sqlite3

GEO_MAP_ROOT = '/Users/rob/Desktop/code/geo-map'
GEO_API_ROOT = '/Users/rob/Desktop/code/geoip-api'
$current = LOG_FILES['ufw.log.1.gz'][:source]

get '/logs' do
  LOG_FILES.to_yaml
end

#pick a file to analyze 
#re-render map and assign
#source_file to that etc
put '/setLogFileTo/:file' do
  file = params[:file].to_s
  
  puts file
  #guard condition
  #return unless LOG_FILES.keys.include?(file);

  #change sym link
  `ln -sf #{GEO_API_ROOT}/curl/generated-dict/#{LOG_FILES[file][:dict]} #{GEO_MAP_ROOT}/python_dict.py`
  puts "ln -sf #{GEO_API_ROOT}/curl/generated-dict/#{LOG_FILES[file][:dict]} #{GEO_MAP_ROOT}/python_dict.py"
  #rebuild map
  `cd #{GEO_MAP_ROOT} && python3 build-map-with-dict.py`
  #change source above 
  $current = LOG_FILES[file][:source]
  {currentLogFile: $current}.to_json
end

#upload auth.log file for audit
post '/upload' do
  # Retrieve the uploaded file
  file = params[:file]

  # Save the file to a specified location
  File.open('uploads/' + file[:filename], 'wb') do |f|
    f.write(file[:tempfile].read)
  end

  # Return a success message
  {result: 'success'}.to_json
end

get '/scan/:ip' do
  ip = params[:ip]
  puts $current
  payload = {
    frequency: `zgrep #{ip} #{$current} | wc -l`,
    #entries: `grep #{ip} #{$current}`, 
    ports: `nc -zv -w 1 #{ip} 22 2>&1`,
    isp: `whois #{ip}`.force_encoding("ISO-8859-1").encode("UTF-8"),
    users: `zgrep #{ip} #{$current} | egrep -o \"invalid user [A-Za-z\-]+\" | awk \'{print $3}\' | sort -u | xargs`,
    #duration: "%2.2f" % ((Time.parse(`grep #{ip} #{$current} | awk '{print $1}' | tail -n1`) - Time.parse(`grep #{ip} #{$current} | awk '{print $1}' | head -n1`)).to_f)
  }
  #pp payload
  payload.to_json
end

get '/entries/:ip' do
  puts $current
  breakin_attempts =`zgrep #{params[:ip]} #{$current}`
  payload = {
    content: breakin_attempts
  }
  payload.to_json 
end

get '/geo/:ip' do
  GEODB.get(params[:ip])['location'].to_json
end

get '/py-dict/:file' do
  {dictionary: File.read("#{__dir__}/curl/generated-dict/#{LOG_FILES[params[:file]][:dict]}")}.to_json
end
