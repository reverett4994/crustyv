class ImagesController < ApplicationController
  require 'will_paginate/array'
  WillPaginate.per_page = 9
  before_action :set_image, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /images
  # GET /images.json
  def index
      if session[:sort] == params[:sort]
        @seed=session[:seed]
      else
        @seed=rand(1..100)
        session[:seed]=@seed
        session[:sort] = params[:sort]
      end
      @sort=params[:sort]
      if @sort=='pretty'
        @images =Image.where('cat LIKE ?','Pretty Girls').order("RAND(#{@seed})").paginate(:page => params[:page])
      elsif @sort=='blowjob'
        @images =Image.where('cat LIKE ?','Blowjob').order("RAND(#{@seed})").paginate(:page => params[:page])
      elsif @sort=='bondage'
        @images =Image.where('cat LIKE ?','Bondage').order("RAND(#{@seed})").paginate(:page => params[:page])
      elsif @sort=='real'
        @images =Image.where('cat LIKE ?','Real Girls').order("RAND(#{@seed})").paginate(:page => params[:page])
      elsif @sort=='cumshot'
        @images =Image.where('cat LIKE ?','Cumshot').order("RAND(#{@seed})").paginate(:page => params[:page])
      elsif @sort=='all'
        @images = Image.all.order("RAND(#{@seed})").paginate(:page => params[:page])

      end
   end

  # GET /images/1
  # GET /images/1.json
  def show

  end

  # GET /images/new
  def new
    @image = current_user.images.build
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images
  # POST /images.json
  def create
    @image = current_user.images.build(image_params)

    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:nsfw, :cat, :res,:title,:girl)
    end
end
