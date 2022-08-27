# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable?' do
    me = User.create!(email: 'me@example.com', password: 'password')
    she = User.create!(email: 'she@example.com', password: 'password')
    my_report = Report.new(title: 'Rails', content: 'テストを書き進めた。もう一息！', user: me)

    assert_not my_report.editable?(she)
    assert my_report.editable?(me)
  end

  test '#created_on' do
    report = reports(:report_by_alice)
    report.created_at = DateTime.new(2002, 8, 1, 12, 30, 45)
    assert_equal Date.new(2002, 8, 1), report.created_on
  end
end
