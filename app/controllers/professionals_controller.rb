class ProfessionalsController < ApplicationController
  before_action :set_professional, only: %i[show update destroy]

  def index
    @pagy, @professionals = pagy(Professional.includes(:user, :work_portfolios, :services, :calendly_token, :reviews,
                                                       :bookings, :clients).all)

    render json: ProfessionalSerializer.new(@professionals, pagination_links(@pagy))
  end

  def show
    render json: ProfessionalSerializer.new(@professional, set_options)
  end

  def create
    @professional = current_user.build_professional(professional_params)

    if @professional.save
      render json: ProfessionalSerializer.new(@professional, set_options), status: :created, location: @professional
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
    @professional.user.destroy
  end

  private

  def set_professional
    @professional = Professional.includes(:work_portfolios, :services, :calendly_token, :reviews,
                                          :bookings).find(params[:id])
  end

  def professional_params
    params.require(:professional).permit(:user, :field, :license_number, :office_address, :headline)
  end

  def set_options
    {
      include: %i[user work_portfolios services reviews calendly_token bookings]
    }
  end

  def pagination_links(pagy)
    # Temporary link
    uri = 'localhost:3001/professionals'
    {
      links: {
        self: "#{uri}?page=#{pagy.page}",
        next: pagy.next.nil? ? nil : "#{uri}?page=#{pagy.next}",
        prev: pagy.prev.nil? ? nil : "#{uri}?page=#{pagy.prev}",
        last: "#{uri}?page=#{pagy.last}"
      }
    }
  end
end
