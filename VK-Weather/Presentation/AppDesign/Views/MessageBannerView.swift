import UIKit

final class MessageBannerView: UIView {
	// MARK: - Init
	
	init(bannerStyle: MessageBannerStyle = .default) {
		self.bannerStyle = bannerStyle
		super.init(frame: .zero)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Public
	
	var bannerStyle: MessageBannerStyle
	
	func showMessageBanner(with message: String) {
		messageLabel.text = message
		UIView.animate(withDuration: 1.5) {
			self.backgroundView.frame.origin.y = 0
			self.backgroundView.layer.opacity = 1
		}
	}
	
	func hideMessageBanner() {
		UIView.animate(withDuration: 1.5) {
			self.backgroundView.frame.origin.y = -Constants.bannerHeight
			self.backgroundView.layer.opacity = 0
		}
	}
	
	// MARK: - Private
	
	private let backgroundView = UIView()
	private let messageLabel = UILabel()
	
	private func setup() {
		setupBackgroundView()
		setupMessageLabel()
		
		backgroundView.translatesAutoresizingMaskIntoConstraints = false
		messageLabel.translatesAutoresizingMaskIntoConstraints = false
	}
	
	private func setupBackgroundView() {
		addSubview(backgroundView)
		backgroundView.backgroundColor = bannerStyle.backgroundColor
		backgroundView.layer.cornerRadius = 12
		backgroundView.layer.opacity = 0
		NSLayoutConstraint.activate([
			backgroundView.topAnchor.constraint(equalTo: topAnchor),
			backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
			backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
			backgroundView.heightAnchor.constraint(equalToConstant: Constants.bannerHeight)
		])
	}
	
	private func setupMessageLabel() {
		backgroundView.addSubview(messageLabel)
		messageLabel.textColor = .white
		messageLabel.font = UIFont.systemFont(ofSize: 11, weight: .light)
		messageLabel.textAlignment = .center
		messageLabel.numberOfLines = 0
		NSLayoutConstraint.activate([
			messageLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor),
			messageLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 4),
			messageLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: 4),
			messageLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor)
		])
	}
}


// MARK: - Constants

private extension MessageBannerView {
	enum Constants {
		static let bannerHeight: CGFloat = 54
	}
}
