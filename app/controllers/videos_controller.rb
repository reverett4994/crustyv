class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /videos
  # GET /videos.json
  def index
    if session[:sort] == params[:sort]
      @seed=session[:seed]
    else
      @seed=rand(1..100)
      session[:seed]=@seed
      session[:sort] = params[:sort]
    end
    if params[:sort]
      @sort=params[:sort]
      if @sort=='forced'
        @videos =Video.where('cat LIKE ?','Forced Orgasm').order("RAND(#{@seed})").paginate(:page => params[:page])
      elsif @sort=='blowjob'
        @videos =Video.where('cat LIKE ?','Blowjob').order("RAND(#{@seed})").paginate(:page => params[:page])
      elsif @sort=='struggle'
        @videos =Video.where('cat LIKE ?','Struggle Fuck').order("RAND(#{@seed})").paginate(:page => params[:page])
      elsif @sort=='standerd'
        @videos =Video.where('cat LIKE ?','Standerd').order("RAND(#{@seed})").paginate(:page => params[:page])
      end
    else
    @videos = Video.all.order("RAND(#{@seed})").paginate(:page => params[:page])
    end


  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    if @video.cat == 'Forced Orgasm'
      @search='forced'
    elsif @video.cat == 'Blowjob'
      @search='blowjob'
    elsif @video.cat == 'Struggle Fuck'
      @search='struggle'
    elsif @video.cat == 'Standerd'
      @search='standerd'
    end
  end

  # GET /videos/new
  def new
    @video = current_user.videos.build
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = current_user.videos.build(video_params)

    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: 'Video was successfully created.' }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:cat, :res, :title,:movie)
    end
end
