require 'chefspec'
require 'chefspec/policyfile'

at_exit {ChefSpec::Coverage.report!} # what this does is tells chef that when the programer exits, then checks if the tests is enough for the code they have written
