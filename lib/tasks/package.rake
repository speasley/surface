namespace :package do
  desc "create a build package"
  task :build => "assets:precompile" do
    require "rake/packagetask"

    version = DateTime.now.utc.strftime("%Y-%m-%d-%H-%M-%S")
    Rake::PackageTask.new("stronglifters", version) do |package|
      package.need_tar_gz = true
      package.package_files.add %w(
      app/**/*
      config/**/*
      db/**/*
      lib/**/*
      public/**/*
      bin/**/*
      Gemfile
      Gemfile.lock
      README.md
      Rakefile
      Procfile
      config.ru
      )
      package.package_files.exclude do |path|
        path.start_with?("app/assets/") || path.start_with?("config/deploy")
      end
    end
    Rake::Task["repackage"].invoke
    FileUtils.rm_rf(File.join(Rails.root, 'pkg', "stronglifters-#{version}"))
  end
end