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
    if book.count < 1
      redirect_to books_path, warning: 'データが見つかりませんでした'
    else
      reference_book = ReferenceBook.new
      # reference_book.isbnがidと被ってしまうためisbnについては記載しない
      # reference_book.isbn = params[:id]
      reference_book.end_user_id = current_end_user.id
      reference_book.title = book.first.title
      reference_book.author = book.first.author
      reference_book.url = book.first.item_url
      reference_book.image_url = book.first.large_image_url
      reference_book.progress = 0
      reference_book.save
      redirect_to end_users_my_page_path, success: '参考書を保存しました'
    end
  end

  def update
    reference_book = ReferenceBook.find(params[:id])
    if reference_book.update(reference_book_params)
      redirect_to end_users_my_page_path, success: '進捗度を更新しました'
    else
      redirect_to end_users_my_page_path, warning: '進捗度は0～100を選択してください'
    end
  end

  def destroy
    reference_book = ReferenceBook.find(params[:id])
    reference_book.destroy
    redirect_to end_users_my_page_path, danger: '参考書を削除しました'
  end

  private
    def reference_book_params
      params.require(:reference_book).permit(:progress)
    end

end
