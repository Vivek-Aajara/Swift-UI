//
//  ContentView.swift
//  ListDown
//
//  Created by Project on 07/07/26.
//

import SwiftUI

struct InputList: View {
    @AppStorage("firstName") private var userName: String = ""
    @State private var fruitsArr = [
        "Apples",
        "Oranges",
        "Coconut",
        "Raspberry",
        "Banana",
        "Blueberry",
        
    ]
    
    @State private var InputText: String = ""
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    ForEach(fruitsArr, id: \.self) {fruit in
//                        Text(fruit).frame(height: 40)
                        NavigationLink("\(fruit)", destination: DetailList(fruitName: fruit))
                    }.onDelete(perform: swipeToDelete)

                }
                .navigationTitle(userName.isEmpty ? "Fruits" :
                                    "Welcome\(userName)")
                .navigationBarTitleDisplayMode(.automatic)
                .foregroundColor(.green)
                
                TextField("Enter new Fruit", text: $InputText )
                    .onSubmit {
                        if !InputText.isEmpty{
                            fruitsArr.append(InputText)
                            InputText = ""
                        }
                            
                    }
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
