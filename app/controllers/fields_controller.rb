class FieldsController < ApplicationController
  def index
    @fields = Field.all

    render json: @fields
  end
end
