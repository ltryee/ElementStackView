//
//  ViewController.swift
//  ElementStackView-iOS-Demo
//
//  Created by liutianyang on 2023/12/18.
//

import Foundation
import UIKit
import SnapKit
import SwiftUI

class StackViewController: UIViewController {
    typealias EType = ElementType
    
    lazy var stackView = {
        let stackView = ElementStackView<ConcreteElementGenerator>(elementGenerator: ConcreteElementGenerator())
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.backgroundColor = .lightGray.withAlphaComponent(0.1)
//        stackView.spacing = 10
        return stackView
    }()
    
    lazy var anotherStackView = {
        let stackView = ElementStackView<AnotherElementGenerator>(elementGenerator: AnotherElementGenerator())
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.backgroundColor = .lightGray.withAlphaComponent(0.1)
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.centerY.equalToSuperview()
        }
        stackView.addArrangedElements(loginElementList())
        
        view.addSubview(anotherStackView)
        anotherStackView.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(stackView.snp.bottom).offset(10)
        }
        anotherStackView.addArrangedElements(loginElementList())
    }
    
    func loginElementList() -> [EType] {
        return [
            .segment(items: ["登录", "注册"], defaultIndex: 0, onTapped: nil),
            .spacer(height: 15),
            .commonInput(label: "User Name: ", placeHolder: "Email/Phone/ID", onTextChanged: { text in
                print("User Name: \(String(describing: text))")
            }),
            .spacer(height: 15),
            .commonInput(label: "Password: ", placeHolder: "Password", onTextChanged: { text in
                print("Password: \(String(describing: text))")
            }),
            .spacer(height: 10),
            .checker(title: "记住用户名", checked: false, onTapped: { checked in
                print("checked: \(checked)")
            }),
            .spacer(height: 10),
            .button(title: "登录", onTapped: nil)
        ]
    }
    
    func setupSubviews() {
        let elementList = loginElementList()
        stackView.addArrangedElements(elementList)
    }
}

#Preview {
    StackViewController()
}
