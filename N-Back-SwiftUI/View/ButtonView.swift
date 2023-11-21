//
//  ImageIconView.swift
//  N-Back-SwiftUI
//
//  Created by Jonas Willén on 2023-10-03.
//

import SwiftUI

struct ButtonView: View {
    @EnvironmentObject var VM : N_Back_SwiftUIVM
    let title: String
    let imageString: String
    var state: ClickState
    var body: some View {
        ZStack {
            Rectangle().foregroundColor(
                getColor(state: state)
            )
            VStack {

                
                Text("\(title)")
                Image(systemName: "\(imageString)")
                    .imageScale(.large)
            }
            
            //.padding()
            .font(.title)
            .foregroundColor(Color.white)
        }
    }
}

func getColor (state: ClickState)->Color{
    var color: Color
    switch(state){
        case ClickState.FAIL:
            color = Color.red
        case ClickState.POINT:
            color = Color.green
        case ClickState.NORMAL:
            color = Color(red: 66/255, green: 139/255, blue: 221/255)
    }
    return color
}

struct ImageIconView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(title: "casa", imageString: "music.note", state: ClickState.NORMAL)
    }
}
