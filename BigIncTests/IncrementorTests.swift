//
//  BigIncTests.swift
//  BigIncTests
//
//  Created by Богдан Маншилин on 26/01/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import XCTest
@testable import BigInc

class IncrementorTests: XCTestCase {
    
    var incrementor: Incrementor!
    
    override func setUp() {
        super.setUp()
        incrementor = Incrementor()
    }
    
    func testInitialValues() {
        XCTAssertEqual(incrementor.value, 0)
    }
    
    func testIncrement() {
        var value = 0
        XCTAssertEqual(incrementor.value, value)
        for _ in 0..<10 {
            value += 1
            incrementor.increment()
            XCTAssertEqual(incrementor.value, value)
        }
    }
    
    func testResetOnMax() {
        var value = 0
        let max = 10
        do {
            try incrementor.set(maximum: max)
        } catch {
            XCTFail("Incrementor failed on set max value of 10. Error: \(error)")
        }
        XCTAssertEqual(incrementor.value, value)
        for _ in 0..<2 {
            for _ in 0..<9 {
                value += 1
                incrementor.increment()
                XCTAssertEqual(incrementor.value, value)
            }
            XCTAssertEqual(incrementor.value, max-1)
            incrementor.increment()
            XCTAssertEqual(incrementor.value, 0)
            value = 0
        }
    }
    
    func testSetMax() {
        do {
            try incrementor.set(maximum: -1)
            XCTFail("Incrementor has set invalid max value -1")
        } catch Incrementor.Error.maxIsOutOfAllowedRange {
            
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        do {
            try incrementor.set(maximum: 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        do {
            try incrementor.set(maximum: 1)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testSetMaxEqualToCurrent() {
        for _ in 0..<5 {
            incrementor.increment()
        }
        XCTAssertEqual(incrementor.value, 5)
        
        do {
            try incrementor.set(maximum: 6)
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        XCTAssertEqual(incrementor.value, 5)
        
        do {
            try incrementor.set(maximum: 5)
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        XCTAssertEqual(incrementor.value, 0)
    }
    
    func testSetMaxGreaterThanCurrent() {
        for _ in 0..<5 {
            incrementor.increment()
        }
        XCTAssertEqual(incrementor.value, 5)
        
        do {
            try incrementor.set(maximum: 6)
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        XCTAssertEqual(incrementor.value, 5)
        
        do {
            try incrementor.set(maximum: 4)
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        XCTAssertEqual(incrementor.value, 0)
    }
}
