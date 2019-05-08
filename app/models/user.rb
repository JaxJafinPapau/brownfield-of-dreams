# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :api_keys

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: %i[default admin]
  has_secure_password

  def repositories
    #pass an argument later if multiple api keys belong to the same user
    instantiate_repositories
  end


  private
    def instantiate_repositories
      service.find_repositories.map do |repo|
        RepositoryService.new(repo)
      end
    end

    def service
      @_service ||= GithubService.new(self.github_username, self.api_keys.first.github)
    end

end
