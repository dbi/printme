require 'rubygems'
require 'sinatra'
require 'nokogiri'
require 'open-uri'

get '/' do
  if params[:url]
    doc = Nokogiri::HTML(open(params[:url]))
    doc.encoding = params[:encoding] if params[:encoding]
    @body = doc.css(params[:include_css]).to_s
  end
  erb :index
end

__END__

@@index
<!DOCTYPE HTML>
<html lang="sv">
  <head>
    <meta charset="utf-8">
    <title><%= params[:url] || "Printme app" %></title>
    <style type="text/css" media="screen, print">
      label {
          display:block;
      }
      @media print {
        #input {
          display:none;
        }
      }
    </style>
  </head>
  <body>
    <div id="input">
      <h1>Printme</h1>
      <form action="." method="get">
        <p><label for="url">Url</label><input type="text" name="url" value="<%= params[:url] %>" id="url" size="50"></p>
        <p><label for="include_css">Include CSS</label><input type="text" name="include_css" value="<%= params[:include_css] %>" id="include_css" size="50"></p>
        <p><input type="submit" name="submit" value="Submit" id="submit"></p>
      </form>
      <hr>
    </div>
    <%= @body %>
  </body>
</html>
