@SOLUTION = "..\\A.Simple.App\\A.Simple.App.sln"
@DOT_NET_PATH = 'C:\\Windows\\Microsoft.NET\\Framework64\\v4.0.30319\\'
@CONFIG = 'Debug'

desc "the default task"
task :default => [:buildIt]

task :buildIt do
	sh "#{@DOT_NET_PATH}msbuild.exe /p:Configuration=#{@CONFIG} #{@SOLUTION}"
end