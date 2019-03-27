HW5 SELT 2018
===============

DUE October 10, 2018 at 11:59:59pm
================


In this assignment you will create user stories to describe a feature of a 
SaaS app (RottenPotatoes), use the Cucumber tool to turn those stories into executable 
acceptance tests, and run the tests against your SaaS app.  

Specifically, you will write declarative Cucumber scenarios that test 
some enhancements to the RottenPotatoes app.  These enhancements include
filtering and sorting to RottenPotatoes' `index` view for Movies.

The app code in `rottenpotatoes` contains a "canonical" solution to the
Rails Intro assignment against which to write your scenarios, and the
necessary scaffolding for the first couple of scenarios. 

We recommend
that you do a `git commit` as you get each part working.  As an optional
additional help, git allows you to associate tags---symbolic
names---with particular commits.  For example, immediately after doing a
commit, you could say `git tag hw4-part1b` , and thereafter you could
use `git diff hw4-part1b` to see differences since that commit, rather
than remembering its commit ID.  Note that after creating a tag in your
local repo, you need to say `git push YOUR_REMOTE --tags` to push the tags to
your remote. See 'add' in the [git-remote man page](https://git-scm.com/docs/git-remote)
for how to add remotes. (Tags are ignored by deployment remotes such as Heroku,
so there's no point in pushing tags there.)

> NOTE: Pushing your homework to a public repo is against the Class Honor Code.
Be sure that your repo is private.

Run the enhanced version of RottenPotatoes and observe that two new features have 
been added (don't forget to run ‘bundle install’ and migrate and seed the database first):
•	A set of checkboxes have been added on the homepage to to allow displayed movies to be filtered by rating
  ![RatingSelector](RatingsSelector.png)
•	The 'Movie Title" and "Release Date" headings for the movie table on the homepage are now clickable links that allow the list of movies to be sorted by title or release date, respectively
  ![SortingChoices](SortingChoices.png)

The declarative scenario definitions and associated test steps for the basic features discussed 
in class--i.e. adding a movie, viewing movie details, editing a movie--are provided.  
If you run Cucumber on the provided code you should observe that these tests pass 
while the ones that you will implement for the enhanced features will fail or be skipped. 
By the time you complete the assignment all scenarios and steps should be green.

Important note:  Before running Cucumber, be sure to run the following command to prepare the test environment:
rake db:test:prepare


**Part 1: Create a declarative scenario step for adding movies**

The goal of BDD is to express behavioral tasks rather than low-level operations.  

The background step of all the scenarios in this homework requires that
the movies database contain some movies.  Analogous to the explanation
in Section 4.7, it would go against the goal of BDD to do this by
writing scenarios that spell out every interaction required to add a new
movie, since adding new movies is *not* what these scenarios are about. 

Recall that the `Given` steps of a user story specify the initial state
of the system: it does not matter how the system got into that state.
For part 1, therefore, you will create a step definition that will match
the step `Given the following movies exist` in the `Background` section
of both `sort_movie_list.feature` and `filter_movie_list.feature`.
(Later in the course, we will show how to DRY out the repeated
`Background` sections in the two feature files.) 

Add your code in the `movie_steps.rb` step definition file.  You can
just use ActiveRecord calls to directly add movies to the database; it`s
OK to bypass the GUI associated with creating new movies, since that's
not what these scenarios are testing. 

SUCCESS is when all Background steps for the scenarios in
`filter_movie_list.feature` and `sort_movie_list.feature` are passing
Green. 

**Part 2: Happy paths for filtering movies**

1. Complete the scenario `restrict to movies with `PG` or `R` ratings` in `filter_movie_list.feature`. 
You can use existing step definitions in `web_steps.rb` to check and uncheck the appropriate boxes, 
submit the form, and check whether the correct movies appear (and just as importantly, 
movies with unselected ratings do not appear).

You can consult the Capybara cheat-sheet at: https://gist.github.com/zhengjia/428105 or
 any of many other good references on the web for information regarding using Capybara
 commands to check and uncheck checkboxes



2. Since it's tedious to repeat steps such as When I check the 'PG' checkbox, 
And I check the 'R' checkbox, etc., create a step definition to match a step such as:
`Given I check the following ratings: G, PG, R`
This single step definition should only check the specified boxes, and
leave the other boxes as they were. HINT: this step definition can reuse
existing steps in  `web_steps.rb` , as shown in the example in Section
7.9 in ESaaS.

3. For the scenario `all ratings selected`, it would be tedious to use
 `And I should see` to name every single movie. That would detract from the goal of
  BDD to convey the behavioral intent of the user story. To fix this, create step definitions that will match steps of the form: 
`Then I should see all of the movies` in `movie_steps.rb`. 
HINT: Consider counting the number of rows in the HTML table to implement these steps. If you have computed rows as the number of table rows, you can use the assertion 
`expect(rows).to eq value`
to fail the test in case the values don't match.
Update: You no longer need to implement the scenario for no ratings selected.

4. Use your new step definitions to complete the scenario `all ratings selected`. 
SUCCESS is when all scenarios in `filter_movie_list.feature` pass with all steps green.

**Part 3: Happy paths for sorting movies by title and by release date**

1. Since the declarative scenarios in `sort_movie_list.feature` involve sorting, you will need the ability 
to have steps that test whether one movie appears before another in the output listing. Create a step 
definition that matches a step such as 
`Then I should see "Aladdin" before "Amelie"`

### HINTS

  * `page` is the Capybara method that returns an object representing
  the page returned by the app server.  You can use it in expectations
  such as `expect(page).to have_content('Hello World')`.  More
  importantly, you can search the page for specific elements matching
  CSS selectors or XPath expressions; see the [Capybara
  documentation](https://github.com/jnicklas/capybara) under **Querying**.
  * `page.body` is the page's HTML body as one giant string.  
  * A regular expression could capture whether one string appears before
  another in a larger string, though that's not the only possible
  strategy. 

2. Use the step definition you create above to complete the scenarios `sort movies alphabetically` and `sort movies in increasing order of release date` in `sort_movie_list.feature`.

**SUCCESS** is all steps of all scenarios in both feature files passing Green.

**Submission**

To submit your assignment to the github master branch for your repository.
