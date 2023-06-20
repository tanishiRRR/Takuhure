class Public::BooksController < ApplicationController
  before_action :authenticate_end_user!

  def new
  end

  # RakutenWebService::Books::Bookにsearchメソッドを使い、引数にtitle:と指定することでタイトルで検索できる。
  def index
    if params[:keyword]
      @books = RakutenWebService::Books::Book.search(title: params[:keyword])
    end
  end

end
