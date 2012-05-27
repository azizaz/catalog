# coding: utf-8
class RubricsController < ApplicationController
  before_filter :authenticate, :only => [:new, :create, :edit, :update]
  
  # GET /rubrics
  # GET /rubrics.xml
  def index
    @rubrics = Rubric.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rubrics }
    end
  end

  # GET /rubrics/1
  # GET /rubrics/1.xml
  def show
    @rubric = Rubric.find(params[:id])
	@rubric.items = Item.where("rubric_id = ?", @rubric.id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rubric }
    end
  end

  # GET /rubrics/new
  # GET /rubrics/new.xml
  def new
    @rubric = Rubric.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rubric }
    end
  end

  # GET /rubrics/1/edit
  def edit
    @rubric = Rubric.find(params[:id])
  end

  # POST /rubrics
  # POST /rubrics.xml
  def create
    @rubric = Rubric.new(params[:rubric])

    respond_to do |format|
      if @rubric.save
        format.html { redirect_to("/browse/#{@rubric.id}", :notice => 'Rubric was successfully created.') }
        format.xml  { render :xml => @rubric, :status => :created, :location => "/browse/#{@rubric.id}" }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rubric.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rubrics/1
  # PUT /rubrics/1.xml
  def update
    @rubric = Rubric.find(params[:id])

    respond_to do |format|
      if @rubric.update_attributes(params[:rubric])
        format.html { redirect_to(@rubric, :notice => 'Rubric was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rubric.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rubrics/1
  # DELETE /rubrics/1.xml
  def destroy
    @rubric = Rubric.find(params[:id])
    @rubric.destroy

    respond_to do |format|
      format.html { redirect_to(rubrics_url) }
      format.xml  { head :ok }
    end
  end
  
  
  private
    def authenticate
      redirect_to auth_path, :notice => "Сначала нужно залогиниться." if not session[:user_id]
    end
end
