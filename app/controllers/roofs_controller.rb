class RoofsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  load_and_authorize_resource
  layout "roof", :only => :show


  # GET /roofs
  # GET /roofs.json
  def index
    @roofs = Roof.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @roofs }
    end
  end

  # GET /roofs/1
  # GET /roofs/1.json
  def show
    @roof = Roof.find(params[:id])
    @roofs_near = Roof.where(:id.ne => @roof._id).geo_near([@roof.latitude, @roof.longitude]).max_distance(1.fdiv(111.12)).first(10)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @roof }
    end
  end

  # GET /roofs/new
  # GET /roofs/new.json
  def new
    @roof = Roof.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @roof }
    end
  end

  # GET /roofs/1/edit
  def edit
    @roof = Roof.find(params[:id])
  end

  # POST /roofs
  # POST /roofs.json
  def create
    @roof = Roof.new(params[:roof])
    @roof.user = current_user

    respond_to do |format|
      if @roof.save
        format.html { redirect_to @roof, notice: 'Roof was successfully created.' }
        format.json { render json: @roof, status: :created, location: @roof }
      else
        format.html { render action: "new" }
        format.json { render json: @roof.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /roofs/1
  # PUT /roofs/1.json
  def update
    @roof = Roof.find(params[:id])

    respond_to do |format|
      if @roof.update_attributes(params[:roof])
        format.html { redirect_to @roof, notice: 'Roof was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @roof.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roofs/1
  # DELETE /roofs/1.json
  def destroy
    @roof = Roof.find(params[:id])
    @roof.destroy

    respond_to do |format|
      format.html { redirect_to roofs_url }
      format.json { head :no_content }
    end
  end

  # GET /roofs/1/instruction
  def instruction
    @roof = Roof.find(params[:id])
    authorize! :instruction, @roof
    @roof.build_instruction unless @roof.instruction?

    if @roof.instruction.user? and @roof.instruction.user != current_user
      redirect_to @roof
    end
  end

  # GET /roofs/1/buy
  def buy
    authorize! :buy, Roof
    @roof = Roof.find(params[:id])
    transaction = Transaction.new(amount: -@roof.cost, user: current_user, target_id: @roof._id, target_type: 'roof')

    respond_to do |format|
      if transaction.save
        current_user.roofs << @roof
        if current_user.save
          Transaction.create(amount: @roof.cost - (@roof.cost * 0.25), user: current_user, target_id: @roof._id, target_type: 'roof')
        end

        format.html { redirect_to @roof, notice: 'Roof was bought.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @roof, notice: "Roof wasn't bought." }
        format.json { render json: @roof.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /roofs/1/like
  def like
    authorize! :like, Roof
    @roof = Roof.find(params[:id])

    if current_user.likes?(@roof)
      respond_to do |format|
        if current_user.unlike(@roof)
          format.html { redirect_to @roof, notice: 'Roof was unliked' }
          format.json { head :no_content }
          format.js   { render :js => "$('#like').removeClass('active');" }
        else
          format.html { redirect_to @roof, notice: "Roof wasn't unliked" }
          format.json { render json: @roof.errors, status: :unprocessable_entity }
          format.js   { render :js => "" }
        end
      end

    else
      respond_to do |format|
        if current_user.like(@roof)
          format.html { redirect_to @roof, notice: 'Roof was liked' }
          format.json { head :no_content }
          format.js   { render :js => "$('#like').addClass('active'); $('#dislike').removeClass('active');" }
        else
          format.html { redirect_to @roof, notice: "Roof wasn't liked" }
          format.json { render json: @roof.errors, status: :unprocessable_entity }
          format.js   { render :js => "" }
        end
      end
    end
  end

  # POST /roofs/1/dislike
  def dislike
    authorize! :dislike, Roof
    @roof = Roof.find(params[:id])

    if current_user.dislikes?(@roof)
      respond_to do |format|
        if current_user.undislike(@roof)
          format.html { redirect_to @roof, notice: 'Roof was undisliked' }
          format.json { head :no_content }
          format.js   { render :js => "$('#dislike').removeClass('active');" }
        else
          format.html { redirect_to @roof, notice: "Roof wasn't undisliked" }
          format.json { render json: @roof.errors, status: :unprocessable_entity }
          format.js   { render :js => "" }
        end
      end

    else
      respond_to do |format|
        if current_user.dislike(@roof)
          format.html { redirect_to @roof, notice: 'Roof was disliked' }
          format.json { head :no_content }
          format.js   { render :js => "$('#dislike').addClass('active'); $('#like').removeClass('active');" }
        else
          format.html { redirect_to @roof, notice: "Roof wasn't disliked" }
          format.json { render json: @roof.errors, status: :unprocessable_entity }
          format.js   { render :js => "" }
        end
      end
    end
  end

  # POST /roofs/1/bookmark
  def bookmark
    authorize! :bookmark, Roof
    @roof = Roof.find(params[:id])

    if current_user.bookmarks?(@roof)
      respond_to do |format|
        if current_user.unbookmark(@roof)
          format.html { redirect_to @roof, notice: 'Roof was bookmarked' }
          format.json { head :no_content }
          format.js   { render :js => "$('#bookmark').removeClass('active');" }
        else
          format.html { redirect_to @roof, notice: "Roof wasn't unbookmarked" }
          format.json { render json: @roof.errors, status: :unprocessable_entity }
          format.js   { render :js => "" }
        end
      end

    else
      respond_to do |format|
        if current_user.bookmark(@roof)
          format.html { redirect_to @roof, notice: 'Roof was bookmarked' }
          format.json { head :no_content }
          format.js   { render :js => "$('#bookmark').addClass('active');" }
        else
          format.html { redirect_to @roof, notice: "Roof wasn't bookmarked" }
          format.json { render json: @roof.errors, status: :unprocessable_entity }
          format.js   { render :js => "" }
        end
      end
    end
  end
end
