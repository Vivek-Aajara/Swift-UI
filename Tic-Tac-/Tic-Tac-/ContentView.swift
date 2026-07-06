import SwiftUI

struct myCode: View {

    @State private var board = Array(repeating: "", count: 9)
    @State private var isXTurn = true
    @State private var winningPattern: [Int] = []
    @State private var gameOver = false
    @State private var statusText = "X Turn"
    @State private var animateLine = false

    private let spacing: CGFloat = 14

    private let winningCombinations = [
        [0,1,2], [3,4,5], [6,7,8],     // Rows
        [0,3,6], [1,4,7], [2,5,8],     // Columns
        [0,4,8], [2,4,6]               // Diagonals
    ]

    var body: some View {

        ZStack {

            // Background
            LinearGradient(
                colors: [
                    Color.black,
                    Color.cyan.opacity(0.7),
                    Color.gray
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 26) {

                headerView

                GeometryReader { geometry in

                    let size = min(geometry.size.width, geometry.size.height)

                    ZStack {

                        // Board
                        LazyVGrid(
                            columns: Array(repeating: GridItem(.flexible(), spacing: spacing), count: 3),
                            spacing: spacing
                        ) {

                            ForEach(0..<9, id: \.self) { index in
                                cellView(index: index, boardSize: size)
                            }
                        }
                        .frame(width: size, height: size)

                        // Winning line
                        if !winningPattern.isEmpty {

                            WinningLine(pattern: winningPattern)
                                .trim(from: 0, to: animateLine ? 1 : 0)
                                .stroke(
                                    LinearGradient(
                                        colors: [.black, .blue],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ),
                                    style: StrokeStyle(
                                        lineWidth: 10,
                                        lineCap: .round,
                                        lineJoin: .round
                                    )
                                )
                                .frame(width: size, height: size)
                                .shadow(color: .black.opacity(0.5), radius: 8)
                                .animation(.easeOut(duration: 0.5), value: animateLine)
                        }
                    }
                    .frame(width: size, height: size)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .aspectRatio(1, contentMode: .fit)
                .padding(.horizontal, 8)

                statusView

                resetButton
            }
            .padding(24)
            .frame(maxWidth: 560)
            .background(
                RoundedRectangle(cornerRadius: 32, style: .continuous)
                    .fill(.ultraThinMaterial)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 32, style: .continuous)
                    .stroke(Color.white.opacity(0.15), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.25), radius: 20, x: 0, y: 10)
            .padding()
        }
    }

    // MARK: - Header

    private var headerView: some View {

        VStack(spacing: 8) {

            Text("Tic-Tac-Toe")
                .font(.system(size: 40, weight: .heavy, design: .rounded))
                .foregroundStyle(.white)

        }
    }

    // MARK: - Cell

    @ViewBuilder
    private func cellView(index: Int, boardSize: CGFloat) -> some View {

        let cellSize = (boardSize - spacing * 2) / 3

        Button {

            makeMove(at: index)

        } label: {

            ZStack {

                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.95),
                                Color.white.opacity(0.75)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        Circle()
                            .stroke(Color.white.opacity(0.5), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.15), radius: 6, x: 0, y: 3)

                if !board[index].isEmpty {

                    Image(systemName: board[index])
                        .resizable()
                        .scaledToFit()
                        .frame(width: cellSize * 0.36, height: cellSize * 0.36)
                        .foregroundStyle(board[index] == "xmark" ? .black : .blue)
                        .transition(.scale.combined(with: .opacity))
                }
            }
            .frame(width: cellSize, height: cellSize)
        }
        .buttonStyle(.plain)
        .disabled(gameOver || !board[index].isEmpty)
    }

    // MARK: - Status

    private var statusView: some View {

        HStack(spacing: 12) {

            Image(systemName: gameOver ? "flag.checkered" : "sparkles")
                .foregroundStyle(.yellow)

            Text(statusText)
                .font(.title3.weight(.bold))
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 12)
        .background(
            Capsule()
                .fill(Color.black.opacity(0.25))
        )
    }

    // MARK: - Reset

    private var resetButton: some View {

        Button {

            resetGame()

        } label: {

            HStack(spacing: 10) {

                Image(systemName: "arrow.counterclockwise")

                Text("Reset Game")
                    .fontWeight(.bold)
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 24)
            .padding(.vertical, 14)
            .background(
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [Color.black.opacity(0.55), Color.black.opacity(0.35)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
            )
        }
        .buttonStyle(.plain)
    }

    // MARK: - Game Logic

    private func makeMove(at index: Int) {

        guard board[index].isEmpty, !gameOver else { return }

        board[index] = isXTurn ? "xmark" : "circle"

        if let combo = checkWinner() {

            winningPattern = combo
            gameOver = true
            statusText = board[combo[0]] == "xmark" ? "X Wins!" : "O Wins!"

            animateLine = false

            DispatchQueue.main.async {
                animateLine = true
            }

        } else if board.contains("") {

            isXTurn.toggle()
            statusText = isXTurn ? "X Turn" : "O Turn"

        } else {

            statusText = "Draw!"
            gameOver = true
        }
    }

    private func checkWinner() -> [Int]? {

        for combo in winningCombinations {

            let first = board[combo[0]]

            if first.isEmpty { continue }

            if first == board[combo[1]] &&
                first == board[combo[2]] {

                return combo
            }
        }

        return nil
    }

    private func resetGame() {

        board = Array(repeating: "", count: 9)
        winningPattern = []
        gameOver = false
        isXTurn = true
        animateLine = false
        statusText = "X Turn"
    }
}

// MARK: - Winning Line Shape

struct WinningLine: Shape {

    var pattern: [Int]

    func path(in rect: CGRect) -> Path {

        var path = Path()

        let cell = rect.width / 3

        func center(of index: Int) -> CGPoint {

            let row = index / 3
            let col = index % 3

            return CGPoint(
                x: CGFloat(col) * cell + cell / 2,
                y: CGFloat(row) * cell + cell / 2
            )
        }

        guard pattern.count == 3 else { return path }

        let start = center(of: pattern[0])
        let end = center(of: pattern[2])

        path.move(to: start)
        path.addLine(to: end)

        return path
    }
}

#Preview {
    myCode()
}
