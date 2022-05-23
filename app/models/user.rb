class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
  has_one :professional, dependent: :destroy
  has_one :client, dependent: :destroy
  before_create :build_client_association
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :contact_number, presence: true, uniqueness: true, length: { is: 10 }
<<<<<<< HEAD
  VALID_CITIES = PHLocations::Client.getCities[:data].map {|city| city["name"]}
  validates :city, presence: true, inclusion: {in: VALID_CITIES, message: '%<value>s is not a valid city'}
  VALID_REGIONS = PHLocations::Client.getRegions[:data].map {|region| region["name"]}
  validates :region, presence: true, inclusion: {in: VALID_REGIONS, message: '%<value>s is not a valid region'}
=======
  # validates :city, presence: true, inclusion: {in: %w[:city_names(PHLocations::Client.getCities)]}
  # validates :region, presence: true, inclusion: {in: %w[:region_names(PHLocations::Client.getRegions)]}
>>>>>>> 47c4fa014ae5e2dae2661a56fdc780f8588496d3
  validates :role, presence: true,
                   inclusion: { in: %w[professional client admin], message: '%<value>s is not a valid role' }
  validate :role_not_changed, on: :update

<<<<<<< HEAD
  
=======
  def city_names(parsed_json)
    parsed_json[:data].map { |city| city['name'] }
  end

  def region_names(parsed_json)
    parsed_json[:data].map { |region| region['name'] }
  end

>>>>>>> 47c4fa014ae5e2dae2661a56fdc780f8588496d3
  def role_not_changed
    errors.add(:role, 'cannot be changed after account creation') if role_changed?
  end

  def build_client_association
    return unless role == 'client'

    build_client
  end

  def admin?
    role == 'admin'
  end

  def professional?
    role == 'professional'
  end

  def client?
    role == 'client'
  end
end
