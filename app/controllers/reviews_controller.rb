class ReviewsController < ApplicationController
  before_action :set_professional, only: %i[index create]
  before_action :set_review, only: %i[show update destroy]

  def index
    @reviews = @professional.reviews

    render json: ReviewSerializer.new(@reviews)
  end

  def show
    render json: ReviewSerializer.new(@review)
  end

  def create
    @review = current_user.client.reviews.build(review_params)
    @review.professional_id = @professional.id

    if @review.save
      render json: ReviewSerializer.new(@review), status: :created
    else
      render json: ErrorSerializer.serialize(@review.errors), status: :unprocessable_entity
    end
  end

  def update
    if @review.update(review_params)
      render json: ReviewSerializer.new(@review)
    else
      render json: ErrorSerializer.serialize(@review.errors), status: :unprocessable_entity
    end
  end

  def destroy
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
    params.require(:review).permit(:professional_id, :client_id, :rating, :body)
  end
end
