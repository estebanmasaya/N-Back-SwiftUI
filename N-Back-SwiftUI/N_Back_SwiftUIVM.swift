//
//  N_Back_SwiftUIVM.swift
//  N-Back-SwiftUI
//
//  Created by Jonas Willén on 2023-09-19.
//

import Foundation
import AVFoundation
import SwiftUI
import CoreData

class N_Back_SwiftUIVM : ObservableObject  {

    var container : NSPersistentContainer
    var timer : Timer
    var currentIndex: Int = 0
    let synthesizer = AVSpeechSynthesizer()
    var theModel : N_BackSwiftUIModel
    @Published var score : Int
    @Published var highScore : Int = 0
    
    @Published var nbackPads : [[aPad]]
    @Published var isPlaying = false
    @Published var positionButtonState = ClickState.NORMAL
    @Published var positionButtonEnabled = false
    @Published var soundButtonState = ClickState.NORMAL
    @Published var soundButtonEnabled = false
    @Published var actualView: Int = 0
    @Published var nValue: Int32 = 3
    @Published var gameSize: Int32 = 9
    @Published var positionIsActivated = true
    @Published var soundIsActivated = true
    @Published var mode = 0
    @Published var tickTime = 2
    @Published var numOfLetters: Int32 = 9
    @Published var orientation = UIDeviceOrientation.portrait
    @Published var isWinner = false
    var combinations : Int32 = 20
    @Published var tick = -1
    
    init(){
        theModel = N_BackSwiftUIModel(count: 0, combinations: 20, gameSize: 9, matchPercentage: 20)
        score = theModel.getScore()
        nbackPads = initNbackPads(size: Int(theModel.getGameSize()))
        timer = Timer();
        container = NSPersistentContainer(name: "Settings")
        container.loadPersistentStores{(description, error) in
            if let error = error{
                print ("Core Data failed to load: \(error.localizedDescription)")
            }
            else{
                //print("Succesfully loaded core data")
                self.fetchAndApplySettings()

            }
                
        }
    }
    
    func fetchAndApplySettings() {
        if let settings = fetchSettings() {
            self.gameSize = settings.gameSize
            self.highScore = Int(settings.highScore)
            self.mode = Int(settings.mode)
            self.numOfLetters = settings.numOfLetters
            self.nValue = settings.nValue
            self.tickTime = Int(settings.tickTime)
        }
    }
    
    func saveSettings(){
        guard let existingSettings = fetchSettings() else{
            print("No settings found. Creating new settings...")
            let newSettings = Settings(context: container.viewContext)
            updateSettings(newSettings: newSettings)
            return
        }
        updateSettings(newSettings: existingSettings)
        do{
            try container.viewContext.save()
        }catch let error{
            print("Error saving \(error)")
        }
    }
    
    func updateSettings(newSettings: Settings){
        newSettings.gameSize = self.gameSize
        if self.score > fetchHighScore(){
            print("new high score!!!")
            isWinner = true
            newSettings.highScore = Int32(self.score)
        }
        newSettings.mode = Int32(self.mode)
        newSettings.numOfLetters = self.numOfLetters
        newSettings.nValue = self.nValue
        newSettings.tickTime = Int32(self.tickTime)
    }
    
    func fetchHighScore() -> Int32{
        let request : NSFetchRequest<Settings> = Settings.fetchRequest()
        do{
            let savedSettings = try container.viewContext.fetch(request)
    
            return savedSettings.last!.highScore
        } catch let error{
            print("Error fetching. \(error)")
            return 0
        }
    }
    
    func fetchSettings() -> Settings?{
        let request : NSFetchRequest<Settings> = Settings.fetchRequest()
        do{
            let savedSettings = try container.viewContext.fetch(request)
            //print(savedSettings)
            return savedSettings.last
        } catch let error{
            print("Error fetching. \(error)")
            return nil
        }
    }
    
    func deleteAllSettings() {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Settings")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)

        do {
            try container.viewContext.execute(deleteRequest)
            try container.viewContext.save()
            print("deleted")
        } catch let error {
            print("Error deleting all settings: \(error)")
        }
    }
    
