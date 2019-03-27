# Completed step definitions for basic features: AddMovie, ViewDetails, EditMovie

Given /^I am on the RottenPotatoes home page$/ do
  visit movies_path
end


When /^I have added a movie with title "(.*?)" and rating "(.*?)"$/ do |title, rating|
  visit new_movie_path
  fill_in 'Title', with: title
  select rating, from: 'Rating'
  click_button 'Save Changes'
end

Then /^I should see a movie list entry with title "(.*?)" and rating "(.*?)"$/ do |title, rating|
  result = false
  all('tr').each do |tr|
    if tr.has_content?(title) && tr.has_content?(rating)
      result = true
      break
    end
  end
  expect(result).to be_truthy
end

When /^I have visited the Details about "(.*?)" page$/ do |title|
  visit movies_path
  click_on "More about #{title}"
end

Then /^(?:|I )should see "([^\"]*)"$/ do |text|
  expect(page).to have_content(text)
end

When /^I have edited the movie "(.*?)" to change the rating to "(.*?)"$/ do |movie, rating|
  click_on 'Edit'
  select rating, from: 'Rating'
  click_button 'Update Movie Info'
end


# New step definitions to be completed for HW5.
# Note that you may need to add additional step definitions beyond these

# Add a declarative step here for populating the DB with movies.

Given /the following movies have been added to RottenPotatoes:/ do |movies_table|
  # Remove this statement when you finish implementing the test step
  movies_table.hashes.each do |movie|
    # Each returned movie will be a hash representing one row of the movies_table
    # The keys will be the table headers and the values will be the row contents.
    # Entries can be directly to the database with ActiveRecord methods
    # Add the necessary Active Record call(s) to populate the database.
    Movie.create!(movie)
  end
end

When /^I have opted to see movies rated: "(.*?)"$/ do |arg1|
  # HINT: use String#split to split up the rating_list, then
  # iterate over the ratings and check/uncheck the ratings
  # using the appropriate Capybara command(s)
  # remove this statement after implementing the test step
  ratings = arg1.split(',').join(' ').split(' ')
  all('checkbox').each do |box|
    page.uncheck(box)
  end
  ratings.each do |rating|
    page.check("ratings_#{rating}")
  end
end

Then /^I should see only movies rated: "(.*?)"$/ do |arg1|
  # remove this statement after implementing the test step
  result = true
  expected_movies = []
  ratings = arg1.split(',').join(' ').split(' ')
  ratings.each { |rating| expected_movies += Movie.where(rating: rating) }
  expected_movies.each do |movie|
    temp = false
    all('tr').each do |entry|
      if entry.has_content?(movie.title) && entry.has_content?(movie.rating)
        temp = true
      end
    end
    result = false unless temp
    result = false unless Movie.all.length == all('tr').length - 1
    expect(result).to be_truthy
  end
  expect(result).to be_truthy
end

Then /^I should see all of the movies$/ do
  # remove this statement after implementing the test step
  result = true
  Movie.all.each do |movie|
    temp = false
    all('tr').each do |entry|
      if entry.has_content?(movie.title) && entry.has_content?(movie['rating'])
        temp = true
      end
    end
    result = false unless temp
  end
  result = false unless Movie.all.length == all('tr').length - 1
  expect(result).to be_truthy
end


When(/^I have sorted movies by "([^"]*)"$/) do |ord|
  click_link ord + '_header'
end

Then(/^I should see movies ordered by "([^"]*)"$/) do |ord|
  temp = ind = 0 # start indicies at 0
  # find column index to select
  all('//table/thead/tr/th').each do |sorting_option|
    within(sorting_option) do
      unless all('a').empty?
        ind = temp if find('a')[:id] == ord.to_s + '_header'
      end
    end
    temp += 1
  end

  # get sorted array from database
  sorted_attr = []
  Movie.all.each { |movie| sorted_attr << movie[ord.to_sym] }
  sorted_attr.sort!

  # select sorted elements from the column index found above
  elements = []
  all('//tr').each do |entry|
    within(entry) do
      elements << all('td')[ind].text unless all('td').empty?
    end
  end

  # expect sorted list to equal elements scraped off the page in order
  expect(sorted_attr).to eq(elements)
end
