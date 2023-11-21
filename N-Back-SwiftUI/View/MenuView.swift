//
//  MenuView.swift
//  N-Back-SwiftUI
//
//  Created by Esteban Masaya on 2023-11-17.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var theViewModel : N_Back_SwiftUIVM
    var body: some View {
        
        /*
         let nValues : [Int32] = Array(1...10)
         let tickTimeValues : [Int] = Array(1...5)
         let sizeValues : [Int32] = [4, 9, 16, 32, 64, 81, 100]
         let numOfLettersValues: [Int32] = Array(4...100)
         */
        NavigationStack{
            
            
            ZStack {
                Color(red: 134/255, green: 185/255, blue: 237/255) .edgesIgnoringSafeArea(.all)
                
                VStack{
                    Spacer()
                    Spacer()
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
                    Spacer()
                    VStack{
                        Text("N = \(theViewModel.nValue)")
                        Text("Highscore = \(theViewModel.highScore)")
                    }.font(.title2)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    NavigationLink(destination: GameView().onAppear{
                        theViewModel.resetGame()
                    }
                    ){
                        Text("START").font(.title)
                    }
                }
                
                VStack {
                    HStack {
                        Spacer()
                        NavigationLink(destination: SettingsView()){
                            GearView().padding(.trailing).padding(.top)
                        }
                    }
                    Spacer()
                }
            }.onRotate{newOrientation in
                theViewModel.orientation = newOrientation
                print("New orientation: \(newOrientation.isLandscape)")
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView().environmentObject(N_Back_SwiftUIVM())
    }
}
