begin
  require "coveralls/rake/task"
  Coveralls::RakeTask.new
  desc "Runs the unit and feature tests and sends to coveralls"
  task default: [:spec, :cucumber, "coveralls:push"]
rescue LoadError
  :this_is_fine
end
