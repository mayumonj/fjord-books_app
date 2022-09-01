# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update destroy]

  def index
    @reports = Report.order(:id).page(params[:page])
  end

  def new
    @report = Report.new
  end

  def show; end

  def edit
    render403 unless current_user == @report.user
  end

  def create
    @report = Report.new(report_params)
    @report.user = current_user

    if @report.save
      redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      render :new
    end
  end

  def update
    if current_user == @report.user
      if @report.update(report_params)
        redirect_to @report, notice: t('controllers.common.notice_update', name: Report.model_name.human)
      else
        render :edit
      end
    else
      render403
    end
  end

  def destroy
    if current_user == @report.user
      @report.destroy
      redirect_to reports_url, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
    else
      render403
    end
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :text)
  end

  def render403
    render file: Rails.root.join('public/403.html'), layout: false, status: :forbidden
  end
end
