//
//  GameView.swift
//  N-Back-SwiftUI
//
//  Created by Esteban Masaya on 2023-11-17.
//

import SwiftUI



struct GameView: View {
    
    @EnvironmentObject var theViewModel : N_Back_SwiftUIVM
    var body: some View {
        
        NavigationStack{
            //PORTRAIT
            if theViewModel.orientation.isPortrait{
                //SCORE + GEARVIEW
                VStack {
                    Spacer()
                    ZStack{
                        HStack(alignment: .center) {
                            Spacer()
                            Text("Score  \(theViewModel.score)").foregroundColor(.white).font(.headline).frame(maxWidth: .infinity, alignment: .center)
                        }
                        HStack{
                            NavigationLink(destination: SettingsView()){
                                GearView()
                            }.frame( maxWidth: .infinity,   alignment: .trailing)
                                .padding(.trailing)
                        }
                    }
                    ZStack{
                        //EVENT COUNT + PLAY
                        HStack{
                            HStack{
                                if(theViewModel.tick<0){
                                    Text("0/\(theViewModel.combinations)")
                                    
                                }
                                else{
                                    Text("\(theViewModel.tick+1)/\(theViewModel.combinations)")
                                }
                            }.foregroundColor(.white).padding(.leading)
                            Spacer()
                            PlayView().frame(alignment: .trailing).padding(.trailing)
                        }
                        //NValue
                        HStack(alignment: .center){
                            
                            Text(" N = \(theViewModel.nValue)").foregroundColor(.white).font(.title)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    //BOARDVIEW
                    BoardView().padding(.leading).padding(.trailing).padding(.bottom)
                    Spacer()
                    //BUTTONS
                    ActionIconView()
                }.background(Color(red: 134/255, green: 185/255, blue: 237/255))
                
            }
            
            else{
                //LANDSCAPE
                HStack{
                    //BOARDVIEW
                    Spacer()
                    BoardView().padding()
                    
                    //BUTTONS
                    VStack{
                        Spacer()
                        HStack{
                            Text("Score  \(theViewModel.score)").foregroundColor(.white).font(.headline).frame( maxWidth: .infinity,   alignment: .leading)
                            PlayView()
                        NavigationLink(destination: SettingsView()){
                            GearView()
                        }.frame( maxWidth: .infinity,   alignment: .trailing)
                    }
                        
                        HStack{
                            HStack{
                                if(theViewModel.tick<0){
                                    Text("0/\(theViewModel.combinations)")
                                    
                                }
                                else{
                                    Text("\(theViewModel.tick)")
                                }
                            }.foregroundColor(.white).padding(.leading)
                            
                            
                        }
                        Spacer()
                        ActionIconView()
                    }
                }.background(Color(red: 134/255, green: 185/255, blue: 237/255))
                
                
            }
            
            
            
            //BACKGROUND
            ZStack {
                //Color(red: 134/255, green: 185/255, blue: 237/255) //.edgesIgnoringSafeArea(.all)
                
            }.onRotate{ newOrientation in
                theViewModel.orientation = newOrientation
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ForEach(["iPhone SE (3rd generation)", "iPhone 14 Pro Max"], id: \.self) { deviceName in
                GameView()
                    .previewDevice(PreviewDevice(rawValue: deviceName))
                    .previewDisplayName(deviceName)
                    .environmentObject(N_Back_SwiftUIVM())
            }
            
            GameView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
                .previewDisplayName("iPhone 14 Pro Max Landscape")
                .environmentObject(N_Back_SwiftUIVM())
                .previewInterfaceOrientation(.landscapeRight)
        }
    }
}
