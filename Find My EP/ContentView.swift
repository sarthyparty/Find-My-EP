//
//  ContentView.swift
//  Find My EP
//
//  Created by 64000774 on 2/2/22.
//

import SwiftUI

struct ContentView: View {
    var calc = school.shortestPath(start: intersects[0], end: intersects[3], visited: [])
    var body: some View {
        Text(String(calc))
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
