class CatsController < ApplicationController

  def index
    @cats = Cat.all
  end

  def show
    @rental_requests = CatRentalRequest.where(id: params[:id])
    @cat = Cat.find(params[:id])
  end

  def new
    @cat = Cat.new
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to "/cats"
    else
      render json: @cat.errors.full_messages
    end
  end

  def edit
    @cat = Cat.find(params[:id])
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to "/cats"
    else
      render json: @cat.errors.full_messages
    end
  end


  private
  def cat_params
    params.require(:cat).permit(:name, :color, :age, :birthdate, :sex)
  end

end
