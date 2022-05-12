class CalendlyTokensController < ApplicationController
  before_action :set_professional, only: %i[create]
  before_action :set_calendly_token, only: %i[show update destroy]

  def index
    @calendly_tokens = CalendlyToken.all

    render json: CalendlyTokenSerializer.new(@calendly_tokens)
  end

  def show
    render json: CalendlyTokenSerializer.new(@calendly_token)
  end

  def create
    @calendly_token = @professional.build_calendly_token(calendly_token_params)

    if @calendly_token.save
      render json: CalendlyTokenSerializer.new(@calendly_token), status: :created
    else
      render json: ErrorSerializer.serialize(@calendly_token.errors), status: :unprocessable_entity
    end
  end

  def update
    if @calendly_token.update(calendly_token_params)
      render json: CalendlyTokenSerializer.new(@calendly_token)
    else
      render json: ErrorSerializer.serialize(@calendly_token.errors), status: :unprocessable_entity
    end
  end

  def destroy
    @calendly_token.destroy
  end

  private

  def set_professional
    @professional = Professional.find(params[:professional_id])
  end

  def set_calendly_token
    @professional = set_professional
    @calendly_token = @professional.calendly_token
  end

  def calendly_token_params
    params.require(:calendly_token).permit(:professional_id, :authorization, :user, :organization)
  end
end
