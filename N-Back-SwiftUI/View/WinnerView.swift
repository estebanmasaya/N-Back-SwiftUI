//
//  WinnerView.swift
//  N-Back-SwiftUI
//
//  Created by Esteban Masaya on 2023-11-20.
//

import SwiftUI

struct WinnerView: View {
    @State private var textoIngresado: String = ""

    var body: some View {
        

        VStack{
            LogoView().frame(maxHeight: 350)
            Text("You got the highest score!").font(.title)
                .foregroundColor(Color(red: 66/255, green: 139/255, blue: 221/255))
            Form{
                Section{
                    TextField("Write your name", text: $textoIngresado).frame(alignment: .center).font(.title2).foregroundColor(.black)

                }
             
            }.frame(maxHeight: 150)
                Spacer()
            Button{
                
            }
        label:{
            Text("Save your whole of fame!")
                .padding()
                .foregroundColor(.white)
                .background(Color(red: 66/255, green: 139/255, blue: 221/255))
                .cornerRadius(20)
        }
            Spacer()
            Spacer()





        }.background(Color(red: 134/255, green: 185/255, blue: 237/255))
    }
}

struct WinnerView_Previews: PreviewProvider {
    static var previews: some View {
        WinnerView()
    }
}
