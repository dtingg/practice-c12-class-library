require "test_helper"

describe BooksController do
  
  describe "Index" do
    it "can render the index" do
      get "/books"
      must_respond_with :success
    end
  end
  
  describe "Show" do
    it "can render an extant book" do
      valid_book = Book.create(author: "Devin", title: "Cool")
      get book_path(valid_book.id)
      
      must_respond_with :success
    end
    
    it "responds 'not found' for an non-existant book" do
      get "/books/5000000"
      must_respond_with :not_found
    end
  end
  
  describe "create" do
    it "can create a book!" do
      # Arrange
      test_params = {
        book: {
          title: "Cat in the Hat",
          author: "Dr. Seuss",
          description: "Tricksy cat!"
        }
      } 
      # Act
      expect {
        post books_path, params: test_params
        # Assert
      }.must_differ 'Book.count', 1
      
      new_book = Book.find_by(title: "Cat in the Hat")
      expect(new_book).wont_be_nil
      must_redirect_to root_path
    end
  end
  
  describe "update action" do
    before do
      @new_book = Book.create(title: "new book")
    end
    
    it "updates an existing book successfully and redirects to home" do
      existing_book = Book.first
      updated_book_form_data = {
        book: {
          title: "Cat in the Hat",
          author: "Dr. Seuss",
          description: "Children's book"
        }
      }
      expect { patch book_path(existing_book.id), params: updated_book_form_data }.wont_change "Book.count"
      expect(Book.find_by(id: existing_book.id).title).must_equal "Cat in the Hat"
      
    end
  end
end
