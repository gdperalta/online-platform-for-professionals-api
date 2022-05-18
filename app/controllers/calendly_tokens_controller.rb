class CalendlyTokensController < ApplicationController
  before_action :set_calendly_token, only: %i[show update destroy]

  def show
    authorize @calendly_token

    render json: CalendlyTokenSerializer.new(@calendly_token)
  end

  def create
    @calendly_token = CalendlyToken.new(calendly_token_params)
    @calendly_token.professional_id = params[:professional_id]

    authorize @calendly_token

    if @calendly_token.save
      render json: CalendlyTokenSerializer.new(@calendly_token), status: :created,
             location: professional_calendly_token_path(@calendly_token.professional, @calendly_token)
    else
      render json: ErrorSerializer.serialize(@calendly_token.errors), status: :unprocessable_entity
    end
  end

  def update
    authorize @calendly_token

    if @calendly_token.update(calendly_token_params)
      render json: CalendlyTokenSerializer.new(@calendly_token)
    else
      render json: ErrorSerializer.serialize(@calendly_token.errors), status: :unprocessable_entity
    end
  end

  def destroy
    authorize @calendly_token

    @calendly_token.destroy
  end

  private

  def set_calendly_token
    @calendly_token = CalendlyToken.find(params[:id])
  end

  def calendly_token_params
    params.require(:calendly_token).permit(:authorization)
  end
end
