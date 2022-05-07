class ReviewsController < ApplicationController
  before_action :set_professional, only: %i[index show update destroy]
  before_action :set_review, only: %i[show update destroy]

  # GET /reviews
  def index
    @reviews = @professional.reviews

    render json: ReviewSerializer.new(@reviews)
  end

  # GET /reviews/1
  def show
    render json: ReviewSerializer.new(@review)
  end

  # POST /reviews
  def create
    @review = Review.new(review_params)

    if @review.save
      render json: ReviewSerializer.new(@review), status: :created, location: @review
    else
      render json: ReviewSerializer.new(@review.errors), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reviews/1
  def update
    if @review.update(review_params)
      render json: ReviewSerializer.new(@review)
    else
      render json: ReviewSerializer.new(@review.errors), status: :unprocessable_entity
    end
  end

  # DELETE /reviews/1
  def destroy
    @review.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_review
    @review = Review.find(params[:id])
  end

  def set_professional
    @professional = Professional.find(params[:professional_id])
  end

  # Only allow a list of trusted parameters through.
  def review_params
    params.require(:review).permit(:professional_id, :client_id, :rating, :body)
  end
end
