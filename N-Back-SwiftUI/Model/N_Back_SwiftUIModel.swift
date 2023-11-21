//
//  N_Back_SwiftUIModel.swift
//  N-Back-SwiftUI
//
//  Created by Jonas Willén on 2023-09-19.
//

import Foundation

struct N_BackSwiftUIModel {
    private var nbackPosition : Nback
    private var nbackSound : Nback
    private var combinations: Int32
    private var gameSize: Int32
    private var matchPercentage: Int32
    private var nValue: Int32
    
    private var count : Int
    
    init(count: Int, combinations: Int32, gameSize: Int32, matchPercentage: Int32) {
        self.nValue = 1
        self.count = count
        self.combinations = combinations
        self.gameSize = gameSize
        self.matchPercentage = matchPercentage
        self.nbackPosition = create(combinations, gameSize, matchPercentage, nValue)
        self.nbackSound = create(combinations, gameSize, matchPercentage, nValue)
    }
    
    func getCombinations()-> Int32{
        return combinations
    }

    func getNValue()-> Int32{
        return nValue
    }
    
    
    func getGameSize()-> Int32{
        return gameSize
    }
    
    func getScore() -> Int{
        return count
    }
    
    mutating func getNextNum(tick: Int32) -> Int32{
        return getIndexOf(nbackPosition, tick)
    }
    
    func getNextLetter(tick: Int32) -> Character{
        return mapNumberToLetter(Int(getIndexOf(nbackSound, tick)))
    }
    
    mutating func addScore(){
        count += 1
    }
    
    func mapNumberToLetter(_ number: Int) -> Character {
        let asciiValue = UInt32(number - 1) + UInt32(UnicodeScalar("a").value)
        return Character(UnicodeScalar(asciiValue)!)

    }
      
    mutating func resetNbackPosition(combinations: Int32, gameSize: Int32, nValue: Int32){
        nbackPosition = create(combinations, gameSize, matchPercentage, nValue)
        for i in 0..<combinations {
            let test:Int32 = Int32(i)
            print("\(i) aPositionValue: \(getIndexOf(nbackPosition, test))")
        }
    }

    mutating func resetNbackSound(combinations: Int32, gameSize: Int32, nValue: Int32){
        nbackSound = create(combinations, gameSize, matchPercentage, nValue)
        for i in 0..<combinations {
            let test:Int32 = Int32(i)
            print("\(i) aSoundValue: \(getIndexOf(nbackSound, test))")
        }
        
    }
    
    
   
}
