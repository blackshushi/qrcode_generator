class QrCodesController < ApplicationController
  def index
  end

  def generate
    @title = params[:title]
    @qr_code_text = params[:text]
    if !@qr_code_text.present?
      redirect_to root_path, alert: 'Please enter text to generate QR code'
      return
    end

    @qr = RQRCode::QRCode.new(@qr_code_text)
    @qr_svg = @qr.as_svg(
      color: '000',
      fill: 'fff',
      shape_rendering: 'crispEdges',
      module_size: 16,
      standalone: true
    )
  end

  def download
    title = params[:title]
    qr_code_text = params[:text]
    if !qr_code_text.present?
      redirect_to root_path, alert: 'Please enter text to generate QR code'
      return
    end

    qr = RQRCode::QRCode.new(qr_code_text)
    png_data = qr.as_png(
      size: 600,
      color: '#000000',
      fill: '#ffffff',
      module_size: 16
    )

    filename = "QRGenerator_#{title}.png"
    
    send_data png_data, 
              type: 'image/png', 
              disposition: 'attachment', 
              filename: filename
  end
end
