class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
  has_one :professional, dependent: :destroy
  has_one :client, dependent: :destroy
  before_create :build_client_association

  def build_client_association
    return unless role == 'client'

    build_client
  end
end
