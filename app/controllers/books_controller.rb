class BooksController < ApplicationController
  before_action :authenticate_user!
  def index
    @newbook = Book.new
    @books = Book.all
    @user = current_user
  end

  def create
    @newbook =Book.new(book_params)
    @newbook.user_id = current_user.id
    if @newbook.save
       redirect_to book_path(@newbook.id)
       flash[:notice] = "Book was successfully created."
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end
  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end
  def edit
    @book = Book.find(params[:id])
    redirect_to books_path unless current_user.id == @book.user_id
  end

  def update
     @book = Book.find(params[:id])
    if @book.update(book_params)
       redirect_to book_path(@book.id)
       flash[:notice] = "Book was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
