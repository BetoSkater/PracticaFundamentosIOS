//
//  TransformationTest.swift
//  PracticaFundamentosIOSTests
//
//  Created by Alberto Junquera Ramírez on 15/1/23.
//

import XCTest

final class TransformationTest: XCTestCase {
    
    var transformation: Transformation!
    
    override func setUp(){
        super.setUp()
        
        transformation = Transformation(name: TextEnum.testName.rawValue, description: TextEnum.testDesc.rawValue, id: TextEnum.testId.rawValue, photo: TextEnum.testPhoto.rawValue)
    }
    
    override func tearDown(){
        transformation = nil
        super.tearDown()
    }
    
    func testTransformationName(){
        XCTAssertNotNil(transformation.name)
        XCTAssertEqual(transformation.name, "Cell")
        XCTAssertNotEqual(transformation.name, "Batman")
    }
    
    func testHeroeID(){
        XCTAssertNotNil(transformation.id)
        XCTAssertEqual(transformation.id, "kjdhasjdhai2e43434")
        XCTAssertNotEqual(transformation.id, "jkdfjhfjfejf73")
    }
    
    func testHeroeDescription(){
        XCTAssertNotNil(transformation.description)
        XCTAssertEqual(transformation.description, "Cell can absorb enemies")
        XCTAssertNotEqual(transformation.description, "Batman")
    }
    
    func testHeroePhoto(){
        XCTAssertNotNil(transformation.photo)
        let url = URL(string: transformation.photo)
        XCTAssertEqual(transformation.photo, "https://cdn.alfabetajuega.com/alfabetajuega/2020/05/3CD8B1C5-134E-419E-AB5D-D1440C922A7E-e1590480274537.png?width=300")
        XCTAssertNotEqual(transformation.photo, "https://www.google.com")
    }
}
