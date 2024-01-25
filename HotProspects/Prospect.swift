//
//  Prospect.swift
//  HotProspects
//
//  Created by Zach Mommaerts on 1/11/24.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    let url = URL.documentsDirectory.appending(path: "SavedData")
    
    init() {
        if let savedData = try? Data(contentsOf: url) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: savedData) {
                people = decoded
                return
            }
        }
        
        //no Saved Data
        people = []
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            try? encoded.write(to: url, options: [.atomic, .completeFileProtection])
        }
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}
