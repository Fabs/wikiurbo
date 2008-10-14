class CitizensController < ApplicationController
  # GET /citizens
  # GET /citizens.xml
  def index
    @citizens = Citizen.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @citizens }
    end
  end

  # GET /citizens/1
  # GET /citizens/1.xml
  def show
    @citizen = Citizen.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @citizen }
    end
  end

  # GET /citizens/new
  # GET /citizens/new.xml
  def new
    @citizen = Citizen.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @citizen }
    end
  end

  # GET /citizens/1/edit
  def edit
    @citizen = Citizen.find(params[:id])
  end

  # POST /citizens
  # POST /citizens.xml
  def create
    @citizen = Citizen.new(params[:citizen])

    respond_to do |format|
      if @citizen.save
        flash[:notice] = 'Citizen was successfully created.'
        format.html { redirect_to(@citizen) }
        format.xml  { render :xml => @citizen, :status => :created, :location => @citizen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @citizen.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /citizens/1
  # PUT /citizens/1.xml
  def update
    @citizen = Citizen.find(params[:id])

    respond_to do |format|
      if @citizen.update_attributes(params[:citizen])
        flash[:notice] = 'Citizen was successfully updated.'
        format.html { redirect_to(@citizen) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @citizen.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /citizens/1
  # DELETE /citizens/1.xml
  def destroy
    @citizen = Citizen.find(params[:id])
    @citizen.destroy

    respond_to do |format|
      format.html { redirect_to(citizens_url) }
      format.xml  { head :ok }
    end
  end
end
