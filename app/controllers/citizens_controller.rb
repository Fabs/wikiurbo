class CitizensController < ApplicationController

  def index
    @citizens = Citizen.find(:all)
  end

  def show
    @citizen = Citizen.find(params[:id])
  end

  def new
    @citizen = Citizen.new
  end

  def edit
    @citizen = Citizen.find(params[:id])
  end

  def create
    @citizen = Citizen.new(params[:citizen])
    if @citizen.save
      flash[:notice] = 'Citizen was successfully created.'
      redirect_to(@citizen)
    else
      render :action => "new"
    end
  end

  def update
    @citizen = Citizen.find(params[:id])
    if @citizen.update_attributes(params[:citizen])
      flash[:notice] = 'Citizen was successfully updated.'
      redirect_to(@citizen)
    else
      render :action => "edit"
    end
  end

  def destroy
    @citizen = Citizen.find(params[:id])
    @citizen.destroy
    redirect_to(citizens_url)
  end
end
