require 'sinatra'
require 'erb'

get '/' do
  "Hello World!!"
end

get '/form' do
  erb :index
end

post '/result' do
  erb :index
end

get '/confirm' do
  erb :confirm
end

post '/result_confirm' do
  erb :confirm
end


__END__

@@ index
<!DOCTYPE html>
<html>
  <head>
    <style>
      body { background-color: #aaaaaa; }
      div#result { color: red; }
    </style>
  </head>
  <body>
    <div id="result"><%= params[:name] %></div>
    <form method="POST" action="/result">
      <label>Name: <input type="text" name="name"></label>
      <input type="submit" value="Go!" />
    </form>
  </body>
</html>

@@ confirm
<!DOCTYPE html>
<html>
  <head>
    <style>
      body { background-color: #aaaaaa; }
      div#result { color: red; }
    </style>
  </head>
  <body>
    <div id="result"><%= params[:name] %></div>
    <form method="POST" action="/result_confirm">
      <label>Name: <input type="text" name="name"></label>
      <input type="submit" value="Go!" onclick="return confirm('submit?');" />
    </form>
  </body>
</html>
