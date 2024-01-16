//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Zach Mommaerts on 1/11/24.
//

import SwiftUI

struct ProspectsView: View {
    enum filterType {
        case none, contacted, uncontacted
    }
    
    @EnvironmentObject var prospects: Prospects
    let filter: filterType
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.emailAddress)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                Button {
                    let prospect = Prospect()
                    prospect.name = "Zach Mommaerts"
                    prospect.emailAddress = "zmommaerts@gmail.com"
                    prospects.people.append(prospect)
                } label: {
                    Label("Scan", systemImage: "qrcode.viewfinder")
                }
            }
        }
    }
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter{ $0.isContacted }
        case .uncontacted:
            return prospects.people.filter{ !$0.isContacted }
        }
    }
}

#Preview {
    ProspectsView(filter: .none)
        .environmentObject(Prospects())
}
