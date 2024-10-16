require 'sinatra'
require 'sqlite3'
require 'json'

DB = SQLite3::Database.new 'db/development.sqlite3'
DB.results_as_hash = true

get '/' do
  'Hello World'
end

get '/mountains' do
  begin
    name = params[:name]

    if name
      sanitized_name = name.gsub(/[^a-z-]/, '')
      mountains = DB.execute("SELECT * FROM mountains WHERE name='#{sanitized_name}'")
      if mountains.empty?
        halt 404
      end
    else
      mountains = DB.execute("SELECT `name` FROM mountains")
    end

    content_type :json
    mountains.to_json
  rescue SQLite3::Exception => e
    status 500
    { error: "Database error: #{e.message}" }.to_json
  end
end
