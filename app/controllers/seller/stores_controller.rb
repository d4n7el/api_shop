class Seller::StoresController < ApplicationController
  before_action :valid_token?, only:[:index ]
  before_action :is_seller?, only:[:index]
  before_action :set_store, only: [:index]

  def index
    render json: @store, status: :ok
  end

  private

  def set_store 
    @store = Store.find_by(store_id: current_user.store_id)
    render status: :bad_request and return if @store === nil
  end
end
