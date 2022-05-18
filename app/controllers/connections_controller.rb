class ConnectionsController < ApplicationController
  before_action :set_connection, only: %i[show destroy]

  def create
    @connection = Connection.new(connection_params)
    @connection.classification = current_user.professional? ? 'client_list' : 'subscription'

    authorize @connection

    if @connection.save
      render json: ConnectionSerializer.new(@connection), status: :created, location: @connection
    else
      render json: ErrorSerializer.serialize(@connection.errors), status: :unprocessable_entity
    end
  end

  def subscribers
    professional = current_user.professional

    render json: ClientSerializer.new(professional.subscribers, set_options)
  end

  def clientele
    professional = current_user.professional

    render json: ClientSerializer.new(professional.clientele, set_options)
  end

  def subscribed_to
    client = current_user.client

    render json: ClientSerializer.new(client.subscribed_to, set_options)
  end

  def my_professionals
    client = current_user.client

    render json: ClientSerializer.new(client.my_professionals, set_options)
  end

  def destroy
    authorize @connection

    @connection.destroy
  end

  private

  def set_connection
    @connection = Connection.find(params[:id])
  end

  def connection_params
    params.require(:connection).permit(:professional_id, :client_id)
  end

  def set_options
    {
      include: %i[user]
    }
  end
end
