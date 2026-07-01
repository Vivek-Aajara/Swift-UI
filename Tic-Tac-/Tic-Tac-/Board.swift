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
        VStack(spacing: 20){
            Text("Tic Tac toe")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.white)
            
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
                .foregroundStyle(.white)
        }
        .background(.black)
        .padding()
        
            
        
       
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
                    .frame( width: 85, height: 85, alignment: .center)
                    .foregroundStyle(.black)
            }
        }.onTapGesture{
            onTap()
    }
    }
    
}

#Preview{
    Board()
}
