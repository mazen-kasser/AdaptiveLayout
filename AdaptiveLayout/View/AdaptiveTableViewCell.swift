import UIKit

public class AdaptiveTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = sizeClass.titleFont
        }
    }
    @IBOutlet weak var valueLabel: UILabel! {
        didSet {
            valueLabel.font = sizeClass.detailFont
        }
    }
    @IBOutlet weak var stackView: UIStackView! {
        didSet {
            stackView.axis = sizeClass.axis
        }
    }
    @IBOutlet weak var mainStackView: UIStackView! {
        didSet {
            mainStackView.axis = sizeClass.mainAxis
        }
    }

    var sizeClass: UIUserInterfaceSizeClass = .unspecified {
        willSet(newValue) {
            mainStackView.axis = newValue.mainAxis
            stackView.axis = newValue.axis
            titleLabel.font = newValue.titleFont
            valueLabel.font = newValue.detailFont
        }
    }
    
    // MARK: Trait Collection
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        if sizeClass != traitCollection.horizontalSizeClass {
            sizeClass = traitCollection.horizontalSizeClass
        }
    }
    
    // To support live changes
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard let previousTraitCollection = previousTraitCollection else { return }
        
        if traitCollection.horizontalSizeClass != previousTraitCollection.horizontalSizeClass {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
}

enum Font {
    static let regular = UIFont.systemFont(ofSize: 16)
    static let bold = UIFont.boldSystemFont(ofSize: 24)
}

fileprivate extension UIUserInterfaceSizeClass {
    
    var axis: NSLayoutConstraint.Axis {
        return self == .regular ? .vertical : .horizontal
    }
    
    var mainAxis: NSLayoutConstraint.Axis {
        return self == .regular ? .horizontal : .vertical
    }
    
    var titleFont: UIFont {
        return self == .regular ? Font.regular : Font.bold
    }
    
    var detailFont: UIFont {
        return self == .regular ? Font.bold : Font.regular
    }
}
