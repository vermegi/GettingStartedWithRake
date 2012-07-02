require 'albacore'

@SOLUTIONFOLDER = "..\\A.Simple.App"
@SOLUTION = "..\\A.Simple.App\\A.Simple.App.sln"
@PROJECTFOLDER = "..\\A.Simple.App\\A.Simple.App"
@CONFIG = ENV['CONFIG'] || 'Debug'

desc "the default task"
task :default => [:buildIt, :publish, :migrate]
task :migrate => [:migrate_down, :migrate_up]

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

fluentmigrator :migrate_up do |migrator|
	migrator.command = '../A.Simple.App/packages/FluentMigrator.1.0.2.0/tools/Migrate.exe'
	migrator.provider = 'sqlserver2008'
	migrator.target = "../A.Simple.App/A.Simple.Migration/bin/#{@CONFIG}/A.Simple.Migration.dll"
	migrator.connection = 'Data Source=.\\sqlexpress;Initial Catalog=simpledb;Integrated Security=true'
	migrator.verbose = true
end

fluentmigrator :migrate_down do |migrator|
	migrator.command = '../A.Simple.App/packages/FluentMigrator.1.0.2.0/tools/Migrate.exe'
	migrator.provider = 'sqlserver2008'
	migrator.target = "../A.Simple.App/A.Simple.Migration/bin/#{@CONFIG}/A.Simple.Migration.dll"
	migrator.connection = 'Data Source=.\\sqlexpress;Initial Catalog=simpledb;Integrated Security=true'
	migrator.verbose = true
	migrator.task = 'rollback:all'
end