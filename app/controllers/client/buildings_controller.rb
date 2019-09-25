class Client::BuildingsController < ApplicationController
  def index
    @buildings = Building.all
    render 'index.html.erb'
  end

  def new
    render 'new.html.erb'
  end

  def create

    response = HTTP.post(
                         "http://localhost:3000/api/buildings", 
                            form:{
                             name: params[:name],
                             address: params[:address],
                             height: params[:height],
                             construction_date: params[:construction_date],
                             architect: params[:architect]
                              }
                              )

    @building = response.parse
    redirect_to "/client/buildings/#{@building['id']}"
  end

  # def create
  #   @building = Building.create(
  #          name: params[:name],
  #          address: params[:address],
  #          height: params[:height],
  #          construction_date: params[:construction_date],
  #          architect: params[:architect]
  #                               )

  #   redirect_to "/client/buildings/#{@building.id}"
  # end

  def show
    @building = Building.find(params[:id])
    render 'show.html.erb'
  end

  def edit
    response = HTTP.get("http://localhost:3000/api/buildings/#{params[:id]}")
    @building = response.parse
    render "edit.html.erb"
  end

  def update
    response = HTTP.patch(
                          "http://localhost:3000/api/buildings/#{params[:id]}", 
                          form:{
                          name: params[:name],
                          address: params[:address],
                          height: params[:height],
                          construction_date: params[:construction_date],
                          architect: params[:architect]
                    })
    @building = response.parse
    redirect_to "/client/buildings/#{@building['id']}"
  end

  def destroy
     response = HTTP.delete("http://localhost:3000/api/buildings/#{params[:id]}")
     redirect_to "/client/buildings"
  end
end
