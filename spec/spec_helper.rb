require 'chefspec'

PROJECT_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))
$LOAD_PATH << File.join(PROJECT_ROOT, 'lib')

Dir.glob(File.join(PROJECT_ROOT, 'spec', 'support', '*.rb')).each do |support_file|
  require support_file
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random' # Run specs in random order to surface order dependencies.

  ### ChefSpec ###
  config.cookbook_path = 'cookbooks'
  config.platform = 'ubuntu'
  config.version = '12.04'

  config.include(CustomChefSpecMatchers)
  config.include(ChefSpecHelper)
end