    func newscoreValue(){
        theModel.addScore()
        score = theModel.getScore()
    }
    
    func resetGame(){
        switch(mode){
            case 0: soundIsActivated = true
                    positionIsActivated = true
            case 1: soundIsActivated = false
                    positionIsActivated = true
            case 2: soundIsActivated = true
                    positionIsActivated = false
            default:soundIsActivated = true
                    positionIsActivated = true
        }
        
        theModel.resetNbackPosition(combinations: combinations, gameSize: gameSize, nValue: nValue)
        nbackPads = initNbackPads(size: Int(gameSize))
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.13){
            self.theModel.resetNbackSound(combinations: self.combinations, gameSize: self.numOfLetters, nValue: self.nValue)
        }
        
        tick = -1
        
    }
    
    func soundClick(){
        self.soundButtonEnabled = false
        
        let nValue = theModel.getNValue()
        if (tick >= nValue && self.theModel.getNextLetter(tick: Int32(tick)) == self.theModel.getNextLetter(tick: (Int32(tick) - nValue))){
            self.newscoreValue()
            self.soundButtonState = ClickState.POINT
            print("YES Sound")
        }
        else{
            print("NO Sound")
            self.soundButtonState = ClickState.FAIL
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.soundButtonState = ClickState.NORMAL
        }
    }
    
    func imageClick(){
            self.positionButtonEnabled = false

            let nValue = theModel.getNValue()
            if (tick >= nValue && self.theModel.getNextNum(tick: Int32(tick)) == self.theModel.getNextNum(tick: (Int32(tick) - nValue))){
                self.newscoreValue()
                self.positionButtonState = ClickState.POINT
                print("YES")
            }
            else{
                print("NO")
                self.positionButtonState = ClickState.FAIL
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                self.positionButtonState = ClickState.NORMAL
            }
    }
    
    
    func numToCoor(num: Int) -> (x: Int, y: Int){
        
        print("num: \(num)")
        let root = sqrt(Double(gameSize))
        print("root = \(root)")
        let x = (abs(num-1))/Int(root)
        
        let y = (abs(num-1))%Int(root)
        print("coor")
        print(x)
        print(y)
        return(x, y)
    }
    
    func play(){
        timer = Timer.scheduledTimer(withTimeInterval: Double(tickTime), repeats: true) { timer in
            self.tick+=1
            if self.tick >= self.combinations{
                timer.invalidate()
                self.isPlaying = false
                self.saveSettings()
                self.fetchAndApplySettings()
                return
            }
            
            // Sound
            if self.soundIsActivated{
                let newLetter = self.theModel.getNextLetter(tick: Int32(self.tick))
                self.speech(aString: String(newLetter))
                self.soundButtonEnabled = true
            }
            
            // Position
            if self.positionIsActivated{
                let newNumber = Int(self.theModel.getNextNum(tick: Int32(self.tick)))
                let coor = self.numToCoor(num: newNumber)
                self.nbackPads[coor.x][coor.y].state = true
                self.positionButtonEnabled = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    self.nbackPads[coor.x][coor.y].state = false
                }
            }
        }

        }
    
    
    // IO handling
    
    func speech(aString: String){
        let soundVoice = AVSpeechUtterance(string: aString)
        synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate )
        synthesizer.speak(soundVoice)
    }
    

}


func initNbackPads(size: Int) -> [[aPad]] {
    let sideSize : Int = Int(sqrt(Double(size)))
    var pads = [[aPad]]()
    var count = 0
    for _ in 0..<sideSize{
        var row = [aPad]()
        for _ in 0..<sideSize{
            row.append(aPad(id: count, state: false))
            count += 1
        }
        pads.append(row)
    }
    return pads
}

struct aPad: Hashable, Codable, Identifiable {
    var id: Int
    var state : Bool
}

enum ClickState {
    case NORMAL
    case FAIL
    case POINT
}






