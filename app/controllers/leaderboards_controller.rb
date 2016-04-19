class LeaderboardsController < ApplicationController
  def index
    response = token.get("/api/v1/tags/#{program_tag}/people", headers: { "Accept": "application/json" })
    @people = JSON.parse(response.body)["results"]
  end

end