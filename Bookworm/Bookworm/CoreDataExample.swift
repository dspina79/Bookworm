//
//  CoreDataExample.swift
//  Bookworm
//
//  Created by Dave Spina on 12/31/20.
//

import SwiftUI

struct CoreDataExample: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students : FetchedResults<Student>
    var body: some View {
        VStack {
            List {
                ForEach(students, id: \.id) { student in
                    // student.name is an optional...
                    Text(student.name ?? "Unknown Student")
                }
            }
            
            Button("Add") {
                let firstNames = ["Steve", "Peter", "Veronica", "Archie", "Richie", "Clark", "Lois", "Lana", "Mary Jane"]
                let lastNames = ["Rogers", "Parker", "Milton", "Mayberry", "Rich", "Kent", "Lane", "Lang", "Watson", "Wayne", "Thurman"]
                
                let firstName = firstNames.randomElement()! // produces an optional element
                let lastName = lastNames.randomElement()!

                // Managed Object CONTEXT
                let student = Student(context: self.moc)
                student.id = UUID()
                student.name = "\(firstName) \(lastName)"
                
                try? self.moc.save()
            }
            
            Button("Clear All") {
                for s in students {
                    self.moc.delete(s)
                }
                try? self.moc.save()
            }
        }
    }
}

struct CoreDataExample_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataExample()
    }
}
