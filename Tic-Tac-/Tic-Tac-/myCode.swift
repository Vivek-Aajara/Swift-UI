import SwiftUI

struct myCode: View {
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 3)
    var body: some View {
        ZStack{
            LinearGradient(
                colors: [.black, .cyan, .gray],
                startPoint: .top, endPoint: .bottom
            )
            
            .ignoresSafeArea()
            
            VStack {
                Text("Tic-Tac-Toe")
                    .foregroundStyle(.black).font(.system(size: 40, weight: .bold, design: .rounded)).opacity(0.5)
                LazyVGrid(columns: columns, spacing: 20){
                    ForEach(0..<9, id: \.self){
                        index in
                        CellView(onTap: {}, isTic: true)
                    }
                }
                Button("RESET") {
                    print("Game Reset")
                }.font(.system(size: 30, weight: .bold, design: .rounded)).foregroundStyle(.black).opacity(0.6)
                
            }
            .padding()
            .background(.ultraThinMaterial.opacity(0.3))
            .cornerRadius(55)
            .shadow(radius: 100)
        }
        
        
    }
}


struct CellView: View {
    var onTap: () -> Void
    var isTic: Bool
    var body: some View {
        HStack{
            ZStack{
                Circle()
                    .frame( width: 110, height: 110, alignment: .center)
                    .foregroundStyle(.black).opacity(0.2)
                Image(systemName: isTic ? "circle" : "x.circle")
                    .resizable()
                    .frame( width: 85, height: 85, alignment: .center)
                    .foregroundStyle(.black)
                    .onTapGesture {
                    }
                
            }
        }.padding()
            .opacity(0.5)
    }
}




#Preview {
    myCode()
}
