import XCTest
@testable import AdaptiveLayout

class AdaptiveTableViewCellTests: XCTestCase {
        
        func testAdaptiveCellStyle() {
            let cell: AdaptiveTableViewCell = .loadFromNib()
            
            XCTAssert(cell.sizeClass == .unspecified)
            XCTAssert(cell.mainStackView.axis == .vertical)
            XCTAssert(cell.stackView.axis == .horizontal)
            XCTAssert(cell.titleLabel.font == Font.bold)
            XCTAssert(cell.valueLabel.font == Font.regular)
            
            cell.sizeClass = .regular
            XCTAssert(cell.mainStackView.axis == .horizontal)
            XCTAssert(cell.stackView.axis == .vertical)
            XCTAssert(cell.titleLabel.font == Font.regular)
            XCTAssert(cell.valueLabel.font == Font.bold)
            
            cell.sizeClass = .compact
            XCTAssert(cell.mainStackView.axis == .vertical)
            XCTAssert(cell.stackView.axis == .horizontal)
            XCTAssert(cell.titleLabel.font == Font.bold)
            XCTAssert(cell.valueLabel.font == Font.regular)
        }
}
