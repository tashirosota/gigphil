class Api::TimeTablesController < Api::ApplicationController

  def export_as_pdf
    # pdfを新規作成。インスタンスを渡す。
    pdf = Pdf.new
    send_data pdf.render,
              filename:    "sample.pdf",
              type:        "application/pdf",
              disposition: "inline" # 画面に表示。外すとダウンロードされる。
  end
end
