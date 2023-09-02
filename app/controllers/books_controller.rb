class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def index
    @books = Book.all
    @book = Book.new
    @book.user_id = current_user.id
  end

  def new
    @book = current_user.books.build
  end

  def create
    @book = Book.new(book_params)

    @book.user_id = current_user.id

    if @book.save
      flash[:notice] = "Book successfully created."
      redirect_to book_path(@book.id)
    else
      flash[:error] = "Error creating book: Please check your input"
      @books = Book.all
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = current_user.books.find_by(id: params[:id])

    if @book.user != current_user
      flash[:error] = "You don't have permission to edit this book."
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    puts "Book Params: #{params[:book]}"
    if @book.update(book_params)
      flash[:success] = "Book successfully updated!"
      redirect_to @book
    else
      flash[:error] = "Error updating book: Please check your input"
      render :edit
    end
  end

  def destroy
    @book = current_user.books.find(params[:id])
    @book.destroy
    redirect_to books_url, notice: 'Book was successfully destroyed.'
  end

  private
  
  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
      unless @book.user == current_user
      redirect_to(books_path)
      end
  end


  def book_params
    params.require(:book).permit(:title, :body, :posts)
  end
end
