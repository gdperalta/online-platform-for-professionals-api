class ClientsController < ApplicationController
  before_action :set_client, only: %i[show destroy]

  def index
    @pagy, @clients = pagy(Client.includes(:user, :reviews, :bookings).all)

    render json: ClientSerializer.new(@clients, pagination_links)
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
    @client = Client.includes(:user, :reviews, :bookings).find(params[:id])
  end

  def set_options
    {
      include: %i[user reviews bookings]
    }
  end

  def pagination_links
    links = { self: request.original_url }
    headers = pagy_headers_merge(@pagy)

    headers['Link'].split(', ').each do |link|
      url = link[/<(.*?)>/, 1]
      page = link[/"(.*)"/, 1]

      links[page] = url
    end

    { links: links }
  end
end
