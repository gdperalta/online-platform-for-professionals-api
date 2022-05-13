class WorkPortfoliosController < ApplicationController
  before_action :set_professional, only: %i[index create]
  before_action :set_work_portfolio, only: %i[show update destroy]

  def index
    @work_portfolios = @professional.work_portfolios

    render json: WorkPortfolioSerializer.new(@work_portfolios)
  end

  def show
    render json: WorkPortfolioSerializer.new(@work_portfolio)
  end

  def create
    @work_portfolio = @professional.work_portfolios.build(work_portfolio_params)

    if @work_portfolio.save
      render json: WorkPortfolioSerializer.new(@work_portfolio), status: :created
    else
      render json: ErrorSerializer.serialize(@work_portfolio.errors), status: :unprocessable_entity
    end
  end

  def update
    if @work_portfolio.update(work_portfolio_params)
      render json: WorkPortfolioSerializer.new(@work_portfolio)
    else
      render json: ErrorSerializer.serialize(@work_portfolio.errors), status: :unprocessable_entity
    end
  end

  def destroy
    @work_portfolio.destroy
  end

  private

  def set_professional
    @professional = Professional.find(params[:professional_id])
  end

  def set_work_portfolio
    @professional = set_professional
    @work_portfolio = @professional.work_portfolios.find(params[:id])
  end

  def work_portfolio_params
    params.require(:work_portfolio).permit(:professional_id, :title, :details)
  end
end
