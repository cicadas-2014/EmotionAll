namespace :nine do
  desc "Run a command on Ninefold's terminal"
  task :run, [:command] => :environment do |t, args|
    args.with_defaults(:command => "ps -e")
    exec("#{args.command}")
  end
end
