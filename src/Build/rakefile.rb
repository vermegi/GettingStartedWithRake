require 'albacore'
require './helper'

@SOLUTIONFOLDER = "../A.Simple.App"
@SOLUTION = "../A.Simple.App/A.Simple.App.sln"
@PROJECTFOLDER = "../A.Simple.App/A.Simple.App"
@CONFIG = ENV['CONFIG'] || 'Debug'

desc "the default task"
task :default => [:buildIt, :migrate, :test, :publish]
task :migrate => [:migrate_down, :migrate_up]
task :publish => [:deploy, :templates, :create_zip]

msbuild :buildIt do |msb|
	msb.properties :configuration => @CONFIG
	msb.targets :Clean, :Build
	msb.solution = @SOLUTION
end

desc "Publish the web site"
msbuild :deploy do |msb|
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

nunit :test do |nunit|
	nunit.command = "#{@SOLUTIONFOLDER}/packages/NUnit.Runners.2.6.0.12051/tools/nunit-console.exe"
	nunit.options "/framework=v4.0.30319", "/config=app.config"
	nunit.assemblies "#{@SOLUTIONFOLDER}/A.Simple.TestProject/bin/#{@CONFIG}/A.Simple.TestProject.dll"
end

expandtemplate :templates do |exp|
  exp.templates(
    "templates/web.config" => "builds/#{@CONFIG}/web.config",
	)
  exp.config = "templates/#{@CONFIG}.yml" 
end

zip :create_zip do |zip|
     zip.directories_to_zip "builds/#{@CONFIG}"
     zip.output_file = "../#{@CONFIG}.zip"
end