desc "Runner"
task :runner, [:s, :name] => :environment do |t, args|
  g = QrGenerator.new
  s = args[:s]
  name = args[:name]
  if name.nil? or name.empty?
    name = s
  end

  g.generate_qr_code("tmp", s, name)
end
