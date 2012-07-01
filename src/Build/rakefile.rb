desc "the default task"
task :default => [:firstTask, :secondTask]

task :firstTask do
	puts "this is the first task."
end

task :secondTask do
	puts "this is the second task."
end