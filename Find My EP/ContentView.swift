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
        ZStack {
            Color .white
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                TextField("Enter start ID (0-5)", text: $startID)
                    .multilineTextAlignment(.center)
                TextField("Enter end ID (0-5)", text: $endID)
                    .multilineTextAlignment(.center)
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
                .frame(maxWidth: .infinity)
                Image("Map_GPS")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text(String(dist))
                    .frame(maxWidth: .infinity, alignment: .center)
                Text(hallways)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text(inters)
                    .frame(maxWidth: .infinity, alignment: .center)
        VStack(alignment: .leading) {
            TextField("Enter start room (10-19)", text: $startID)
            TextField("Enter end room (10-19)", text: $endID)
            Button("Calculate") {
                let start_int = Int(startID) ?? -1
                let end_int = Int(endID) ?? -1
                if (start_int < 10 || start_int > 19) || (end_int < 10 || end_int > 19) {
                    inters = "Please enter a valid room number"
                    return;
                }
                let res = school.findPath(start: rooms[start_int-10], end: rooms[end_int-10])
                dist = res.dist
                hallways = ""
                for hall in res.halls {
                    hallways+=String(hall.id) + ", "
                }
                hallways = "Hallway IDs (Reversed): " + hallways
                inters = ""
                for inter in res.inters {
                    inters+=String(inter + 1) + ", "
                }
                inters = "Intersection to cross: " + inters
                
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
