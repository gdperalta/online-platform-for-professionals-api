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
  VALID_CITIES = PHLocations::Client.getCities[:data].map {|city| city["name"]}
  validates :city, presence: true, inclusion: {in: VALID_CITIES, message: '%<value>s is not a valid city'}
  VALID_REGIONS = PHLocations::Client.getRegions[:data].map {|region| region["name"]}
  validates :region, presence: true, inclusion: {in: VALID_REGIONS, message: '%<value>s is not a valid region'}
  validates :role, presence: true,
                   inclusion: { in: %w[professional client admin], message: '%<value>s is not a valid role' }
  validate :role_not_changed, on: :update


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
