//
//  ShadowImageView.swift
//  News app
//
//  Created by Admin on 17/01/23.
//

import UIKit

final class ShadowImageView: UIView {
    
    var image: UIImage? {
        didSet{
            imageView.image = image
        }
    }
    
    private lazy var imageView: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 20
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var baseView: UIView = {
       let iv = UIView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .clear
        iv.layer.shadowColor = UIColor.black.cgColor
        iv.layer.shadowOffset = CGSize(width: 5, height: 5)
        iv.layer.shadowOpacity = 0.7
        iv.layer.shadowRadius = 10.0
        return iv
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        baseView.layer.shadowPath = UIBezierPath(roundedRect: baseView.bounds, cornerRadius: 10).cgPath
        baseView.layer.shouldRasterize = true
        baseView.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func setupView() {
        addSubview(baseView)
        baseView.addSubview(imageView)
        setupConstraints()
    }
    
    func setupConstraints() {
        [baseView,imageView].forEach { view in
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                view.topAnchor.constraint(equalTo: topAnchor, constant: 16),
                view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
            ])
            
        }
    }
}
