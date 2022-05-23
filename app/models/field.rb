class Field < ApplicationRecord
    
    
    def self.fields_names
        Field.all.map do |field|
            field[:name]
        end
    end
end
