//
//  ImageSelector.swift
//  Mandala
//
//  Created by franklin smith on 1/4/21.
//

import UIKit

class ImageSelector: UIControl {
    
    
    var selectedIndex = 0
    
    private var imageButtons: [UIButton] = [] {
        didSet{
            oldValue.forEach { $0.removeFromSuperview() }
            imageButtons.forEach { selectorStackView.addArrangedSubview($0)}
        }
    }
    
    var images: [UIImage] = [] {
        didSet {
            imageButtons = images.map { image in
                let imageButton = UIButton()
                
                imageButton.setImage(image, for: .normal)
                imageButton.imageView?.contentMode = .scaleAspectFit
                imageButton.adjustsImageWhenHighlighted = false
                imageButton.addTarget(self, action: #selector(imageButtonTapped(_:)),
                                      for: .touchUpInside)
                
                return imageButton
            }
            selectedIndex = 0
        }
    }
    
    
    @objc private func imageButtonTapped(_ sender: UIButton) {
        guard let buttonIndex = imageButtons.firstIndex(of: sender) else {
            preconditionFailure("the buttons and images are not paralell.")
        }
        selectedIndex = buttonIndex
        sendActions(for: .valueChanged)
    }
    
    private let selectorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 12.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func configureViewHierarchy() {
        addSubview(selectorStackView)
        
        NSLayoutConstraint.activate([
            selectorStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            selectorStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            selectorStackView.topAnchor.constraint(equalTo: topAnchor),
            selectorStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configureViewHierarchy()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        configureViewHierarchy()
    }
}
