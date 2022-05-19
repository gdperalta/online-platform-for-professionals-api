class BookingsController < ApplicationController
  before_action :set_professional, only: %i[create]
  before_action :set_booking, only: %i[show update destroy]

  def index
    @user = current_user.professional || current_user.client
    @bookings = @user.event_bookings(params[:status])

    render json: @bookings
  end

  def show
    authorize @booking

    render json: BookingSerializer.new(@booking)
  end

  def create
    @booking = @professional.bookings.build(booking_params)
    @booking.client_id = User.find_by(email: params[:invitee_email]).client.id

    authorize @booking

    if @booking.save
      render json: BookingSerializer.new(@booking), status: :created,
             location: professional_booking_path(@professional, @booking)
    else
      render json: ErrorSerializer.serialize(@booking.errors), status: :unprocessable_entity
    end
  end

  def update
    authorize @booking

    if @booking.update(booking_params)
      render json: BookingSerializer.new(@booking)
    else
      render json: ErrorSerializer.serialize(@booking.errors), status: :unprocessable_entity
    end
  end

  def destroy
    authorize @booking

    @booking.destroy
  end

  private

  def set_professional
    @professional = Professional.find(params[:professional_id])
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:professional_id, :client_id, :event_uuid,
                                    :finished, :start_time, :end_time,
                                    :client_showed_up, :no_show_link, :invitee_link,
                                    canceled_bookings_attributes: [:reason])
  end
end
