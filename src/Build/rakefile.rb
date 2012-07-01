require 'albacore'

@SOLUTION = "..\\A.Simple.App\\A.Simple.App.sln"
@CONFIG = ENV['CONFIG'] || 'Debug'

desc "the default task"
task :default => [:buildIt]

msbuild :buildIt do |msb|
	msb.properties :configuration => @CONFIG
	msb.targets :Clean, :Build
	msb.solution = @SOLUTION
end