//
//  PlayView.swift
//  N-Back-SwiftUI
//
//  Created by Esteban Masaya on 2023-11-15.
//

import SwiftUI

struct PlayView: View {
    @EnvironmentObject var VM : N_Back_SwiftUIVM
    var body: some View {
        Button{
            print("holaaaaaa")
            if VM.isPlaying {
                VM.timer.invalidate()
                VM.isPlaying = false
                VM.tick = -1
                VM.saveSettings()
                VM.fetchAndApplySettings()
            }
            else{
                VM .resetGame()
                VM.score = 0
                VM.isPlaying = true
                VM.play()
            }
        }label:{
            ZStack{
                if VM.isPlaying {
                    Image(systemName:"stop.fill")
                }
                else{
                    Image(systemName:"play.fill")
                }
            }
        }
        .foregroundColor(Color.white)
        .padding(15)
        .imageScale(.large)
        .background(Color(red: 66/255, green: 139/255, blue: 221/255))
        .cornerRadius(200)

    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
    }
}
