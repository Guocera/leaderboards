class LeaderboardsController < ApplicationController
  def index
    response = token.get("/api/v1/tags/#{program_tag}/people", headers: { "Accept": "application/json" })
    @people = JSON.parse(response.body)["results"]
    @companies = {}

    @people.each_with_index do |person, i|
      id = person['id']
      response = token.get("/api/v1/people/#{id}/taggings", headers: { "Accept": "application/json" })
      tags = JSON.parse(response.body)["taggings"]
      found_company = false
      i = 0
      until found_company
        if tags[i]["tag"].include? "#{program_tag}-"
          puts tags[i]["tag"]
          found_company = true
        end
        i += 1
      end

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