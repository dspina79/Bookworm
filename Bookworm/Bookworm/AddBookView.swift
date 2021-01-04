//
//  AddBookView.swift
//  Bookworm
//
//  Created by Dave Spina on 1/1/21.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = ""
    @State private var rating = 3
    @State private var review = ""
    
    private var genres = ["Fantasy", "Horror", "Kids", "Thriller", "Nonfiction", "Poetry", "Romance", "Sci-fi", "Other"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }
                Section {
                    RatingView(rating: $rating, label: "Rating")
                    TextField("Review", text: $review)
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(context: self.moc)
                        newBook.id = UUID()
                        newBook.title = self.title
                        newBook.author = self.author
                        newBook.review = self.review
                        newBook.rating = Int16(self.rating)
                        newBook.genre = self.genre
                        newBook.dateRated = Date()
                        
                        try? moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
