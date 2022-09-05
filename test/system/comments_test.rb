# frozen_string_literal: true

require 'application_system_test_case'

class CommentsTest < ApplicationSystemTestCase
  setup do
    @book = books(:cherry_book)
    @my_report = reports(:report_by_alice)
    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test 'creating a Comment for a book' do
    visit book_url(@book)

    fill_in 'comment_content', with: '本にコメントしました！'
    click_on 'コメントする'

    assert_text 'コメントが投稿されました。'
    assert_text '本にコメントしました！'
  end

  test 'creating a Comment for a report' do
    visit report_url(@my_report)

    fill_in 'comment_content', with: '日報にコメントしました！'
    click_on 'コメントする'

    assert_text 'コメントが投稿されました。'
    assert_text '日報にコメントしました！'
  end
end
