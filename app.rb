require "sinatra"
if development?
  require "sinatra/reloader"
end
require "pg"

database = PG.connect({ dbname: "photo_gallery" })
#sets database to be photo_gallery, using PG.connect
#
get "/" do
  galleries = database.exec_params("SELECT name FROM galleries")
  #@gallery_names = []
 
  @gallery_names = galleries.map { |gallery| gallery["name"]}

  #galleries.each do |gallery|
  #  @gallery_names << gallery["name"]
  #end
  
 # @galleries = GALLERIES
 # ake galleries a database.exec put names into gallery array
 #  use in home view

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
