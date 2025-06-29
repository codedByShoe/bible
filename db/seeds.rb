# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require 'nokogiri'

puts "Starting Bible seeding process..."

# Path to the KJV.xml file
xml_file_path = Rails.root.join('KJV.xml')

unless File.exist?(xml_file_path)
  puts "ERROR: KJV.xml file not found at #{xml_file_path}"
  exit 1
end

puts "Loading and parsing KJV.xml..."
xml_content = File.read(xml_file_path)
doc = Nokogiri::XML(xml_content)

# Track progress
total_books = doc.xpath('//b').count
current_book_index = 0

puts "Found #{total_books} books to process"

# Parse each book
doc.xpath('//b').each do |book_element|
  current_book_index += 1
  book_name = book_element['n']
  
  puts "Processing book #{current_book_index}/#{total_books}: #{book_name}"
  
  # Create or find the book
  book = Book.find_or_create_by!(name: book_name) do |b|
    b.order_number = current_book_index
  end
  
  # Skip if book already has chapters (idempotent)
  if book.chapters.exists?
    puts "  Book already seeded, skipping..."
    next
  end
  
  # Process chapters for this book
  chapters_data = []
  verses_data = []
  
  book_element.xpath('.//c').each do |chapter_element|
    chapter_number = chapter_element['n'].to_i
    
    # Prepare chapter data
    chapter_data = {
      book_id: book.id,
      number: chapter_number,
      created_at: Time.current,
      updated_at: Time.current
    }
    chapters_data << chapter_data
  end
  
  # Bulk insert chapters
  Chapter.insert_all(chapters_data) if chapters_data.any?
  
  # Get the created chapters for verse association
  book_chapters = book.chapters.index_by(&:number)
  
  # Process verses for all chapters in this book
  book_element.xpath('.//c').each do |chapter_element|
    chapter_number = chapter_element['n'].to_i
    chapter = book_chapters[chapter_number]
    
    chapter_element.xpath('.//v').each do |verse_element|
      verse_number = verse_element['n'].to_i
      verse_text = verse_element.text.strip
      
      verses_data << {
        chapter_id: chapter.id,
        number: verse_number,
        text: verse_text,
        created_at: Time.current,
        updated_at: Time.current
      }
    end
  end
  
  # Bulk insert verses for this book
  if verses_data.any?
    Verse.insert_all(verses_data)
    puts "  Created #{chapters_data.size} chapters and #{verses_data.size} verses"
  end
  
  # Clear arrays for next book
  verses_data.clear
end

# Print final statistics
total_books_count = Book.count
total_chapters_count = Chapter.count
total_verses_count = Verse.count

puts "\n" + "="*50
puts "Bible seeding completed successfully!"
puts "="*50
puts "Books: #{total_books_count}"
puts "Chapters: #{total_chapters_count}"
puts "Verses: #{total_verses_count}"
puts "="*50
