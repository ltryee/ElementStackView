//
//  StackViewExtention.swift
//  Example-iOS
//
//  Created by liutianyang on 2023/12/11.
//

import UIKit
import RxSwift
import RxCocoa

enum ElementType {
    case centeredText(title: String)
    case commonInput(label: String, placeHolder: String?, onTextChanged: ((String?) -> Void)?)
    case button(title: String, onTapped: (() -> Void)?)
    case segment(items: [Any], defaultIndex: Int, onTapped: ((Int) -> Void)?)
    case checker(title: String, checked: Bool, onTapped: ((Bool) -> Void)?)
    case spacer(height: CGFloat)
    case scrollableContainer(height: CGFloat, elements: [ElementType])
}

class ElementStackView<T: ElementGenerator>: UIStackView {
    typealias EType = T.EType
    
    let elementGenerator: T
    
    init(elementGenerator: T) {
        self.elementGenerator = elementGenerator
        super.init(frame: CGRectZero)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addArrangedElements<E>(_ elements: [E]) -> Void where E == EType {
        elementGenerator.addArrangedElements(elements, to: self)
    }
}
