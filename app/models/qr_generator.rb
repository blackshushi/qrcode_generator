class QrGenerator
  def generate_from_excel(filename, sheet_name: nil, with_string: true)
    dir = "tmp/qr_codes_#{Time.zone.now.strftime("%Y-%m-%d")}"

    Dir.mkdir(dir) unless File.directory?(dir)

    file = Roo::Spreadsheet.open(filename)
    data = sheet_name ? file.sheet(sheet_name) : file

    content_index = data.first.index('Content')
    if content_index.nil?
      raise "Content is not defined in excel file, please define in first line as the column title"
    end

    (data.first_row + 1 .. data.last_row).each do |i|
      arr = data.row(i)
      qr_code_string = arr[content_index].to_s
      string = "#{arr[0]} - #{arr[content_index]}"

      generate_qr_code(dir, qr_code_string)
      if with_string
        add_string_under_image(dir, qr_code_string, string)
      end
   end
  end

  def generate_qr_code(dir,string)
    qr_code = RQRCode::QRCode.new(string)

    IO.binwrite("#{dir}/#{string}.png", qr_code.as_png(size: 600))
  end

  def add_string_under_image(dir, qr_code_filename, string)
    img = Magick::Image.read("#{dir}/#{qr_code_filename}.png").first
    
    img_string = Magick::Draw.new
    img_string.annotate(img, 0, 0, -2, -2, string) do 
      self.font = 'helvetica'
      self.pointsize = 30
      self.gravity = Magick::SouthGravity
      self.font_weight = Magick::BoldWeight
      self.fill = 'black'
    end

    img.write("#{dir}/#{qr_code_filename}.png")
  end
end
