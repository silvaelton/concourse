class CandidatesController < ApplicationController
  before_action :set_subscribe, only: [:show_subscribe, :bank_slip]

  def subscribes
    @subscribes = current_user.candidate_subscribes
  end

  def show_subscribe
  end

  def participations
  end

  def show_participation
  end

  def bank_slip

    require 'barby'
    require 'barby/barcode/qr_code'
    require 'barby/barcode/code_25_interleaved'
    require 'barby/outputter/png_outputter'

    @deadline = Time.now
    @value = 0.01
    @unique_code = 661749

    @bank_slip = BankSlip.new({
      value: @value,
      #deadline: (@subscribe.project_subscribe.end - 3.days).strftime('%Y-%m-%d'),
      deadline: @deadline.strftime('%Y-%m-%d'),
      unique_code: @unique_code
    })

    qrcode = Barby::QrCode.new(@bank_slip.barcode_with_all_digit)
    barcode = Barby::Code25Interleaved.new(@bank_slip.barcode_with_all_digit)

    @qr_code  = "#{@deadline.strftime('%Y%m%d')}_barcode_#{current_user.id}#{@subscribe.id}"
    @bar_code = "#{@deadline.strftime('%Y%m%d')}_qrcode_#{current_user.id}#{@subscribe.id}"
    
    File.open("public/images/#{@bar_code}.png", 'w'){|f| f.write barcode.to_png(height: 50, margin: 0) }
    File.open("public/images/#{@qr_code}.png", 'w'){|f| f.write qrcode.to_png(xdim: 4, width: 10, height: 40, margin: 1) }

    render layout: 'layouts/show_bank_slip'
  end


  private

  def set_subscribe
    @subscribe = current_user.candidate_subscribes.find(params[:id])
  end
  
end
