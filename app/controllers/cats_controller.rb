class CatsController < ApplicationController

  before_action :ensure_is_owner, only: [:edit, :update]

  def index
    @cats = Cat.all
  end

  def show
    @rental_requests = CatRentalRequest.where(cat_id: params[:id])
    @cat = Cat.find(params[:id])
  end

  def new
    @cat = Cat.new
  end

  def create
    @cat = Cat.new(cat_params)
    p = current_user.id
    @cat.user_id = current_user.id

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

  def ensure_is_owner
    flash[:errors] = "You don't own that cat!"
    redirect_to cats_url if Cat.find(params[:id]).user_id != current_user.id
  end

end
