class ProfessionalsController < ApplicationController
  before_action :set_professional, only: %i[show update destroy]

  def index
    @pagy, @professionals = pagy(Professional.includes(:user, :work_portfolios, :services, :calendly_token, :reviews,
                                                       :bookings).all)

    render json: ProfessionalSerializer.new(@professionals, pagination_links(@pagy))
  end

  def show
    render json: ProfessionalSerializer.new(@professional, set_options)
  end

  def create
    @professional = Professional.new(professional_params)

    authorize @professional

    if @professional.save
      render json: ProfessionalSerializer.new(@professional, set_options), status: :created, location: @professional
    else
      render json: ErrorSerializer.serialize(@professional.errors), status: :unprocessable_entity
    end
  end

  def update
    authorize @professional

    if @professional.update(professional_params)
      render json: ProfessionalSerializer.new(@professional, set_options)
    else
      render json: ErrorSerializer.serialize(@professional.errors), status: :unprocessable_entity
    end
  end

  def destroy
    authorize @professional

    @professional.user.destroy
  end

  private

  def set_professional
    @professional = Professional.includes(:work_portfolios, :services, :calendly_token, :reviews,
                                          :bookings).find(params[:id])
  end

  def professional_params
    params.require(:professional).permit(:user_id, :field, :license_number, :office_address, :headline)
  end

  def set_options
    {
      include: %i[user work_portfolios services reviews calendly_token bookings]
    }
  end

  def pagination_links(pagy)
    uri = request.base_url + request.path
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
