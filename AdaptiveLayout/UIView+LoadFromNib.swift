import UIKit

extension UIView {
    
    class func loadFromNib<T: UIView>() -> T {
        let bundle = Bundle(for: T.self)
        return bundle.loadNibNamed(String(describing: T.self), owner: nil, options: nil)!.first as! T
    }
    
    func loadAndAddSubviewFromNib() -> UIView {
        return loadAndAddSubviewFromNib(name: String(describing: type(of: self)))
    }

    func loadAndAddSubviewFromNib(name: String) -> UIView {
        let klass = type(of: self)
        let bundle = Bundle(for: klass)
        let nib = UINib(nibName: name, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        view.autoresizingMask = [ .flexibleWidth, .flexibleHeight]
        addSubview(view)
        return view
    }
}
