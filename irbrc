# load global gemset for pry
if defined?(::Bundler)
  global_gemset = ENV['GEM_PATH'].split(':').grep(/ruby.*@global/).first
  if global_gemset
    all_global_gem_paths = Dir.glob("#{global_gemset}/gems/*")
    all_global_gem_paths.each do |p|
      gem_path = "#{p}/lib"
      $LOAD_PATH << gem_path
    end
  end
end

# load pry
require 'rubygems'
require 'pry'

# IRB-style evaluation output
#Pry.config.print = proc {| output, value| output.puts "=> #{value.inspect}" }

Pry.start
exit
