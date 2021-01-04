//
//  ContentView.swift
//  Bookworm
//
//  Created by Dave Spina on 12/31/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Book.author, ascending: true),
        NSSortDescriptor(keyPath: \Book.title, ascending: true)
    ]) var books: FetchedResults<Book>
   
    @State private var showAddSheet = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.self) { book in
                    NavigationLink(destination: DetailView(book: book)) {
                        
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                        
                        VStack(alignment: .leading) {
                            Text(book.title ?? "Unknown Title")
                                .foregroundColor(book.rating == 1 ? .red : .primary)
                            Text(book.author ?? "Unknown Author")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationBarTitle("BookWorm")
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    self.showAddSheet.toggle()
                }) {
                    Image(systemName: "plus")
                }
            ).sheet(isPresented: $showAddSheet) {
                AddBookView().environment(\.managedObjectContext, self.moc)
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        
        try? moc.save()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
