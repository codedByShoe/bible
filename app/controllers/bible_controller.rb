class BibleController < ApplicationController
  allow_unauthenticated_access

  # GET /bible/books
  def index
    @books = Book.ordered
  end

  def chapters
    @book = Book.find(params[:book_id])
    @chapters = @book.chapters
  end

  def verses
    @chapter = Chapter.find(params[:chapter_id])
    @verses = @chapter.verses
  end
end
