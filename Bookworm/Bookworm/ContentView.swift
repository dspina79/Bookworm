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
    @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>
   
    @State private var showAddSheet = false
    
    var body: some View {
        NavigationView {
            Text("Current books in library: \(books.count)")
                .navigationBarTitle("BookWorm")
                .navigationBarItems(trailing:
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

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
