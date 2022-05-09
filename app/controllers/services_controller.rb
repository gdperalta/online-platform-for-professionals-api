class ServicesController < ApplicationController
  before_action :set_professional, only: %i[index create]
  before_action :set_service, only: %i[show update destroy]

  def index
    @services = @professional.services

    render json: ServiceSerializer.new(@services)
  end

  def show
    render json: ServiceSerializer.new(@service)
  end

  def create
    @service = @professional.services.build(service_params)

    if @service.save
      render json: ServiceSerializer.new(@service), status: :created
    else
      render json: ErrorSerializer.serialize(@service.errors), status: :unprocessable_entity
    end
  end

  def update
    if @service.update(service_params)
      render json: ServiceSerializer.new(@service)
    else
      render json: ErrorSerializer.serialize(@service.errors), status: :unprocessable_entity
    end
  end

  def destroy
    @service.destroy
  end

  private

  def set_professional
    @professional = Professional.find(params[:professional_id])
  end

  def set_service
    @professional = set_professional
    @service = @professional.services.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:professional_id, :title, :details, :min_price, :max_price)
  end
end
