class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    # binding.pry
    @pet = Pet.create(name: params["pet"]["name"])
    unless params[:pet][:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:pet][:owner][:name])
    else
      @pet.owner = Owner.find(params[:pet][:owner_id])
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
    erb :'/pets/edit'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet][:name])
    if @pet.owner_id != params[:pet][:owner_id].to_i
      @pet.owner = Owner.find(params[:pet][:owner_id])
    else
      @pet.owner = Owner.find_or_create_by(name: params[:owner][:name])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
