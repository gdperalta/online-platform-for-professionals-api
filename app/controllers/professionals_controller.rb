class ProfessionalsController < ApplicationController
  before_action :set_professional, only: %i[show update destroy]

  def index
    @professionals = Professional.all

    render json: ProfessionalSerializer.new(@professionals, set_options)
  end

  def show
    render json: ProfessionalSerializer.new(@professional, set_options)
  end

  def create
    @professional = current_user.build_professional(professional_params)

    if @professional.save
      render json: ProfessionalSerializer.new(@professional, set_options), status: :created
    else
      render json: ErrorSerializer.serialize(@professional.errors), status: :unprocessable_entity
    end
  end

  def update
    if @professional.update(professional_params)
      render json: ProfessionalSerializer.new(@professional, set_options)
    else
      render json: ErrorSerializer.serialize(@professional.errors), status: :unprocessable_entity
    end
  end

  def destroy
    @professional.destroy
  end

  private

  def set_professional
    @professional = Professional.find(params[:id])
  end

  def professional_params
    params.require(:professional).permit(:user, :field, :license_number, :office_address, :headline)
  end

  def set_options
    {
      include: %i[user work_portfolios services reviews]
    }
  end
end
