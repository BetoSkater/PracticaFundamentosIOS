//
//  HeroeTest.swift
//  PracticaFundamentosIOSTests
//
//  Created by Alberto Junquera Ramírez on 15/1/23.
//

import XCTest

final class HeroeTest: XCTestCase {
    
    var heroe: Heroe!
    
    override func setUp(){
        super.setUp()
        
        heroe = Heroe(description: TextEnum.testDesc.rawValue, favorite: true, id: TextEnum.testId.rawValue, photo: TextEnum.testPhoto.rawValue, name: TextEnum.testName.rawValue)
    }
    
    override func tearDown() {
        heroe = nil
        super.tearDown()
    }
    
    func testHeroeName(){
        XCTAssertNotNil(heroe.name)
        XCTAssertEqual(heroe.name, "Cell")
        XCTAssertNotEqual(heroe.name, "Batman")
    }
    
    func testHeroeID(){
        XCTAssertNotNil(heroe.id)
        XCTAssertEqual(heroe.id, "kjdhasjdhai2e43434")
        XCTAssertNotEqual(heroe.id, "jkdfjhfjfejf73")
    }
    
    func testHeroeDescription(){
        XCTAssertNotNil(heroe.description)
        XCTAssertEqual(heroe.description, "Cell can absorb enemies")
        XCTAssertNotEqual(heroe.description, "Batman")
    }
    
    func testHeroeFavourite(){
        XCTAssertNotNil(heroe.favorite)
        XCTAssertEqual(heroe.favorite, true)
        XCTAssertNotEqual(heroe.favorite, false)
    }
    
    func testHeroePhoto(){
        XCTAssertNotNil(heroe.photo)
        let url = URL(string: heroe.photo)
        XCTAssertEqual(heroe.photo, "https://cdn.alfabetajuega.com/alfabetajuega/2020/05/3CD8B1C5-134E-419E-AB5D-D1440C922A7E-e1590480274537.png?width=300")
        XCTAssertNotEqual(heroe.photo, "https://www.google.com")
    }
}
