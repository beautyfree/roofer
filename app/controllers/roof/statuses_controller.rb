# encoding: utf-8

class Roof::StatusesController < ApplicationController
  # GET /roof/statuses
  # GET /roof/statuses.json
  def index
    @roof = Roof.find(params[:roof_id])
    @statuses = @roof.statuses
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statuses }
    end
  end

  # GET /roof/statuses/1
  # GET /roof/statuses/1.json
  def show
    @roof = Roof.find(params[:roof_id])
    @status = @roof.statuses.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @status }
    end
  end

  # GET /roof/statuses/new
  # GET /roof/statuses/new.json
  def new
    @roof = Roof.find(params[:roof_id])
    @status = @roof.statuses.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @status }
    end
  end

  # GET /roof/statuses/1/edit
  def edit
    @roof = Roof.find(params[:roof_id])
    @status = @roof.statuses.find(params[:id])
  end

  # POST /roof/statuses
  # POST /roof/statuses.json
  def create
    @roof = Roof.find(params[:roof_id])
    @status = @roof.statuses.new(params[:roof_status])

    respond_to do |format|
      if @status.save
        format.html { redirect_to @roof, notice: 'Спасибо что помогаете нам! Заявка отправлена на модерацию :)' }
        format.json { render json: @status, status: :created, location: @status }
      else
        format.html { render action: "new" }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /roof/statuses/1
  # PUT /roof/statuses/1.json
  def update
    @roof = Roof.find(params[:roof_id])
    @status = @roof.statuses.find(params[:id])

    respond_to do |format|
      if @status.update_attributes(params[:roof_status])
        format.html { redirect_to @roof, notice: 'Status was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roof/statuses/1
  # DELETE /roof/statuses/1.json
  def destroy
    @roof = Roof.find(params[:roof_id])
    @status = @roof.statuses.find(params[:id])
    @status.destroy

    respond_to do |format|
      format.html { redirect_to statuseses_url }
      format.json { head :no_content }
    end
  end
end
