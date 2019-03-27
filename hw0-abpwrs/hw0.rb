# A simple script to verify that
# your ruby environment is configured properly
#
# \author Hans J. Johnson
#

SELT_REQUIRED_VERSION="2.5.1"

if RUBY_VERSION == SELT_REQUIRED_VERSION
  puts "Congratulations, you appear to be running the requested version of Ruby #{ SELT_REQUIRED_VERSION } to be used for SELT in Fall 2018."
else
  puts "WARNING:  #{ RUBY_VERSION } may not function as described in the SELT eSaaS book examples"
end

my_user_name =  ENV['USERNAME']
if my_user_name.nil? || my_user_name.empty?
  my_user_name = ENV['USER']
end

5.times do
  puts "Hello #{ my_user_name }!"
end
