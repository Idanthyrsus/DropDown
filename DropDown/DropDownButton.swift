//
//  DropDownButton.swift
//  DropDown
//
//  Created by Alexander Korchak on 12.02.2023.
//

import UIKit

class DropDownButton: UIButton, DropDownViewDelegate {
    
    let buttonController = ViewController()
    var height = NSLayoutConstraint()
    var isOpen = false {
        didSet {
            self.setNeedsUpdateConfiguration()
        }
    }
    
    private lazy var dropView: DropDownView = {
        let dropView = DropDownView()
        dropView.translatesAutoresizingMaskIntoConstraints = false
        
        dropView.layer.shadowColor = UIColor.lightGray.cgColor
        dropView.layer.shadowOpacity = 0.4
        dropView.layer.shadowRadius = 11
        dropView.layer.shadowOffset = CGSize.zero
        dropView.layer.cornerRadius = 22.0
        return dropView
    }()
    
    private lazy var exampleView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        view.layer.cornerRadius = 14
        return view
    }()
    
    
    private func setupView() {
        self.addSubview(exampleView)
        
        exampleView.snp.makeConstraints { make in
            make.top.equalTo(self.dropView.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(343)
            make.height.equalTo(150)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 14
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        setupDropView()
        setupView()
    }
    
    func dropDownPressed(string: String) {
        self.setTitle(string, for: .normal)
        self.dismissDropDown()
    }
    
    private func setupDropView() {
        dropView.delegate = self
        self.superview?.addSubview(dropView)
        self.superview?.bringSubviewToFront(dropView)
        NSLayoutConstraint.activate([
            dropView.topAnchor.constraint(equalTo: self.bottomAnchor),
            dropView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dropView.widthAnchor.constraint(equalTo: self.widthAnchor),
        ])
        height = dropView.heightAnchor.constraint(equalToConstant: 0)
    }
    
    private func dismissDropDown() {
        isOpen = false
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        NSLayoutConstraint.deactivate([height])
        self.height.constant = 0
        NSLayoutConstraint.activate([height])
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5) {
            self.dropView.center.y -= self.dropView.frame.height / 2
            self.dropView.layoutIfNeeded()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isOpen == false {
            isOpen = true
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            NSLayoutConstraint.deactivate([height])
            if self.dropView.tableView.contentSize.height > 150 {
                self.height.constant = 150
            } else {
                self.height.constant = self.dropView.tableView.contentSize.height
            }
         
            NSLayoutConstraint.activate([height])
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5) {
                self.dropView.layoutIfNeeded()
                self.dropView.center.y += self.dropView.frame.height / 2
            }
        } else {
            isOpen = false
            NSLayoutConstraint.deactivate([height])
            self.height.constant = 0
            NSLayoutConstraint.activate([height])
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5) {
                self.dropView.center.y -= self.dropView.frame.height / 2
                self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
                self.dropView.layoutIfNeeded()
            }
        }
    }
}
