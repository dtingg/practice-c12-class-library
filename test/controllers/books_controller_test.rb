require "test_helper"

describe BooksController do
  describe "Index method" do
    it "can render the index" do
      get "/books"
      must_respond_with :success
    end
  end
  
  describe "Show method" do
    it "can show the page for a single book" do
      get "/books/1"
      must_respond_with :success
    end
    
    it "returns not found if book doesn't exist" do
      get "/books/50"
      must_respond_with :not_found
    end
  end
end
