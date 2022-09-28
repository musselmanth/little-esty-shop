class GithubFacade

  def self.generate_repo
    name = GithubService.repo[:name]
    contributors = GithubService.contributors[0..4]
    if contributors
    team_members = contributors.map{|contributor| {login: contributor[:login], commits: contributor[:contributions]}}  if contributors
    pr = GithubService.get_pulls[0][:number]
    Repo.new(name, team_members, pr)
  end
end
