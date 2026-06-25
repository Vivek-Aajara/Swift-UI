//
//  ContentView.swift
//  Tic-Tac-
//
//  Created by admin on 23/06/26.
//

import SwiftUI

struct ContentView: View {

    @State private var board = Array(repeating: "", count: 9)
    @State private var isXTurn = true

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.black, .cyan, .gray],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {

                Text("Tic-Tac-Toe")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundStyle(.black)
                    .opacity(0.5)

                LazyVGrid(
                    columns: Array(repeating: GridItem(.flexible()), count: 3),
                    spacing: 15
                ) {
                    ForEach(0..<9, id: \.self) { index in

                        Button {
                            if board[index].isEmpty {
                                board[index] = isXTurn ? "xmark" : "circle"
                                isXTurn.toggle()
                            }
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(.white)
                                    .frame(width: 90, height: 90)

                                if !board[index].isEmpty {
                                    Image(systemName: board[index])
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .foregroundStyle(.black)
                                }
                            }
                            .opacity(0.5)
                        }
                    }
                }
                .padding()

                Text(isXTurn ? "X Turn" : "O Turn")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                    .opacity(0.5)

                Button {
                    resetGame()
                } label: {
                    Text("RESET")
                        .font(.system(size: 24,
                                      weight: .bold,
                                      design: .rounded))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 12)
                        .background(.black.opacity(0.4))
                        .clipShape(Capsule())
                }
            }
            .padding(30)
            .background(.ultraThinMaterial.opacity(0.4))
            .cornerRadius(30)
            .shadow(radius: 20)
            .padding()
        }
    }

    func resetGame() {
        board = Array(repeating: "", count: 9)
        isXTurn = true
    }
}

#Preview {
    ContentView()
}
