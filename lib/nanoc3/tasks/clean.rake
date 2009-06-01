# encoding: utf-8

desc 'Remove output files generated by nanoc3'
task :clean do
  # Load site
  site = Nanoc3::Site.new(YAML.load_file(File.join(Dir.getwd, 'config.yaml')))
  if site.nil?
    $stderr.puts 'The current working directory does not seem to be a ' +
                 'valid/complete nanoc site directory; aborting.'
    exit 1
  end

  # Clean
  clean = ::Nanoc3::Tasks::Clean.new(site)
  clean.run
end
