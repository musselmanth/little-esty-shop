class GithubFacade

  def self.generate_repo
    if GithubService.repo.has_key?(:id)
      name = GithubService.repo[:name]
      contributors = GithubService.contributors[0..4]
      team_members = contributors.map{|contributor| {login: contributor[:login], commits: contributor[:contributions]}} if contributors
      pr = GithubService.get_pulls[0][:number]
    else
      name, contributors, team_members = nil, nil, []
    end
    Repo.new(name, team_members, pr)
  end
end
