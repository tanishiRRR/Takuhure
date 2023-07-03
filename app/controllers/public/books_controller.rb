class Public::BooksController < ApplicationController
  before_action :authenticate_end_user!

  # 他人には扱うことができないようにする設定
  before_action :end_user_scan, only: [:update, :destroy]

  # RakutenWebService::Books::Bookにsearchメソッドを使い、引数にtitle:と指定することでタイトルで検索できる。
  def index
    # キーワードを入力したときに、それに該当する書籍の情報を楽天ブックスAPIから取得する
    if params[:keyword].present?
      @books = RakutenWebService::Books::Book.search(title: params[:keyword])
    else
      flash.now[:warning] = 'キーワードを入力してください'
      render :index
    end
  end

  def create
    # 選択した書籍のisbnから、該当する書籍の情報を取得する
    book = RakutenWebService::Books::Book.search(isbn: params[:id])
    # 該当する書籍がない場合の処理
    if book.count < 1
      redirect_to books_path, warning: 'データが見つかりませんでした'
    # 該当する書籍がある場合の処理
    # データはJSON形式(JavaScriptのオブジェクト表記法に由来するデータの記述方式)であり、配列の配列で帰ってくるため、firstをつけることにより取り出す配列を指定する
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

    def end_user_scan
      unless current_end_user
        redirect_to end_users_my_page_path
      end
    end

end
