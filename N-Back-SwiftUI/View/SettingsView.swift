//
//  SettingsView.swift
//  N-Back-SwiftUI
//
//  Created by Esteban Masaya on 2023-11-18.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var theViewModel : N_Back_SwiftUIVM
    var body: some View {
        let nValues : [Int32] = Array(1...10)
        let tickTimeValues : [Int] = Array(1...5)
        let sizeValues : [Int32] = [4, 9, 16, 25, 36, 49, 64, 81, 100]
        let numOfLettersValues: [Int32] = Array(4...100)
        NavigationStack{
            Form{
                
                Section{
                    
                    Picker("N-Back value", selection: $theViewModel.nValue){
                        ForEach(nValues, id: \.self) { number in
                            Text("\(number)").tag(number)
                        }
                    }
                    .pickerStyle(.navigationLink)

                    Picker("Board Size", selection: $theViewModel.gameSize){
                        ForEach(sizeValues, id: \.self) { option in
                            Text("\(Int(sqrt(Double(option))))x\(Int(sqrt(Double(option))))").tag(option)
                        }
                    }.pickerStyle(.navigationLink)
                    
                    
                }

                

                Picker("Seconds between stimuli", selection: $theViewModel.tickTime){
                    ForEach(tickTimeValues, id: \.self) { number in
                        Text("\(number) sek").tag(number)
                    }
                }.pickerStyle(.navigationLink)

                Picker("Number of letters", selection: $theViewModel.numOfLetters){
                    ForEach(numOfLettersValues, id: \.self) { number in
                        Text("\(number)").tag(number)
                    }
                }.pickerStyle(.navigationLink)
                
                Section{
                    Picker("mode", selection: $theViewModel.mode){
                        Text("SOUND").tag(2)
                        Text("POSITION").tag(1)
                        Text("SOUND + POS").tag(0)
                    }.pickerStyle(SegmentedPickerStyle())

                }
            }.padding()
                .navigationTitle("N-Back Settings")


        /*
        HStack{

  

        }.padding()
        
        Button{
            print("Start")
            theViewModel.resetGame()
            theViewModel.actualView = 1
        }label: {
            Text("START").font(.title)
        }
         */
            
        }.onDisappear{
            print("Back from menu")
            theViewModel.saveSettings()
        }

        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(N_Back_SwiftUIVM())
    }
}
