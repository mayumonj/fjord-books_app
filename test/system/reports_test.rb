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
