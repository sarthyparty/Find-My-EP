//
//  ContentView.swift
//  Find My EP
//
//  Created by 64000774 on 2/2/22.
//

import SwiftUI

struct ContentView: View {
    @State private var startID = ""
    @State private var endID = ""
    @State private var dist = 0
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Enter start ID (0-5)", text: $startID)
            TextField("Enter end ID (0-5)", text: $endID)
            Button("Calculate") {
                dist = school.shortestPath(start: intersects[Int(startID) ?? 0], end: intersects[Int(endID) ?? 5], visited: [Int(startID) ?? 0]).dist
            }
            Text(String(dist))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
