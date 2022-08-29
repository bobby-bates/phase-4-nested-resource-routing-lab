class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    render json: Item.find(params[:id])
  end

  def create
    item = Item.create(item_params)
    render json: item, status: :created
  end

  private

  def render_not_found_response
    render json: { error: 'User not found' }, status: :not_found
  end

  def item_params
    params.permit(:name, :description, :price, :user_id)
  end
end
