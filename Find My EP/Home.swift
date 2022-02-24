//
//  Home.swift
//  Find My EP
//
//  Created by 64000774 on 2/14/22.
//

import SwiftUI

struct Home: View {
    @State private var startID = ""
    @State private var endID = ""
    @State private var dist = 0
    @State private var hallways = ""
    @State private var inters = ""
    @State private var options = []
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading) {
                    TextField("Enter start room", text: $startID)
                        .multilineTextAlignment(.center)
                    TextField("Enter end room", text: $endID)
                        .multilineTextAlignment(.center)
                    NavigationLink(destination: DirectionsScreen(stuff: school.findPath(start: rooms[Int(startID) ?? 0], end: rooms[Int(endID) ?? 5]), start: Int(startID) ?? 0, end: Int(endID) ?? 5)) {
                        Text("Show Map")
                    }
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // 1
            .accentColor(Color.green)
        }
        
    }
}
