class Owner::StoresController < ApplicationController
  before_action :valid_token?, only:[:index, :edit, :update]
  before_action :is_owner?, only:[:index, :edit, :update]
  before_action :set_store, only: [:edit, :update]

  def index
    stores = Store.find_by(store_id: current_user.store_id )
    render json: stores, status: :ok
  end

  def update
    if  @store.update(store_params)
      render json: @store, status: :ok
    else
      render json: @store.errors , status: :unprocessable_entity
    end
  end

  def edit
    render json: @store, status: :ok
  end

  private

  def set_store 
    @store = Store.find_by(store_id: current_user.store_id)
    render status: :bad_request and return if @store === nil
  end

  def store_params
    params.require(:store).permit(:name, :address, :description , :status)
  end

end
