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

post '/mountains' do
  begin
    body_contents = request.body.read

    begin
      data = JSON.parse(body_contents)
    rescue JSON::ParserError => e
      halt 400, { error: "JSON parsing error: #{e.message}" }.to_json
    end

    if (
      data.is_a?(Hash) &&
      data.key?('name') && data['name'].is_a?(String) &&
      data.key?('title') && data['title'].is_a?(String) &&
      data.key?('altitude') && data['altitude'].is_a?(Numeric) &&
      (data.key?('description') ? data['description'].is_a?(String) : true)
    )
      sanitized_name = name.gsub(/[^a-z-]/, '')
      sanitized_title = Sanitize.fragment(data['title'], Sanitize::Config::BASIC)
      sanitized_description = Sanitize.fragment(data['description'], Sanitize::Config::BASIC)

      response = DB.execute(
        "INSERT INTO mountains (title, name, altitude, description) VALUES (?, ?, ?, ?)",
        [
          sanitized_title,
          sanitized_name,
          data['altitude'],
          sanitized_description,
        ]
      )

        puts response
        status 201
        { message: "Mountain created successfully" }.to_json
    else
      status 400
      { error: "Invalid input" }.to_json
    end
  end
end