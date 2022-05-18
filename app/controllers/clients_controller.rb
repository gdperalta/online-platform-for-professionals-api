class ClientsController < ApplicationController
  before_action :set_client, only: %i[show destroy]

  def index
    @pagy, @clients = pagy(Client.includes(:user, :reviews, :bookings, :professionals).all)

    render json: ClientSerializer.new(@clients, pagination_links(@pagy))
  end

  def show
    render json: ClientSerializer.new(@client, set_options)
  end

  def destroy
    authorize @client
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

  def pagination_links(pagy)
    uri = request.base_url + request.path
    {
      links: {
        self: "#{uri}?page=#{pagy.page}",
        next: pagy.next.nil? ? nil : "#{uri}?page=#{pagy.next}",
        prev: pagy.prev.nil? ? nil : "#{uri}?page=#{pagy.prev}",
        last: "#{uri}?page=#{pagy.last}"
      }
    }
  end
end
