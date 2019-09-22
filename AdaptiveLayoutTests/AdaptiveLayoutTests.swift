import XCTest
@testable import AdaptiveLayout

class AdaptiveLayoutTests: SnapshotTestCase {
    
    override var recordingMode: Bool {
        return false
    }

    func testAdaptiveLayout() {
        // Setup
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: AdaptiveViewController.self))
        let vc = storyboard.instantiateViewController(withIdentifier: "AdaptiveViewController")
        
        // Verify
        snapshotVerifyView(vc)
    }
}
