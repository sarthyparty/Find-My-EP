import SwiftUI

struct Map: View {
    var stuff: (Int, [Hall], [Int])
    
    var body: some View {
        VStack(alignment: .leading) {
            Image("Map_GPS")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .background(Color.white)
            Text("Distance: " + String(stuff.0))
                .frame(maxWidth: .infinity, alignment: .center)
            Text(list_to_string(lst: stuff.2))
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    func list_to_string(lst: [Int]) -> String {
        var str = "Intersections: "
        for num in lst {
            str.append(String(num+1) + ", ")
        }
        return str
    }
}
