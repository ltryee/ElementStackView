//
//  ElementGenerator.swift
//  Example-iOS
//
//  Created by liutianyang on 2023/12/12.
//

import Foundation
import UIKit

protocol ElementGenerator {
    associatedtype EType
    
//    var containerView: UIStackView? { get }
    
    func addArrangedElements(_ elements: [EType], to stackView: UIStackView) -> Void
    func elementView(from element: EType) -> UIView
    func configureView(_ view: UIView, for element: EType) -> Void
}

extension ElementGenerator {
    func addArrangedElements(_ elements: [EType], to stackView: UIStackView) -> Void {
        for element in elements {
            let subview = elementView(from: element)
            stackView.addArrangedSubview(subview)
            configureView(subview, for: element)
        }
    }
}

//extension UIStackView {
//    func addArrangedElements<T: ElementGenerator.EType>(_ elements: [T]) -> Void {
//        for element in elements {
//            let subview = elementView(from: element)
//            addArrangedSubview(subview)
//            configureView(subview, for: element)
//        }
//    }
//}
