class ProfessionalsController < ApplicationController
  before_action :set_professional, only: %i[show update destroy]

  def index
    @pagy, @professionals = pagy(Professional.includes(:user, :work_portfolios, :services, :calendly_token, :reviews,
                                                       :bookings, :subscribers, :clientele).all)
    render json: ProfessionalSerializer.new(@professionals, pagination_links)
  end

  def search
    @pagy, @professionals = pagy(Professional.includes(:user, :work_portfolios, :services, :calendly_token, :reviews,
                                                       :bookings, :subscribers, :clientele).ransack(params[:q]).result)

    render json: ProfessionalSerializer.new(@professionals, pagination_links)
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

  def pagination_links
    links = { self: request.original_url }
    headers = pagy_headers_merge(@pagy)

    headers['Link'].split(', ').each do |link|
      url = link[/<(.*?)>/, 1]
      page = link[/"(.*)"/, 1]

      links[page] = url
    end

    { links: links }
  end
end
