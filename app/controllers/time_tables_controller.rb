class TimeTablesController < ApplicationController
  skip_before_action :authenticate!, only: %i(new export_as_pdf share)
  def index
    @time_tables = current_user.time_tables
  end

  def edit
    @time_table = TimeTable.find_by!(uuid: params[:uuid]).to_model
  end

  # 保存はここのみで行う
  def updae; end

  # 下記は認証必要なし
  
  def new
    @time_table = TimeTable.new_model
  end

  def export_as_pdf
    # pdfを新規作成。インスタンスを渡す。
    pdf = Pdf.new(params[:timeTable])
    send_data pdf.render,
              type: 'application/pdf',
              disposition: 'inline' # 画面に表示。外すとダウンロードされる。
  end

  def share
    @time_table = TimeTable.find_by!(uuid: params[:uuid]).to_model
  end
end
