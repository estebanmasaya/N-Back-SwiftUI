//
//  SquareView.swift
//  N-Back-SwiftUI
//
//  Created by Esteban Masaya on 2023-11-14.
//

import SwiftUI

struct PadView: View {
    var isLit: Bool
    var gameSize: Int
    var sideSize : Int
    
    init(isLit: Bool, gameSize: Int){
        self.isLit = isLit
        self.gameSize = gameSize
        self.sideSize = Int(sqrt(Double(gameSize)))
    }
    var body: some View {
        Rectangle()
            .cornerRadius(gameSize>=49 ? (gameSize>=81 ? 1 : 4) : 10).aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
            .foregroundColor(
                isLit ? Color.yellow
                :
                    Color(red: 196/255, green: 216/255, blue: 239/255)
                )
    }
}

struct PadView_Previews: PreviewProvider {
    static var previews: some View {
        PadView(isLit: false, gameSize: 3)
    }
}
