require "sinatra"
if development?
  require "sinatra/reloader"
end

GALLERIES = {
  "cats" => ["colonel_meow.jpg", "grumpy_cat.png"],
  "dogs" => ["shibe.png"]
}

get "/" do
  @galleries = GALLERIES
  erb :home #sinatra knows that method ERB calling :home will go to VIEWS/home.erb
end

get "/galleries/:name" do #:name here is part of a string, it is not a symbol
 @name = params[:name]  
 @images = GALLERIES[@name]
 erb :gallery
end
#
#
#
#
#
#et "/projects/:id" do
#  pass project id as variable
#  create as a view using :e views/FILENAME.erb
#end

#views/layout.erb


  # redirec(to("/bar"), 301)
  # [200, { "Location" => "/bar" } ""]
  # [200, "Body"]
  # "Body"

# Handle an HTTP GET request to '/'
#get "/" do
#  "Welcome to our app"
#end

#if duplicate routes, the first one that matches WINS
#

# NOT put "/" do
#     patch "/" do 
