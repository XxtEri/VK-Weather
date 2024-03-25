import UIKit

final class TitleWithValueCardView: UIView {
	// MARK: - Init
	
	init() {
		super.init(frame: .zero)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Public
	
	func configure(title: String, value: String) {
		titleCardLabel.text = title
		valueLabel.text = value
	}
	
	// MARK: - Private
	
	private let backgroundView = UIView()
	private let titleCardLabel = UILabel()
	private let valueLabel = UILabel()
	
	private func setup() {
		setupBackgroundView()
		setupTitleCardLabel()
		setupValueLabel()
		
		backgroundView.translatesAutoresizingMaskIntoConstraints = false
		titleCardLabel.translatesAutoresizingMaskIntoConstraints = false
		valueLabel.translatesAutoresizingMaskIntoConstraints = false
	}
	
	private func setupBackgroundView() {
		addSubview(backgroundView)
		backgroundView.backgroundColor = .blue.withAlphaComponent(0.3)
		backgroundView.layer.cornerRadius = 12
		NSLayoutConstraint.activate([
			backgroundView.topAnchor.constraint(equalTo: topAnchor),
			backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
			backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
			backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor)
		])
		
	}
	
	private func setupTitleCardLabel() {
		backgroundView.addSubview(titleCardLabel)
		titleCardLabel.textColor = .white.withAlphaComponent(0.5)
		titleCardLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
		NSLayoutConstraint.activate([
			titleCardLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 6),
			titleCardLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12),
			titleCardLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12)
		])
	}
	
	private func setupValueLabel() {
		backgroundView.addSubview(valueLabel)
		valueLabel.textColor = .white
		valueLabel.numberOfLines = .zero
		valueLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
		NSLayoutConstraint.activate([
			valueLabel.topAnchor.constraint(equalTo: titleCardLabel.bottomAnchor, constant: 12),
			valueLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 12),
			valueLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12),
			valueLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -16)
		])
	}
}
