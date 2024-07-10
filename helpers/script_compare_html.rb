require_relative '../lib/query_tracker'
require 'pry-byebug'

data_1 = File.read('helpers/automatic_lazily.yaml')
data_2 = File.read('helpers/original.yaml')
data_1 = YAML.safe_load(data_1, permitted_classes: [Proc, Symbol])
data_2 = YAML.safe_load(data_2, permitted_classes: [Proc, Symbol])
QueryTracker.compare do |comparing|
  comparing.code('First code block') do
    QueryTracker.tracker.instance_variable_set :@query_tracker, data_1
  end
  comparing.code('Second code block') do
    QueryTracker.tracker.instance_variable_set :@query_tracker, data_2
  end
  comparing.compare!
end
