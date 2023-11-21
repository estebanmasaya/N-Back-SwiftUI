//
//  BoardView.swift
//  N-Back-SwiftUI
//
//  Created by Esteban Masaya on 2023-11-14.
//

import SwiftUI

struct BoardView: View {
    @EnvironmentObject var VM : N_Back_SwiftUIVM
    var sideSize : Int{ return Int(VM.nbackPads.count)}
    var body: some View {
        VStack{
            ForEach(0..<sideSize, id: \.self){ aRow in
                HStack{
                    ForEach(0..<sideSize, id: \.self){ aColumn in
                        PadView(isLit: VM.nbackPads[aRow][aColumn].state, gameSize: Int(VM.gameSize))
                        
                    }
                }
                
            }
            
        }
    }
    
    struct BoardView_Previews: PreviewProvider {
        static var previews: some View {
            BoardView()
                .environmentObject(N_Back_SwiftUIVM())
        }
    }
}
