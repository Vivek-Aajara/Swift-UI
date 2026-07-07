//
//  ContentView.swift
//  ListDown
//
//  Created by Project on 07/07/26.
//

import SwiftUI

struct ContentView: View {
    @State private var fruitsArr = [
        "Apples",
        "Oranges",
        "Coconut",
        "Raspberry",
        "Banana",
        "Coldwater",
        "Blueberry",
        "",
        "",
        "",
    ]
    var body: some View {
        NavigationView{
            List{
                ForEach(fruitsArr, id: \.self) {
                    fruit in Text(fruit)
                }.onDelete(perform: swipeToDelete)
                    
                }
            .navigationTitle("Fruits")
            .navigationBarTitleDisplayMode(.automatic)
            .foregroundColor(.green)
        }
    }
    
    private func swipeToDelete(at: IndexSet){
        fruitsArr.remove(atOffsets: at)
        print(fruitsArr)
    }
}



#Preview {
    ContentView()
}
