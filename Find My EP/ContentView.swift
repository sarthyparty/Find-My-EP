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
    @State private var hallways = ""
    @State private var inters = ""
    @State private var options = []
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Enter start ID (0-5)", text: $startID)
            TextField("Enter end ID (0-5)", text: $endID)
            Button("Calculate") {
                let res = school.findPath(start: rooms[Int(startID) ?? 0], end: rooms[Int(endID) ?? 5])
                dist = res.dist
                hallways = ""
                for hall in res.halls {
                    hallways+=String(hall.id) + ", "
                }
                hallways = "Hallway IDs (Reversed): " + hallways
                inters = ""
                for inter in res.inters {
                    inters+=String(inter) + ", "
                }
                inters = "Intersection IDs: " + inters
                print(school.halls)
                
            }
            Image("Map_GPS")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(String(dist))
            Text(hallways)
            Text(inters)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
