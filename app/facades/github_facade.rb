class GithubFacade

  def self.generate_repo
    name = GithubService.repo[:name]
    contributors = GithubService.contributors.find_all.with_index{|user, i| [0,1,3,4].include?(i) }
    team_members = contributors.map{|contributor| {login: contributor[:login], commits: contributor[:contributions]}}
    pr = GithubService.get_pulls[0][:number]
    Repo.new(name, team_members, pr)
  end
end
