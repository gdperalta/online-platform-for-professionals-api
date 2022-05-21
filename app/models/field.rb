class Field < ApplicationRecord
    validates :name, presence: true
    
    def fields_names(fields)
        names = []
        fields.map do |field|
            names.push(field.name)
        end
        names
    end
end
