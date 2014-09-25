require "sinatra"
if development?
  require "sinatra/reloader"
end

require "active_record"

ActiveRecord::Base.establish_connection(
  adapter:  "postgresql",
  database: "photo_gallery"
)

class Gallery < ActiveRecord::Base
  has_many :images
end

class Image < ActiveRecord::Base
end

get "/" do 
  @galleries = Gallery.all
  erb :home
end

get "/galleries/new" do
  erb :new_gallery
end

post "/galleries" do   #our form method on galleries/new is POST
  new_gallery_name = params[:gallery][:name]
  Gallery.create(name: new_gallery_name) 

  redirect to("/")
end

get "/galleries/:id/edit" do
  @gallery = Gallery.find(params[:id])
  erb :edit_gallery
end

patch "/galleries/:id" do
  id = params[:id]
  gallery = Gallery.find(id)
  gallery.update(params[:gallery])

  redirect to("/galleries/#{id}")
end

delete "/galleries/:id" do
  id = params[:id]
  gallery = Gallery.find(id)
  gallery.destroy
  
  redirect to("/")
end

get "/galleries/:id" do   
  id = params[:id]   #setting id to parameter input in URL   galleries/1   id = 1

  @gallery = Gallery.find(id) #finds gallery based on ID, creates ojbect array
  @images = Image.where(gallery_id: id)   # use with second part in gallery

  erb :gallery
end

post "/galleries/:id/images/new" do
  @gallery = Gallery.find(params[:id])
  erb :new_image
end

post "/galleries/:id/images" do
  gallery = Gallery.find(params[:id])
  gallery.images.create(params[:image])

  redirect to("galleries/#{gallery.id}")
end

#THESE ARE CLASS NOTES---------------------------------------

# RUBY SCOPE
#    SINATRA SCOPE
#       get "/galleries" do
#       end   etc...
#
# class Gallery < AcitveRecord::Base (Gallery inherits
#    Gallery is the class that depends on the pluralization of Gallery in the
#    database. In this instance the Gallery class will be full of stuff from
#    galleries table in database. Active record does this automatically.
#
# Image.name will not work
# image = Image.find(1) represents a row of stuff found in the images table
# within the database.   .find  FINDS an instance (a row) of image class
# image.name will now return the name of the name column from the images table
#
#@instance variables from within GET DO END (routes) cannot be tossed to other
#routes. They are islands of code that are called and then tossed away.
#A ROUTE is a combination of a VERB (get, post, patch...) and a PATH.

#ORM Object Relational Mapper -- a bridge between RUBY code and database
#   Dont have to write in SQL
#   Takes ruby request, translates to database language
#
#if user is inputting something, always be wary of security risks
#
#@gallery_names = galleries.map {|gallery| gallery.name} gets array of names

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
