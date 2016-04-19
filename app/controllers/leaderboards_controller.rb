class LeaderboardsController < ApplicationController
  def index
    response = token.get("/api/v1/tags/#{program_tag}/people", headers: { "Accept": "application/json" })
    @people = JSON.parse(response.body)["results"]

    @people.each_with_index do |person, i|
      id = person['id']
      response = token.get("/api/v1/people/#{id}/capitals", headers: { "Accept": "application/json" })
      capitals = JSON.parse(response.body)["results"]
      @people[i]['capital_amount_in_cents'] = 0
      capitals.each do |capital|
        @people[i]['capital_amount_in_cents'] += (capital['amount_in_cents'].to_f / 100.0).to_i
      end
    end

    @people.sort_by! do |person|
      person["capital_amount_in_cents"]
    end.reverse!
  end

end