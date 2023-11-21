//
//  LogoView.swift
//  N-Back-SwiftUI
//
//  Created by Esteban Masaya on 2023-11-20.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        VStack{
            VStack(spacing: 1) {
                Text("Engineerd by Esteban Masaya")
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundColor(.white)
                    .padding(.trailing)
                Rectangle().fill(.yellow).frame(height: 6).cornerRadius(2)
                    .padding(.horizontal)
                    
            }.shadow(color: .blue, radius: 1, x: 0.5, y: 0.5)
            
            Spacer()
                                    
            Text("Dual N-Back")
                .font(.system(size: 50))
                .foregroundColor(.white)
                .shadow(color: .blue, radius: 2, x: 1, y: 1)
            Text("🧠").font(.system(size: 70))
        }
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
