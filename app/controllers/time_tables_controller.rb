class TimeTablesController < ApplicationController
<<<<<<< HEAD
  def new
    @time_table = TimeTable.default_hash
  end

  def edit
    @time_table = TimeTable.find_by!(uuid: params[:uuid]).to_hash
  end

  def share
    @time_table = TimeTable.find_by!(uuid: params[:uuid]).to_hash
  end

  # 保存はここのみで行う
  def create
  params[:time_table]
=======
  def show; end

  def export_as_pdf
    # pdfを新規作成。インスタンスを渡す。
    pdf = Pdf.new(params[:timeTable])
    send_data pdf.render,
              type: 'application/pdf',
              disposition: 'inline' # 画面に表示。外すとダウンロードされる。
>>>>>>> master
  end
end
