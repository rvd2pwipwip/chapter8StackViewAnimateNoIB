//
//  ViewController.swift
//  chapter8StackViewAnimateNoIB
//
//  Created by Herve Desrosiers on 2020-03-10.
//  Copyright © 2020 Herve Desrosiers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Animating StackView"
        setupView()
        axisSwitch.addTarget(self, action: #selector(axisChanged), for: .valueChanged)
    }
    
    private func setupView() {
        view.addSubview(rootStackView)
        let margin = view.layoutMarginsGuide
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)
        NSLayoutConstraint.activate([
            rootStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rootStackView.topAnchor.constraint(equalTo: margin.topAnchor),
        ])
    }
    
    private func configureAxis() {
        imageStackView.axis = axisSwitch.isOn ? .vertical : .horizontal
        // hide last image view if switch is off (horizontal)
        if let lastImageView = imageStackView.arrangedSubviews.last {
            lastImageView.isHidden = !axisSwitch.isOn
        }
    }
    
    @objc private func axisChanged(_ sender: UISwitch) {
        let animator = UIViewPropertyAnimator(
            duration: 1.0, dampingRatio: 0.5,
            animations: {
                self.configureAxis()
        })
        animator.startAnimation()
    }
    
    private let heartImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "Heart")
        return iv
    }()
    
    private let starImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "Star")
        return iv
    }()

    private let diamondImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "DIamond")
        return iv
    }()
    
    private lazy var imageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [heartImageView, starImageView, diamondImageView])
        
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.contentMode = .scaleToFill
        return stackView
    }()
    
    private let axisSwitch: UISwitch = {
        let sw = UISwitch()
        sw.isOn = true
        return sw
    }()
    
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [axisSwitch, imageStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.contentMode = .scaleToFill
        // 8 point padding
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20.0, leading: 8.0, bottom: 8.0, trailing: 8.0)
        return stackView
    }()

}
