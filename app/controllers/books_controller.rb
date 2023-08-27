class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @books = Book.all
    @book = Book.new
  end

  def new
    @book = current_user.books.build
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user

    if @book.save
      flash[:notice] = "Book successfully created."
      redirect_to book_path(@book)
    else
      flash[:error] = "Error creating book: Please check your input"
      render :new
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = current_user.books.find(params[:id])
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

  def book_params
    params.require(:book).permit(:title, :body, :image, :author, :other_attributes)
  end
end
