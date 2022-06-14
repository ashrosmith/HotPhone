//
//  HotPhoneTests.swift
//  HotPhoneTests
//
//  Created by Ashley Smith on 5/11/22.
//

import XCTest

class HotPhoneTests: XCTestCase {

    let gameManager = GameManager()
    
    func testReset() {
        gameManager.reset()
        let gameRound = gameManager.gameRound
        let team1Score = gameManager.team1Score
        let team2Score = gameManager.team2Score
        XCTAssertEqual(gameRound, 1)
        XCTAssertEqual(team1Score, 0)
        XCTAssertEqual(team2Score, 0)
    }
 
    func testRoundTime() {
        let time = gameManager.roundTime()
        XCTAssertNotNil(time)
    }
    
    func testPlaySound() {
        gameManager.playSound(soundName: "34.7")
        XCTAssertTrue(gameManager.player.isPlaying)
    }

}
