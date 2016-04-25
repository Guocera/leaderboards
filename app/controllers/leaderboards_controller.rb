class LeaderboardsController < ApplicationController
  def index
    response = token.get("/api/v1/tags/#{program_tag}/people", headers: { "Accept": "application/json" })
    @people = JSON.parse(response.body)["results"]
    @companies = Hash.new(0)

    @people.each_with_index do |person, i|
      id = person['id']
      response = token.get("/api/v1/people/#{id}/taggings", headers: { "Accept": "application/json" })
      tags = JSON.parse(response.body)["taggings"]

      response = token.get("/api/v1/people/#{id}/capitals", headers: { "Accept": "application/json" })
      capitals = JSON.parse(response.body)["results"]

      @people[i]['capital_amount_in_cents'] = 0
      capitals.each do |capital|
        @people[i]['capital_amount_in_cents'] += (capital['amount_in_cents'].to_f / 100.0).to_i
      end
      persons_capital = @people[i]['capital_amount_in_cents']

      found_company = false
      i = 0
      until found_company
        company_name = tags[i]["tag"]
        if company_name.include? "#{program_tag}-"
          @companies[company_name[(program_tag_length + 1)..-1]] += persons_capital
          found_company = true
        end
        i += 1
      end

    end

    @people.sort_by! do |person|
      person["capital_amount_in_cents"]
    end.reverse!

    @companies = @companies.sort_by { |company, capital| capital }.reverse!

  end

  def show
    @company = params[:id]
    response = token.get("/api/v1/tags/#{program_tag}-#{@company}/people", headers: { "Accept": "application/json" })
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
  end

end