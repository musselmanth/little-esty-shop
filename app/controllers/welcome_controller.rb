class WelcomeController < ApplicationController
  def index
    @readme_text = File.read("#{Rails.root}/README.md")

    @repo = GithubFacade.generate_repo
  end
end