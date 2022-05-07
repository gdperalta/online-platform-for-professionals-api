class ProfessionalsController < ApplicationController
  before_action :set_professional, only: %i[show update destroy]

  # GET /professionals
  def index
    @professionals = Professional.all

    # render json: @professionals
    render json: ProfessionalSerializer.new(@professionals)
  end

  # GET /professionals/1
  def show
    render json: @professional
  end

  # POST /professionals
  def create
    @professional = Professional.new(professional_params)

    if @professional.save
      render json: @professional, status: :created, location: @professional
    else
      render json: @professional.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /professionals/1
  def update
    if @professional.update(professional_params)
      render json: @professional
    else
      render json: @professional.errors, status: :unprocessable_entity
    end
  end

  # DELETE /professionals/1
  def destroy
    @professional.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_professional
    @professional = Professional.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def professional_params
    params.require(:professional).permit(:user, :field, :license_number, :office_address, :headline)
  end
end
