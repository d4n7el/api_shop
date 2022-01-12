class Customer::StoresController < ApplicationController
  before_action :valid_token?, only:[:index ]

  def index
    stores = Store.all
    render json: stores, status: :ok
  end

  private
end
