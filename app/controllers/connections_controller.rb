class ConnectionsController < ApplicationController
  before_action :set_connection, only: %i[show destroy]
  before_action :set_user, only: %i[subscribers clientele subscribed_to my_professionals]

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
    render json: ClientSerializer.new(@user.subscribers, set_options)
  end

  def clientele
    render json: ClientSerializer.new(@user.clientele, set_options)
  end

  def subscribed_to
    render json: ClientSerializer.new(@user.subscribed_to, set_options)
  end

  def my_professionals
    render json: ClientSerializer.new(@user.my_professionals, set_options)
  end

  def destroy
    authorize @connection

    @connection.destroy
  end

  private

  def set_user
    @user = current_user.professional || current_user.client
  end

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
