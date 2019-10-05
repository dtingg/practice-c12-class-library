class BooksController < ApplicationController
  def index
    @books = Book.all
  end
  
  def show
    @book = Book.find_by(id: params[:id])
    
    if @book.nil?
      head :not_found
      return
    end
  end
  
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new(author: params[:book][:author], title: params[:book][:title], description: params[:book][:description]) #instantiate a new book
    if @book.save 
      redirect_to root_path 
      return
    else 
      render :new 
      return
    end
  end
  
  def edit
    @book = Book.find_by(id: params[:id])
    
    if @book.nil?
      head :not_found
      return
    end
  end
  
  def update
    @book = Book.find_by(id: params[:id])
    if @book.update(
      author: params[:book][:author], 
      title: params[:book][:title], 
      description: params[:book][:description]) 
      redirect_to root_path 
      return
    else 
      render :edit 
      return
    end
  end
  
  def destroy
    @book = Book.find_by(id: params[:id])
    
    if @book.nil?
      head :not_found
      return
    else
      @book.destroy
      redirect_to root_path
    end
  end
end