class UserDashboardFacade

  def header
    "Github"
  end

  def repositories
    #can be refactored to
    #take a parameter which determines
    #how many repos to map
    repository_data.map do |repository_data|
      Repository.new(repository_data)
    end
  end

  private

    def repository_data
      @_repository_data ||= service.github_info
    end

    def service
      @_service ||= GithubService.new
    end
end
