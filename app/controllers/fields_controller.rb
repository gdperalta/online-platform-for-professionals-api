class FieldsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @fields = Field.all

    render json: @fields
  end
end
