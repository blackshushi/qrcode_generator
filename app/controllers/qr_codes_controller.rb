class QrCodesController < ApplicationController
  def index
  end

  def generate
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
end
