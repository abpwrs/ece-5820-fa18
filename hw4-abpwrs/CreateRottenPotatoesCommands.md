# HW4 from scratch

## These steps were completed for you

```bash
#- DO NOT RUN THE COMMANDS BELOW IN THIS BLOCK!
# Starting a fresh rails application
rails new hw4fall2018 -T
cd hw4fall2018/
git init
git add -A .
git commit

# Add default editor and git environment settings
cat ../hw3fall2018/.gitignore >> .gitignore
cp ../hw3fall2018/.editorconfig .
cp ../hw3fall2018/.rubocop.yml .

# Intialize ruby mine and config files
mine .
#  << Configure initial data sources and test empty application >>
#- DO NOT RUN THE COMMANDS ABOVE IN THIS BLOCK!

```

## Steps that you must execute
### Add HAML dependancy
```bash
rbenv version #  Verify that you are using ruby 2.4.4
bundle install --without production

# Add to Gemfile
  # use Haml for templates 
  gem 'haml' 

bundle install --without production

git add Gemfile Gemfile.lock;
git commit
```

### Add initial routes
```bash
bundle exec rake routes # => You don't have any routes defined!
```
Add routes to the correct file (HINT:)
```
Rails.application.routes.draw do
  resources :movies
  root :to => redirect('/movies')
end
```

```bash
bundle exec rake routes # => routes now listed
git add -A; git commit
```

### Create initial database migration
```bash
rails generate migration create_movies
```
Complete editing the migration definition (see HINT BELOW)
```
    create_table 'movies' do |t|
      t.string 'title'
      t.string 'rating'
      t.text 'description'
      t.datetime 'release_date'
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
```
Apply the migration

```
bundle exec rake db:migrate
bundle exec rake db:schema:load
git add -A db/
git commit
```

### Seed the database with initial movie content
Add the seeding information for initial database information
```
movies = [
  {:title => 'Aladdin', :rating => 'G', :release_date => '25-Nov-1992'},
  {:title => 'The Terminator', :rating => 'R', :release_date => '26-Oct-1984'},
  {:title => 'When Harry Met Sally', :rating => 'R', :release_date => '21-Jul-1989'},
  {:title => 'The Help', :rating => 'PG-13', :release_date => '10-Aug-2011'},
  {:title => 'Chocolat', :rating => 'PG-13', :release_date => '5-Jan-2001'},
  {:title => 'Amelie', :rating => 'R', :release_date => '25-Apr-2001'},
  {:title => '2001: A Space Odyssey', :rating => 'G', :release_date => '6-Apr-1968'},
  {:title => 'The Incredibles', :rating => 'PG', :release_date => '5-Nov-2004'},
  {:title => 'Raiders of the Lost Ark', :rating => 'PG', :release_date => '12-Jun-1981'},
  {:title => 'Chicken Run', :rating => 'G', :release_date => '21-Jun-2000'},
  {:title => 'The Shawshank Redemption', :rating => 'R', :release_date => '14-Oct-1994'},
  {:title => 'Inception', :rating => 'PG-13', :release_date => '16-Jul-2010'},
]

movies.each do |movie|
  Movie.create!(movie)
end
```

```bash
bundle exec rake db:seed
git add db
git commit
```

### Create initial active record model for the movie class
Fill in the initial model (HINT)
```
class Movie < ActiveRecord::Base
end
```

```bash
git add app
git commit
```

### Prepare the views and the controller
Complete the base rotten potatoes app by moving files in the `THESE_FILES_NEED_TO_BE_MOVED` folder
to their appropriate locations.
```
git mv ./THESE_FILES_NEED_TO_BE_MOVED/application.css app/assets/stylesheets/
git rm app/views/layouts/application.html.erb
git mv ./THESE_FILES_NEED_TO_BE_MOVED/application.html.haml <<some destination>>
git mv ./THESE_FILES_NEED_TO_BE_MOVED/<<some file>>  << some destination >>
git mv ./THESE_FILES_NEED_TO_BE_MOVED/<<some file>>  << some destination >>
git mv ./THESE_FILES_NEED_TO_BE_MOVED/<<some file>>  << some destination >>
git add
git commit
```

### Runt he rotten potatoes intitial application
```
 bundle exec rails server  
```

