# # encoding: utf-8

# Inspec test for recipe task1_jboss::deploy

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe command('curl 192.168.56.10:8080/helloworld/hi.jsp') do
  its('stdout') { should match /Hello, World/ }
end


