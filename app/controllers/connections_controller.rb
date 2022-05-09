class ConnectionsController < ApplicationController
  before_action :set_professional, only: %i[index create]
  before_action :set_connection, only: %i[show destroy]

  def index
    @connections = @professional.connections

    render json: ConnectionSerializer.new(@connections)
  end

  def show
    render json: ConnectionSerializer.new(@connection)
  end

  # TODO: create classification based on user role
  def create
    @connection = @professional.connections.build(connection_params)

    if @connection.save
      render json: ConnectionSerializer.new(@connection), status: :created, location: @connection
    else
      render json: ErrorSerializer.serialize(@connection.errors), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /connections/1
  # def update
  #   if @connection.update(connection_params)
  #     render json: @connection
  #   else
  #     render json: @connection.errors, status: :unprocessable_entity
  #   end
  # end

  def destroy
    @connection.destroy
  end

  private

  def set_professional
    @professional = Professional.find(params[:professional_id])
  end

  def set_connection
    @connection = Connection.find(params[:id])
  end

  def connection_params
    params.require(:connection).permit(:professional_id, :client_id, :classification)
  end
end
