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
    if !params[:owner][:name].empty?
      @owner = Owner.create(params[:owner]) 
    else 
      @owner = Owner.find_by(params[:owner][:name])
    end
      @owner.pets << @pet
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end 

  patch '/pets/:id' do 
    p params
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    binding.pry
    if !params[:owner][:name].empty?
      @owner = Owner.create(name: params[:owner][:name]) 
    else
      @owner = Owner.find(params[:owner][:id])
    end
    if @pet.owner != @owner 
      @pet.owner.pets.delete(@pet)
      @owner.pets << @pet
    end
    redirect to "pets/#{@pet.id}"
  end
end