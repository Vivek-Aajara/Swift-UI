//
//  Board.swift
//  Tic-Tac-
//
//  Created by admin on 01/07/26.
//

import SwiftUI

struct Board: View {
    @State private var board: [Bool?] = Array(repeating: nil, count: 9)
    @State private var isXTurn = true
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
        ]
    
    var body: some View {
        ZStack{LinearGradient(
            colors: [.black, .cyan, .gray],
            startPoint: .top,
            endPoint: .bottom
        )
            VStack{
                Text("Tic Tac Toe")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.black)
                    .opacity(0.5)
                
                LazyVGrid(columns: columns, spacing: 12){
                    ForEach(0..<9, id: \.self){
                        index in BoardCall(value: board[index]){
                            hendleTap(at: index)
                        }
                    }
                }.padding()
                
                
                Button("Restart Game"){
                    board = Array(repeating: nil, count: 9)
                    isXTurn = true
                }.font(.headline)
                 .foregroundStyle(.black)
                 .frame(width: 60, height: 80)
                 .opacity(0.5)
            }
            .padding()
            .background(.ultraThinMaterial.opacity(0.2))
            .cornerRadius(55)
            .shadow(radius: 100)
        }
        .ignoresSafeArea()
            
        
       
    }
    func hendleTap(at index: Int){
        guard board[index] == nil else{return}
        board[index] = isXTurn
                isXTurn.toggle()
    }
}

struct BoardCall: View {
    let value:Bool?
    let onTap: ()-> Void
    
    var body: some View{
        ZStack{
            Circle().fill(Color.white).frame(width: 80, height: 80)
            if let value = value{
                Image(systemName: value ? "circle": "x.circle")
                    .resizable()
                    .scaledToFit()
                    .frame( width: 80, height: 80, alignment: .center)
                    .foregroundStyle(.black)
            }
        }
        .padding()
        .opacity(0.5)
        .onTapGesture{
            onTap()
    }
    }
    
}

#Preview{
    Board()
}
