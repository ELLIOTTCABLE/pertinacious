$LOAD_PATH.unshift(File.expand_path( File.join(File.dirname(__FILE__), 'lib') )).uniq!
require 'pertinacious'

require 'rubygems'

require 'rake'
require 'yard'
require 'spec/rake/spectask'
require 'spec/rake/verify_rcov'

require 'pp'

# Runs specs, generates rcov, and opens rcov in your browser.
namespace :rcov do
  Spec::Rake::SpecTask.new(:full) do |t|
    t.spec_opts = ["--format", "specdoc", "--colour"]
    t.spec_files = Dir['lib/pertinacious.rb'].sort
    t.libs = ['lib']
    t.rcov = true
    t.rcov_opts = ['--exclude-only', '".*"', '--include-file', '^lib']
    t.rcov_dir = :meta / :coverage
  end
  
  Spec::Rake::SpecTask.new(:plain) do |t|
    t.spec_opts = []
    t.spec_files = Dir['lib/pertinacious.rb'].sort
    t.libs = ['lib']
    t.rcov = true
    t.rcov_opts = ['--exclude-only', '".*"', '--include-file', '^lib']
    t.rcov_dir = :meta / :coverage
  end
  
  RCov::VerifyTask.new(:verify) do |t|
    t.threshold = 95
    t.index_html = :meta / :coverage / 'index.html'
    t.require_exact_threshold = false
  end

  task :open do
    system 'open ' + :meta / :coverage / 'index.html' if PLATFORM['darwin']
  end
end

namespace :yard do
  YARD::Rake::YardocTask.new :html do |t|
    t.files   = ['lib/**/*.rb']
    t.options = ['--readme', 'README.markdown', '--output-dir', 'meta/documentation']
  end
  
  task :ycov do
    YARD::Registry.load
    
    items = YARD::Registry.all
    num_items = items.size.to_f
    uncovered_items = YARD::Registry.all.select {|x| x.docstring.empty? }
    num_uncovered_items = uncovered_items.size.to_f
    num_covered_items = num_items - num_uncovered_items
    
    items_coverage = (num_covered_items / num_items) * 100
    items_coverage_string = items_coverage.to_s[/^(\d+.\d)/, 1]
    
    coverage_threshold = 95
    
    unless items_coverage > coverage_threshold
      puts "Documentation threshold is #{coverage_threshold.to_s}%, but yours is only #{items_coverage_string}% (#{num_covered_items.to_i}/#{num_items.to_i})"
      puts "Uncovered:"
      uncovered_items.each do |uncovered|
        puts " - #{uncovered.path} (#{uncovered.type})"
      end
      exit
    end
    puts "Documentation: #{items_coverage_string}% (threshold: #{coverage_threshold.to_s}%)"
  end
  
  task :open do
    system 'open ' + :meta / :documentation / 'index.html' if PLATFORM['darwin']
  end
end

namespace :ditz do
  
  desc "Show current issue status overview"
  task :status do
    system 'ditz status'
  end
  desc "Show currently open issues"
  task :todo do
    system 'ditz todo'
  end
  desc "Show recent issue activity"
  task :log do
    system 'ditz log'
  end
  
  # desc "Generate issues to meta/issues"
  task :html do
    # `'d instead of system'd, because I don't want that output cluttering shit
    `ditz html meta/issues`
  end
  # desc "Opens meta/issues in your main browser, if you are using a Macintosh"
  task :'html:open' do
    system 'open ' + :meta / :issues / 'index.html' if PLATFORM['darwin']
  end
  
  desc "Stage all issues to git (to be run before commiting, or just use aok)"
  task :stage do
    system 'git-add bugs/'
  end
end

desc 'Check everything over before commiting'
task :aok => [:'rcov:full', :'rcov:open', :'rcov:verify',
              :'yard:html', :'yard:open', :'yard:ycov',
              :'ditz:stage', :'ditz:html', :'ditz:todo', :'ditz:status', :'ditz:html:open']

# desc 'Task run during continuous integration'
task :cruise => [:'rcov:plain', :'ditz:html', :'yard:html', :'rcov:verify']

# By default, we just list the tasks.
task :default => :list
task :list do
  system 'rake -T'
end