//
//  DetailList.swift
//  ListDown
//
//  Created by Project on 10/07/26.
//

import SwiftUI

struct DetailList: View {
    @Binding var selectedRow: String
    
    var body: some View {
        Text("selectedRow: \(selectedRow)")
    }
}

//#Preview {
//    DetailList(selectedRow: "")
//}
