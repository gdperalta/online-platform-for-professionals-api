class ErrorSerializer
  def self.serialize(errors)
    return if errors.nil?

    response = {}
    error_hash = errors.to_hash(true).map do |field, error|
      error.map do |msg|
        { id: field, title: msg }
      end
    end.flatten
    response[:errors] = error_hash
    response
  end
end
