class Admin::StoresController < ApplicationController

  def index
    
  end
  def update

  end

  def edit

  end

  private

  def store_params
    params.require(:store).permit(:name, :address, :description, :user_id, :status)
  end

end
