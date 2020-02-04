class TimeTablesController < ApplicationController
  skip_before_action :authenticate!, only: %i(new export_as_pdf share)
  skip_before_action :snakeize_params, only: :export_as_pdf

  def index
    @time_tables = current_user.time_tables.includes(:concerts).order(updated_at: :desc)
  end

  def edit
    @time_table = TimeTable.find_by!(uuid: params[:uuid]).to_model
  end

  # 保存はここのみで行う
  def create
    create_or_update!
    render json: { uuid: @time_table.uuid }
  end

  def destroy
    TimeTable.find_by!(uuid: params[:uuid]).destroy!
    redirect_to time_tables_path, secondary: '削除しました'
  end

  def copy
    TimeTable.copy!(params[:uuid])
    redirect_to time_tables_path, secondary: 'コピーしました'
  end

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

  private

  # rubocop:disable Metrics/AbcSize
  def create_or_update!
    TimeTable.transaction do
      @time_table = current_user.time_tables.find_or_initialize_by(uuid: params[:time_table][:uuid])
      @time_table.attributes = time_table_params
      @time_table.set_uuid
      @time_table.save!
      @time_table.rehearsals.destroy_all
      @time_table.rehearsals.create! rehearsal_params
      @time_table.concerts.destroy_all
      @time_table.concerts.create! concert_params
    end
  end
  # rubocop:enable Metrics/AbcSize

  def time_table_params
    params.require(:time_table).permit(:title,
                                       :place,
                                       :memo,
                                       :event_date,
                                       :meeting_time,
                                       :open_time,
                                       :start_time,
                                       :rehearsal_setting_time,
                                       :rehearsal_play_time,
                                       :production_setting_time,
                                       :production_play_time)
  end

  def rehearsal_params
    params.require(:time_table).fetch(:rehearsals, []).map do |b|
      b.permit(
        :order,
        :band_name,
        :custom_play_time,
        :custom_setting_time,
        :memo
      )
    end
  end

  def concert_params
    params.require(:time_table).fetch(:concerts, []).map do |b|
      b.permit(
        :order,
        :band_name,
        :custom_play_time,
        :custom_setting_time,
        :memo
      )
    end
  end
end
