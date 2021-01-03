//
//  DetailView.swift
//  Bookworm
//
//  Created by Dave Spina on 1/2/21.
//

import SwiftUI
import CoreData

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showDeleteConfirmation: Bool = false
    
    let book: Book
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack {
                    Image(self.book.genre ?? "Fantasy")
                        .frame(maxWidth: geo.size.width)
                    Text(self.book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.7))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                
                Text(book.author ?? "Unknown Author")
                    .font(.title)
                    .foregroundColor(.secondary)
                Text(book.review ?? "No Review")
                    .padding()
                
                RatingView(rating: .constant(Int(book.rating)))
                    .font(.largeTitle)
            }
        }
        .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            self.showDeleteConfirmation = true
        }) {
            Image(systemName: "trash")
        })
        .alert(isPresented: $showDeleteConfirmation) {
            Alert(title: Text("Delete?"), message: Text("Are you sure you want to delete \(book.title ?? "Unknown")?"), primaryButton: .destructive(Text("Delete")) {
                deleteBook()
            }, secondaryButton: .cancel())
        }
    }
    
    func deleteBook() {
        self.moc.delete(book)
        try? self.moc.save()
        
        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test Title"
        book.author = "Author, Test"
        book.genre = "Fantasy"
        book.rating = 3
        book.review = "This is a great book. I highly recommend it."
        return NavigationView{DetailView(book: book)}
    }
}
