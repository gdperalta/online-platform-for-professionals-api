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
end
