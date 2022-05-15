class FieldController < ApplicationController
    def index
        @fields = Field.all
    end
end
