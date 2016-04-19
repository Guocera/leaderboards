class LeaderboardsController < ApplicationController
  def index
    response = token.get('/api/v1/people', headers: { "Accept": "application/json" }, params: { page: 1 } )
    @people = JSON.parse(response.body)["results"]
    @people.each do |person|
      puts "First name: ", person['first_name']
      puts "Employer: ", person['employer']
      puts
    end
  end

end