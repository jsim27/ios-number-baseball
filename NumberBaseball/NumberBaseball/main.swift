//
//  NumberBaseball - main.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//
import Foundation

let limitLength: Int = 3
var leftTrial: Int = 9
var comNumbers: [String] = []
var userNumbers: [String] = []


func startGame() {
    leftTrial = 9
    runMode()
}

func runMode() {
    if selectMode() == "1" {
        comNumbers = makeRandomNumbers()
           userNumbers = []
        judgeNumbers()
    } else if selectMode() == "2" {
        return
    } else {
        runMode()
    }
}

func selectMode() -> String {
    let modeNumber: String?
    print("1. 게임시작")
    print("2. 게임종료")
    print("원하는 기능을 선택해주세요 : ")
    modeNumber = readLine()
    if let modeNumber = modeNumber, modeNumber == "1" || modeNumber == "2" {
        return modeNumber
    } else {
        print("입력이 잘못되었습니다")
        return "0"
    }
}

func makeRandomNumbers() -> [String] {
    var randomNumbers: Set<String> = []
   
    while randomNumbers.count < 3 {
        randomNumbers.insert(String(Int.random(in: 1...9)))
    }
    return [String](randomNumbers)
}

func judgeBall(at index: Int) -> Int {
    if comNumbers.contains(userNumbers[index]) {
        return 1
    }
    return 0
}

func judgeStrike(at index: Int) -> Int {
    if comNumbers[index] == userNumbers[index] {
        return 1
    }
    return 0
}

func judgeNumbers() {
    userNumbers = makeRandomNumbers()
    judgeGame()
}

func judgeGame() {
    var ballCount: Int = 0
    var strikeCount: Int = 0

    for number in 0..<limitLength {
        ballCount += judgeBall(at: number)
        ballCount -= judgeStrike(at: number)
        strikeCount += judgeStrike(at: number)
    }
    
    print("임의의 수 : ", userNumbers.joined(separator: " "))
    print("\(strikeCount) 스트라이크, \(ballCount) 볼")
    
    
    leftTrial -= 1
    if leftTrial > 0 && strikeCount < limitLength {

        print("남은 기회 : ", leftTrial)
        judgeNumbers()
     } else if leftTrial > 0 && strikeCount == limitLength {
        print("남은 기회 : ", leftTrial)
        print("인간 승리")
     } else  {
        print("남은 기회 : ", leftTrial)
        print("컴퓨터 승리...!")
    }

}

startGame()

