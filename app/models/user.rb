class User < ApplicationRecord
	has_secure_password

	validates :email, presence: true, uniqueness: true

	has_many :articles

	Roles = [:admin, :default]

	def is?(requested_role)
		self.role == requested_role.to_s
	end
end
