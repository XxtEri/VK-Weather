import UIKit

protocol ReuseIdentifiable {
	static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
	static var reuseIdentifier: String {
		String(describing: self)
	}
}

extension UITableViewCell: ReuseIdentifiable {}
