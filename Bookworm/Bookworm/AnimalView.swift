//
//  AnimalView.swift
//  Bookworm
//
//  Created by Dave Spina on 1/1/21.
//

import SwiftUI

struct AnimalView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Animal.entity(), sortDescriptors: []) var animals: FetchedResults<Animal>
    
    @State var newCommonName: String = ""
    @State var newPersonalName: String = ""
    @State var newAge: String = "0"
    @State var newSpecies: String = ""
    
    var body: some View {
        VStack {
            List {
                ForEach(animals, id: \.id) { animal in
                    HStack {
                        VStack {
                            Text(animal.commonName ?? "Unknown")
                                .font(.largeTitle)
                            Text(animal.species ?? "")
                                .italic()
                        }
                        Text(animal.personalName ?? "Unknown")
                            .font(.title)
                        Text("Age: \(animal.age)")
                            .font(.title)
                    }
                }
            }
            
            Form {
                Section {
                    TextField("Animal Common Name: ", text: $newCommonName)
                    TextField("Species: ", text: $newSpecies)
                    TextField("Personal Name ", text: $newPersonalName)
                    TextField("Age ", text: $newAge)
                        .keyboardType(.numberPad)
                }
            }
            
            Button("Add") {
                addNewAnimal()
                reset()
            }
        }
    }
    
    func addNewAnimal() {
        let animal = Animal(context: self.moc)
        animal.commonName = newCommonName
        animal.species = newSpecies
        animal.personalName = newPersonalName
        animal.id = UUID()
        animal.age =  Int16(newAge) ?? 0
        
        try? self.moc.save()
    }
    
    func reset() {
        self.newCommonName = ""
        self.newPersonalName = ""
        self.newSpecies = ""
        self.newAge = "0"
    }
    
}

struct AnimalView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalView()
    }
}
