//
//  ActionIconView.swift
//  N-Back-SwiftUI
//
//  Created by Jonas Willén on 2023-10-03.
//

import SwiftUI

struct ActionIconView: View {
    @EnvironmentObject var theViewModel : N_Back_SwiftUIVM

    var body: some View {
        ZStack{
            
            if theViewModel.orientation.isPortrait{
                
                HStack(){
                    Button {
                        theViewModel.soundClick()
                    } label: {
                        ButtonView(title: "SOUND", imageString: "music.note", state: theViewModel.soundButtonState)
                    }.disabled(!theViewModel.soundButtonEnabled || !theViewModel.soundIsActivated)
                    Button {
                        theViewModel.imageClick()
                    } label: {
                        ButtonView(title: "POSITION", imageString: "square.fill", state: theViewModel.positionButtonState)
                    }.disabled(!theViewModel.positionButtonEnabled || !theViewModel.positionIsActivated)
                    
                }
                
            }
            else{
                VStack{
                    Button {
                        theViewModel.soundClick()
                    } label: {
                        ButtonView(title: "SOUND", imageString: "music.note", state: theViewModel.soundButtonState)
                    }
                    .disabled(!theViewModel.soundButtonEnabled || !theViewModel.soundIsActivated)
                    Button {
                        theViewModel.imageClick()
                    } label: {
                        ButtonView(title: "POSITION", imageString: "square.fill", state: theViewModel.positionButtonState)
                    }.disabled(!theViewModel.positionButtonEnabled || !theViewModel.positionIsActivated)
                }
                
            }
           
            
        }.font(.caption2).onRotate{newOrientation in
            theViewModel.orientation = newOrientation
            print("New orientation: \(newOrientation.isLandscape)")
        }
    }
}

struct ActionIconView_Previews: PreviewProvider {
    static var previews: some View {
        ActionIconView()
            .environmentObject(N_Back_SwiftUIVM())
    }
}
