//
//  HeaderView.swift
//  News app
//
//  Created by Admin on 17/01/23.
//

import UIKit

class HeaderView: UIView {
    
    private var fontSize: CGFloat
    
    init(fontSize: CGFloat) {
        self.fontSize = fontSize
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var headingLable: UILabel = {
       let HLable = UILabel()
        HLable.translatesAutoresizingMaskIntoConstraints = false
        HLable.text = "News"
        HLable.font = UIFont.boldSystemFont(ofSize: fontSize)
        return HLable
    }()
    
    private lazy var plusImage: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: fontSize, weight: .bold)
        iv.image = UIImage(systemName: "plus", withConfiguration: config)?.withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    private lazy var headerCircleImage: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        let config = UIImage.SymbolConfiguration(pointSize: fontSize, weight: .bold)
        iv.image = UIImage(systemName: "largecircle.fill.circle", withConfiguration: config)?.withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    private lazy var subheadlineLable: UILabel = {
       let iv = UILabel()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.font = iv.font.withSize(fontSize)
        iv.text = "Top Headlines"
        iv.textColor = .gray
        return iv
    }()
    
    private lazy var headerStackView: UIStackView = {
       let iv = UIStackView(arrangedSubviews: [headerCircleImage,headingLable,plusImage])
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.axis = .horizontal
        return iv
    }()
    
    func setupView() {
        addSubview(headerStackView)
        addSubview(subheadlineLable)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        //News header
        NSLayoutConstraint.activate([
            headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerStackView.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        //sub headline
        NSLayoutConstraint.activate([
            subheadlineLable.leadingAnchor.constraint(equalTo: leadingAnchor),
            subheadlineLable.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 8),
            subheadlineLable.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

