# # encoding: utf-8

# Inspec test for recipe task1_jboss::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# This is an example test, replace it with your own test.
describe port(8080) do
  it { should be_listening }
end

describe package('net-tools') do
  it { should be_installed }
end

describe service('wildfly') do
  it { should be_enabled }
  it { should be_running }
end

describe command('curl localhost:8080') do
  its('stdout') { should match /Welcome to WildFly 10/ }
end

