//
//  PickerViewRow.swift
//  Styleguide
//
//  Created by Doan Thieu on 23/11/2022.
//

import UIKit

class PickerViewRow: UIView {

    let titleLabel = UILabel()

    // MARK: - Customizations

    var isSelected = false {
        didSet {
            if isSelected {
                titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
            } else {
                titleLabel.font = .systemFont(ofSize: 20, weight: .regular)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PickerViewRow {

    private func setUpViews() {
        addSubview(titleLabel)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0)
        ])
    }
}
