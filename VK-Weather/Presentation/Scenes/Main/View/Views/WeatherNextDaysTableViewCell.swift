import UIKit

final class WeatherNextDaysTableViewCell: UITableViewCell {
	// MARK: - Init
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Public
	
	func configure(date: String, maxTemperature: Int?, minTemperature: Int?) {
		dateLabel.text = date
		if let maxTemperature = maxTemperature {
			maxTemperatureLabel.text = String(describing: maxTemperature) + "°"
		} else {
			maxTemperatureLabel.text = "-"
		}
		if let minTemperature = minTemperature {
			minTemperatureLabel.text = String(describing: minTemperature) + "°"
		} else {
			minTemperatureLabel.text = "-"
		}
	}
	
	// MARK: - Private
	
	private let dateLabel = UILabel()
	private let minTemperatureLabel = UILabel()
	private let maxTemperatureLabel = UILabel()
	
	private func setup() {
		backgroundColor = .clear
		selectionStyle = .none
		
		setupDateLabel()
		setupMaxTemperatureLabel()
		setupMinTemperatureLabel()
		
		dateLabel.translatesAutoresizingMaskIntoConstraints = false
		minTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
		maxTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
	}
	
	private func setupDateLabel() {
		addSubview(dateLabel)
		dateLabel.textColor = .black
		dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
		NSLayoutConstraint.activate([
			dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
			dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
			dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
		])
	}
	
	private func setupMaxTemperatureLabel() {
		addSubview(maxTemperatureLabel)
		maxTemperatureLabel.textColor = .black
		maxTemperatureLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
		NSLayoutConstraint.activate([
			maxTemperatureLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
			maxTemperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
			maxTemperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
		])
	}
	
	private func setupMinTemperatureLabel() {
		addSubview(minTemperatureLabel)
		minTemperatureLabel.textColor = .black.withAlphaComponent(0.5)
		minTemperatureLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
		NSLayoutConstraint.activate([
			minTemperatureLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
			minTemperatureLabel.leadingAnchor.constraint(greaterThanOrEqualTo: dateLabel.trailingAnchor, constant: 24),
			minTemperatureLabel.trailingAnchor.constraint(equalTo: maxTemperatureLabel.leadingAnchor, constant: -18),
			minTemperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
		])
	}
}
