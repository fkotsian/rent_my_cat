class CatRentalRequestsController < ApplicationController

  def index
    @cat_rental_requests = CatRentalRequest.all
  end

  def show
    @cat_rental_request = CatRentalRequest.find(params[:id])
  end

  def new
    @cats = Cat.all
    @cat_rental_request = CatRentalRequest.new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
    if @cat_rental_request.save
      redirect_to "/cat_rental_requests"
    else
      render json: @cat_rental_request.errors.full_messages
    end
  end

  def edit
    @cat_rental_requests = CatRentalRequest.all
    @cat_rental_request = CatRentalRequest.find(params[:id])
  end

  def update
    @cat_rental_request = CatRentalRequest.find(params[:id])
    if @cat_rental_request.update_attributes(cat_params)
      redirect_to "/cats"
    else
      render json: @cat_rental_request.errors.full_messages
    end
  end

  def approve
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_rental_request.approve!

    redirect_to cats_path
  end

  def deny
    @cat_rental_request = CatRentalRequest.find(params[:id])
    @cat_rental_request.deny!

    redirect_to cats_path
  end


  private
  def cat_rental_request_params
    params.require(:rental).permit(:cat_id, :start_date, :end_date, :status)
  end


end