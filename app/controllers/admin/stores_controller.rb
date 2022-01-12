class Admin::StoresController < ApplicationController
  before_action :valid_token?, only:[:index, :create, :edit, :update]
  before_action :is_admin?, only:[:index, :create, :edit, :update]
  before_action :set_store, only: [:edit, :update]

  def index
    stores = Store.all
    render json: stores, status: :ok
  end

  def create
    store = Store.new(store_params)
    if store.save
      render json: store, status: :ok
    else
      render json: store.errors , status: :unprocessable_entity
    end
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
    @store = Store.find(params[:id])
    render status: :bad_request and return if @store === nil
  end

  def store_params
    params.require(:store).permit(:name, :address, :description, :status)
  end

end
