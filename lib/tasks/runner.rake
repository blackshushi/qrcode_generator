desc "Runner"
task :runner, [:s, :name] => :environment do |t, args|
  g = QrGenerator.new
  s = ENV["MESSAGE"].presence || args[:s]
  name = ENV["FILENAME"].presence || args[:name]
  raise "Missing message (set MESSAGE or pass runner[message,...])" if s.blank?

  name = s if name.blank?

  fmt = ENV["QR_FORMAT"].to_s.downcase
  output_format = (fmt == "svg") ? :svg : :png

  g.generate_qr_code("tmp", s, name, output_format: output_format)
end

task :wifi_qr_generator, [:username, :password, :filename] => :environment do |t, args|
  g = QrGenerator.new
  username = ENV["USERNAME"].presence || args[:username]
  password = ENV["PASSWORD"].presence || args[:password]
  filename = ENV["FILENAME"].presence || args[:filename]

  g.generate_wifi_code(username, password, filename: filename)
end
