$LOAD_PATH.unshift(File.expand_path( File.join(File.dirname(__FILE__), 'lib') )).uniq!
require 'pertinacious'

require 'rubygems'

require 'rake'
require 'rake/rdoctask'
require 'spec/rake/spectask'
require 'spec/rake/verify_rcov'

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
    t.threshold = 96.8
    t.index_html = :meta / :coverage / 'index.html'
  end

  task :open do
    system 'open ' + :meta / :coverage / 'index.html' if PLATFORM['darwin']
  end
end

namespace :rdoc do
  Rake::RDocTask.new :html do |rd|
     rd.main = "README"
     rd.rdoc_dir = :meta / :documentation
     rd.rdoc_files.include("lib/**/*.rb")
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
              :'rdoc:html', :'rdoc:open',
              :'ditz:stage', :'ditz:html', :'ditz:todo', :'ditz:status', :'ditz:html:open']

# desc 'Task run during continuous integration'
task :cruise => [:'rcov:plain', :'ditz:html', :'rcov:verify', :'rdoc:html']

# By default, we just list the tasks.
task :default => :list
task :list do
  system 'rake -T'
end