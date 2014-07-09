namespace :nine do
  desc "Run ps on Ninefold's terminal"
  task :ps, [:command] => :environment do |t, args|
    args.with_defaults(:command => "ps -e")
    exec("#{args.command}")
  end

  desc "Run kill on Ninefold's terminal"
  task :kill => :environment do
    exec("killall ruby2.1.2")
  end

  desc "Run ls on Ninefold's terminal"
  task :ls => :environment do
    exec("ls")
  end
end
