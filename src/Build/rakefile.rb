require 'albacore'

@SOLUTIONFOLDER = "..\\A.Simple.App"
@SOLUTION = "..\\A.Simple.App\\A.Simple.App.sln"
@PROJECTFOLDER = "..\\A.Simple.App\\A.Simple.App"
@CONFIG = ENV['CONFIG'] || 'Debug'

desc "the default task"
task :default => [:buildIt, :publish]

msbuild :buildIt do |msb|
	msb.properties :configuration => @CONFIG
	msb.targets :Clean, :Build
	msb.solution = @SOLUTION
end

desc "Publish the web site"
msbuild :publish do |msb|
  msb.properties = {:configuration=>@CONFIG}
  msb.targets [:ResolveReferences,:_CopyWebApplication]
  msb.properties = {
  :webprojectoutputdir=>"../../build/builds/#{@CONFIG}",
  :outdir => "../../build/builds/#{@CONFIG}"
  }
  msb.solution = "#{@PROJECTFOLDER}/A.Simple.App.csproj"
end