//
//  HotPhoneTests.swift
//  HotPhoneTests
//
//  Created by Ashley Smith on 5/11/22.
//

import XCTest

class HotPhoneTests: XCTestCase {

    let gameManager = GameManager()
    let settingsVC = SettingsViewController()
    
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
    
  

   
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
