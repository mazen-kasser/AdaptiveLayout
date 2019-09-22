import UIKit
import FBSnapshotTestCase

class SnapshotTestCase: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        
        //  self.isDeviceAgnostic = true
        //  Set usesDrawViewHierarchyInRect when you are testing UIVisualEffects or UIAppearance
        //  usesDrawViewHierarchyInRect = true
        self.recordMode = recordingMode
    }
    
    var recordingMode: Bool {
        return false
    }
    
    /// Override the Architecture suffix that get generated at FBSnapshotTestCaseDefaultSuffixes,
    /// to avoid build agent searches reference screenshots in wrong directory (_32 instead of _64).
    ///
    /// Since we don't have 32 bits images with different screenSize as the 64 bit images.
    /// It is an open issue https://github.com/uber/ios-snapshot-test-case/issues/42
    lazy var emptySuffixes: NSOrderedSet = {
        let suffixes = NSOrderedSet(array: [""])
        return FBSnapshotTestCaseIs64Bit() ? suffixes.reversed : suffixes.copy() as! NSOrderedSet
    }()
    
    func snapshotVerifyView(_ viewController: UIViewController,
                            identifier: String = "",
                            tolerance: CGFloat = 0,
                            file: StaticString = #file,
                            line: UInt = #line) {
        
        Screen.allCases.forEach { screen in
            screen.configure(viewController)
            
            var identifierFormatted = identifier.isEmpty ? "" : "\(identifier)_"
            identifierFormatted += screen.rawValue
            
            FBSnapshotVerifyView(viewController.view,
                                 identifier: identifierFormatted,
                                 suffixes: emptySuffixes,
                                 tolerance: tolerance,
                                 file: file,
                                 line: line)
        }
    }
}

enum Screen: String, CaseIterable {
    case phone
    case pad
    
    var sizeClass: UITraitCollection {
        switch self {
        case .phone:
            return UITraitCollection(horizontalSizeClass: .compact)
        case .pad:
            return UITraitCollection(horizontalSizeClass: .regular)
        }
    }
    
    var size: CGSize {
        switch self {
        case .phone:
            return CGSize(width: 375, height: 812)
        case .pad:
            return CGSize(width: 768, height: 1024)
        }
    }
    
    func configure(_ viewController: UIViewController) {
        viewController.view.frame.size = size
        
        // Simulate different traits programmatically, useful for snapshot testing
        // e.g (UIUserInterfaceIdiom, UIUserInterfaceSizeClass, etc)
        UINavigationController(rootViewController: viewController).setOverrideTraitCollection(sizeClass, forChild: viewController)
    }
}



