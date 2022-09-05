# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: '日報'
    assert_selector 'th', text: 'タイトル'
    assert_selector 'th', text: '作成者'
    assert_selector 'th', text: '作成日'
    assert_selector 'td', text: '学習100日目'
    assert_selector 'td', text: 'Bob'
    assert_selector 'td', text: Date.current.strftime('%Y/%m/%d').to_s
  end

  test 'users can edit or delete their own reports' do
    my_report = reports(:report_by_alice)
    Report.where.not(id: my_report.id).destroy_all
    visit reports_url
    assert_selector 'a', text: '詳細'
    assert_selector 'a', text: /^編集/
    assert_selector 'a[data-method=delete]', text: '削除'
  end

  test 'users cannot edit or delete the reports created by others' do
    his_report = reports(:report_by_bob)
    Report.where.not(id: his_report.id).destroy_all
    visit reports_url
    assert_selector 'a', text: '詳細'
    assert_no_selector 'a', text: /^編集/
    assert_no_selector 'a[data-method=delete]', text: '削除'
  end

  test 'creating a Report' do
    visit reports_url
    click_on '新規作成'

    fill_in 'タイトル', with: 'Railsがんばる'
    fill_in '内容', with: 'Railsのテストを書いています。'
    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text 'Railsがんばる'
    assert_text 'Railsのテストを書いています。'
  end

  test 'updating a Report from index screen' do
    visit reports_url
    click_on '編集', match: :prefer_exact

    fill_in 'タイトル', with: ''
    fill_in 'タイトル', with: '更新したタイトル'
    fill_in '内容', with: '更新した内容'
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text '更新したタイトル'
    assert_text '更新した内容'

    assert_no_text 'Rails'
    assert_no_text 'テストを書き進めた。もう一息！'
  end

  test 'updating a Report from its detail screen' do
    my_report = reports(:report_by_alice)

    visit report_url(my_report)
    click_on '編集', match: :prefer_exact

    fill_in 'タイトル', with: ''
    fill_in 'タイトル', with: '更新したタイトル'
    fill_in '内容', with: '更新した内容'
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text '更新したタイトル'
    assert_text '更新した内容'

    assert_no_text 'Rails'
    assert_no_text 'テストを書き進めた。もう一息！'
  end

  test 'destroying a Report' do
    visit books_url
    page.accept_confirm do
      click_on '削除', match: :first
    end

    assert_text '本が削除されました。'

    assert_no_text 'Rails'
    assert_no_text 'Alice'
  end
end
