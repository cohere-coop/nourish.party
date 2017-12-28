require "coveralls"
require "simplecov"
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([SimpleCov::Formatter::HTMLFormatter,
                                                                Coveralls::SimpleCov::Formatter])
SimpleCov.start("rails")
