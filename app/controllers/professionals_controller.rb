class ProfessionalsController < ApplicationController
  before_action :set_professional, only: %i[show update destroy]

  def index
    @professionals = Professional.all

    render json: ProfessionalSerializer.new(@professionals)
  end

  def show
    render json: ProfessionalSerializer.new(@professional)
  end

  def create
    @professional = current_user.build_professional(professional_params)

    if @professional.save
      render json: ProfessionalSerializer.new(@professional), status: :created
    else
      render json: ProfessionalSerializer.new(@professional.errors), status: :unprocessable_entity
    end
  end

  def update
    if @professional.update(professional_params)
      render json: ProfessionalSerializer.new(@professional)
    else
      render json: ProfessionalSerializer.new(@professional.errors), status: :unprocessable_entity
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
end
