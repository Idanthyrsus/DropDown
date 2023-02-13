//
//  ViewController.swift
//  DropDown
//
//  Created by Alexander Korchak on 12.02.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var dropDownButton: DropDownButton = {
        let button = DropDownButton()
        var configuration = DropDownButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
        configuration.image = UIImage(systemName: "chevron.up")
        configuration.imagePadding = 210
        configuration.imagePlacement = .trailing
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer({ incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            return outgoing
        })
        
        button.configurationUpdateHandler = { [weak self] button in
            var config = button.configuration
            let symbolName = self?.dropDownButton.isOpen ?? true ? "chevron.up" : "chevron.down"
            config?.image = UIImage(systemName: symbolName)
            button.configuration = config
        }
        
        configuration.titleAlignment = .leading
        var symbolConfiguration = UIImage.SymbolConfiguration(paletteColors: [.black])
        symbolConfiguration = symbolConfiguration.applying(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 12, weight: .bold)))
        configuration.preferredSymbolConfigurationForImage = symbolConfiguration
       
        button.configuration = configuration
        button.setTitle("Доставка", for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupButton()
    }
    
    private func setupButton() {
        self.view.addSubview(dropDownButton)
        
        self.dropDownButton.layer.shadowColor = UIColor.lightGray.cgColor
        self.dropDownButton.layer.shadowOpacity = 0.4
        self.dropDownButton.layer.shadowRadius = 11
        self.dropDownButton.layer.shadowOffset = CGSize.zero
        self.dropDownButton.layer.cornerRadius = 22.0
        
        dropDownButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top).offset(100)
            make.centerX.equalTo(self.view.snp.centerX)
            make.width.equalTo(343)
            make.height.equalTo(50)
        }
    }
}

