//
//  ContentView.swift
//  ListDown
//
//  Created by Project on 07/07/26.
//

import SwiftUI

struct InputList: View {
    @AppStorage("firstName") private var userName: String = "Vivek"
    @State private var fruitsArr = [
        "Apples",
        "Oranges",
        "Coconut",
        "Raspberry",
        "Banana",
        "Coldwater",
        "Blueberry",
    ]
    @State private var InputText: String
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(fruitsArr, id: \.self) {fruit in
                        Text(fruit).frame(height: 40)
                    }.onDelete(perform: swipeToDelete)

                }
                .navigationTitle(userName.isEmpty ? "Welcome \(userName)" :("Fruits"))
                .navigationBarTitleDisplayMode(.automatic)
                .foregroundColor(.green)
                
                TextField("Enter new Fruit", text: $InputText )
                    .onSubmit {
                        fruitsArr.append(InputText)
                            
                    }
            }.onTapGesture {
                print("tapped")
            }
        }
    }
    
    private func swipeToDelete(at: IndexSet){
        fruitsArr.remove(atOffsets: at)
        print(fruitsArr)
    }
}



#Preview {
    InputList()
}
