class TimeTablesController < ApplicationController
  def show; end

  def export_as_pdf
    # pdfを新規作成。インスタンスを渡す。
    pdf = Pdf.new(params[:timeTable])
    send_data pdf.render,
              type: 'application/pdf',
              disposition: 'inline' # 画面に表示。外すとダウンロードされる。
  end
end
