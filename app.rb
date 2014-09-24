require "sinatra"
if development?
  require "sinatra/reloader"
end

require "active_record"

ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  database: "photo_gallery"
)

class Gallery < ActiveRecord::Base
end

class Image < ActiveRecord::Base
end

get "/" do 
  @galleries = Gallery.all
  #@gallery_names = galleries.map {|gallery| gallery.name}
  erb :home
end

get "/galleries/:id" do   
  id = params[:id]   #setting id to parameter input in URL   galleries/1   id = 1
  
  gallery = Gallery.find(id) #finds galleries based on ID
 
  @name = gallery.name
  @images = Image.where(gallery_id: id)   # use with second part in gallery
 
  erb :gallery
end

  #name_result = database.exec_params("SELECT name FROM galleries WHERE id = $1", [id])
  #SELECT returns an array-like object from PG including names from galleries
  #with id = 1  
  
#  @name = name_result.first["name"]
  #save @name as an instance variable to be available in :gallery view, equal to
  #the value of the galleries "name" (value = "Cats", "Dogs" etc)
  
 # @images = []
  #@images = database.exec_params("SELECT * FROM images WHERE id = $1", [id])


#database = PG.connect({ dbname: "photo_gallery" })
#sets database to be already made photo_gallery, using PG.connecta

#get "/" do
#  galleries = database.exec_params("SELECT name FROM galleries")
  #@gallery_names = []
 
#  @gallery_names = galleries.map { |gallery| gallery["name"]}

      #galleries.each do |gallery|
      #  @gallery_names << gallery["name"]
      #end
      
      # @galleries = GALLERIES
      # ake galleries a database.exec put names into gallery array
      #  use in home view

#  erb :home           #sinatra knows that method ERB calling :home will go to VIEWS/home.erb
#end

#get "/galleries/:name" do #:name here is part of a string, it is not a symbol
#

#et "/projects/:id" do
#  pass project id as variable
#  create as a view using :e views/FILENAME.erb
#end

#views/layout.erb
#
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
