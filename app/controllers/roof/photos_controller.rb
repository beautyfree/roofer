class Roof::PhotosController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource class: 'Roof::Photo'

  # GET /photos
  # GET /photos.json
  def index
    @roof = Roof.find(params[:roof_id])
    @photos = @roof.photos

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photos.where(:user_id => current_user._id).collect { |p| p.to_jq_upload }.to_json }
      #format.json { render json: @photos }
    end
  end

  # GET /photos/1
  # GET /photos/1.json
=begin
  def show
    @photo = Photo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photo }
    end
  end
=end

  # GET /photos/new
  # GET /photos/new.json
  def new
    @roof = Roof.find(params[:roof_id])
    @photo = @roof.photos.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @roof }
    end
  end

  # GET /photos/1/edit
=begin
  def edit
    @photo = Photo.find(params[:id])
  end
=end

  # POST /photos
  # POST /photos.json
  def create
    @roof = Roof.find(params[:roof_id])
    @photo = @roof.photos.new(params[:roof_photo])
    @photo.user = current_user

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render json: { :files => [@photo.to_jq_upload]}, status: :created, location: roof_photo_path(@roof, @photo) }
        #format.json { render json: @photo, status: :created, location: @photo }

      else
        format.html { render action: "new" }
        format.json { render json: @photo.to_jq_upload.merge({ :error => "custom_failure" }) }
        #format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /photos/1
  # PUT /photos/1.json
=begin
  def update
    @photo = Photo.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end
=end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @roof = Roof.find(params[:roof_id])
    @photo = @roof.photos.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to roof_photos_url }
      format.json { render json: true }
    end
  end


end
