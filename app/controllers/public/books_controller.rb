class Public::BooksController < ApplicationController
  before_action :authenticate_end_user!

  # RakutenWebService::Books::Bookにsearchメソッドを使い、引数にtitle:と指定することでタイトルで検索できる。
  def index
    if params[:keyword].present?
      @books = RakutenWebService::Books::Book.search(title: params[:keyword])
    end
  end

  def create
    book = RakutenWebService::Books::Book.search(isbn: params[:id])
    reference_book = ReferenceBook.new
    reference_book.isbn = params[:id]
    reference_book.end_user_id = current_end_user.id
    byebug
    reference_book.title = book.title
    reference_book.author = book.author
    reference_book.url = book.item_url
    reference_book.image_url = book.medium_image_url
  end

end
