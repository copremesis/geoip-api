require 'sinatra'
require 'json'
require 'csv'
require 'sinatra/cross_origin'
require 'maxmind/db'

set :bind, '0.0.0.0'
load './cors-enable.rb'

GEODB = MaxMind::DB.new('MaxMind/GeoLite2-City.mmdb', mode: MaxMind::DB::MODE_MEMORY)
SOURCE_FILE = 'auth.log.4'

get '/scan/:ip' do
  ip = params[:ip]
  payload = {
    frequency: `grep #{ip} #{SOURCE_FILE} | wc -l`,
    #entries: `grep #{ip} #{SOURCE_FILE}`, 
    ports: `nc -zv -w 1 #{ip} 22 2>&1`,
    isp: `whois #{ip}`.force_encoding("ISO-8859-1").encode("UTF-8"),
    users: `grep #{ip} #{SOURCE_FILE} | grep -P -o \"invalid user (\\w+)\" | awk \'{print $3}\' | sort -u | xargs`,
    duration: "%2.2f" % ((Time.parse(`grep #{ip} #{SOURCE_FILE} | awk '{print $1}' | tail -n1`) - Time.parse(`grep #{ip} #{SOURCE_FILE} | awk '{print $1}' | head -n1`)).to_f)
  }
  payload.to_json
end

get '/entries/:ip' do
  breakin_attempts =`grep #{params[:ip]} auth.log.4`
  payload = {
    content: breakin_attempts
  }
  payload.to_json 
end

get '/geo/:ip' do
  GEODB.get(params[:ip])['location'].to_json
end
