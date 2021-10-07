# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    movie_title = movie[:title]
    movie_rat = movie[:rating]
    movie_relea = movie[:release_date]
    Movie.create!(title: movie_title, rating: movie_rat, release_date: movie_relea)
  end
  #fail "Unimplemented"
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |x11, x22|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  regular_exp = /#{x11}.*{x22}/m
  regular_exp.match(page.body)
  #fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  if uncheck == "un"
    rating_list.split(', ').each do |x|
      step %{I uncheck "ratings_#{x}"}
    end
  else
    rating_list.split(', ').each do |x| 
      step %{I check "ratings_#{x}"} 
    end
  end
  #fail "Unimplemented"
  
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  rows = page.all('table#movies tbody tr').length
  expect(rows).to eq Movie.count
  # fail "Unimplemented"
end

Then /I should see the movies : (.*)/ do |movies_data|
  # pending # Write code here that turns the phrase above into concrete actions
  mvs = movies_data.split(', ')
  mvs.each do |mv|
      step "I should see " + mv
  end
end

Then /I should not see the movies : (.*)/ do |movies_data|
  # pending # Write code here that turns the phrase above into concrete actions
  mvs = movies_data.split(', ')
  mvs.each do |mv|
      step "I should not see " + mv
  end
end
