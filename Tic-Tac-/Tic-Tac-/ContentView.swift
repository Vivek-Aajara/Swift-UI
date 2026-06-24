//
//  ContentView.swift
//  Tic-Tac-
//
//  Created by admin on 23/06/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            
            Color.blue
                .ignoresSafeArea()
            
            VStack {
                CallView()
                CallView()
                CallView()
            }
            .padding()
        }
        
            
    }
}

struct CallView: View {
    var body: some View {
        HStack{
            ForEach(0..<3){ _ in
                ZStack{
                    Circle()
                        .foregroundStyle(.white)
                    Image(systemName: "circle")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                }
                
            }
        }.padding()
    }
}


#Preview {
    ContentView()
}

