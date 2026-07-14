//
//  DetailList.swift
//  ListDown
//
//  Created by Project on 10/07/26.
//

import SwiftUI

struct DetailList: View {
    let fruitName: String
    var body: some View {
        VStack(spacing: 10){
            Text(fruitName).fontWeight(.bold)
            
            Image(fruitName).resizable().frame(width: 100, height: 100)
            
            Text  ("Your selected fruit is: \(fruitName)").foregroundStyle(.secondary)
        }.padding()
            .navigationTitle(fruitName)
    }
}

#Preview {
    NavigationStack{
        DetailList(fruitName: "Apple")
    }
}
