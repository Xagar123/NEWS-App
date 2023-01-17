//
//  NewsTableVIewCell.swift
//  News app
//
//  Created by Admin on 17/01/23.
//

import UIKit

final class NewsTableViewCell: UITableViewCell {
    
    var newsVM: NewsViewModel? {
        didSet{
            if let newsVM = newsVM {
                titleLable.text = newsVM.title
                NetworkManager.shared.getImage(urlString: newsVM.urlToImage) { data in
                    guard let data = data else { return }
                    DispatchQueue.main.async {
                        self.newsImage.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
    var newsImageData: Data? {
        didSet{
            if let data = newsImageData {
                newsImage.image = UIImage(data: data)
            }
        }
    }
    
    private lazy var newsImage: ShadowImageView = {
       let iv = ShadowImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var titleLable: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(titleLable)
        addSubview(newsImage)
        setupConstraints()
    }
    
    func setupConstraints() {
        
        //newsImage constraint
        NSLayoutConstraint.activate([
            newsImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            newsImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            newsImage.topAnchor.constraint(equalTo: topAnchor),
            newsImage.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        //title
        NSLayoutConstraint.activate([
            titleLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLable.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 8),
            titleLable.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
