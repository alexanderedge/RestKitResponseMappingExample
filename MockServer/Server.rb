require 'rubygems'
require 'sinatra'
require 'json'
require 'pp'

configure do
  set :logging, true
  set :dump_errors, true
 set :public_folder, Proc.new { File.expand_path(root) }
end

def render_fixture(filename)
  send_file File.join(settings.public_folder, filename)
end

post '/error' do
  puts '[Params]'
  p params
    halt 403, {'Content-Type' => 'application/json'},"{	\"data\": {\"status\": 403,\"message\": \"Forbidden\"}}"
end

post '/login' do
  puts '[Params]'
  p params
  render_fixture('SuccessResponse.json');
end