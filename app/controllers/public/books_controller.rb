class Public::BooksController < ApplicationController
  before_action :authenticate_end_user!

  def new
  end

  def index
    if params[:keyword]
      @books = RakutenWebService::Books::Book.search(title: params[:keyword])
    end
  end

end
