require "bundler/gem_tasks"

desc 'Bump version'
task :bump do
  if `git status -uno -s --porcelain | wc -l`.to_i > 0
    abort "You have uncommitted changed."
  end
  text = File.read('lib/pingable/version.rb')
  if text =~ /VERSION = ['"](.*)['"]/
    old_version = $1
    version_parts = old_version.split('.')
    version_parts[-1] = version_parts[-1].to_i + 1
    new_version = version_parts.join('.')
    text.gsub!(/VERSION = ['"](.*)['"]/, "VERSION = '#{new_version}'")
    File.open('lib/pingable/version.rb', 'w') { |f| f << text }
    (system("git add lib/pingable/version.rb") and
      system("git commit -m 'Bump to #{new_version}.'")) or abort "Failed to commit."
  else
    abort "Could not find version number"
  end
end
