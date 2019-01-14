class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(params[:pet])

    if params[:pet][:owner_id]
      @pet.owner = Owner.find_by_id(params[:pet][:owner_id])
    end
    #Check if pet added a new owner and if so associate it with pet
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    
    @pet.save

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    #binding.pry
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    ####### bug fix
    if !params[:pet].keys.include?("owner_id")
      params[:pet]["owner_id"] = []
    end
    #######
  
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])

    #check and override if a new owner was chosen
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end

    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end