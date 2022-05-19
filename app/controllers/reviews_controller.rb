class ReviewsController < ApplicationController
  before_action :set_professional, only: %i[index]
  before_action :set_review, only: %i[show update destroy]

  def index
    @reviews = @professional.reviews

    render json: ReviewSerializer.new(@reviews)
  end

  def show
    render json: ReviewSerializer.new(@review)
  end

  def create
    @review = Review.new(review_params)
    @review.professional_id = params[:professional_id]
    @review.client_id = current_user.client.try(:id)

    authorize @review

    if @review.save
      render json: ReviewSerializer.new(@review), status: :created,
             location: professional_review_path(@review.professional, @review)
    else
      render json: ErrorSerializer.serialize(@review.errors), status: :unprocessable_entity
    end
  end

  def update
    authorize @review

    if @review.update(review_params)
      render json: ReviewSerializer.new(@review)
    else
      render json: ErrorSerializer.serialize(@review.errors), status: :unprocessable_entity
    end
  end

  def destroy
    authorize @review

    @review.destroy
  end

  private

  def set_professional
    @professional = Professional.find(params[:professional_id])
  end

  def set_review
    @professional = set_professional
    @review = @professional.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :body)
  end
end
