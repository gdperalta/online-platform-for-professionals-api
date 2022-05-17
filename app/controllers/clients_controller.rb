class ClientsController < ApplicationController
  before_action :set_client, only: %i[show destroy]

  def index
    @clients = Client.includes(:user, :reviews, :bookings, :professionals).all

    render json: ClientSerializer.new(@clients)
  end

  def show
    render json: ClientSerializer.new(@client, set_options)
  end

  def destroy
    @client.user.destroy
  end

  private

  def set_client
    @client = Client.includes(:user, :reviews, :bookings, :professionals).find(params[:id])
  end

  def set_options
    {
      include: %i[user reviews bookings]
    }
  end
end
