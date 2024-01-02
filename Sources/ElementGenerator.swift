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
    
    /// 向 stack view 添加子控件
    /// - Parameters:
    ///   - elements: 子控件列表
    ///   - stackView: stack view
    func addArrangedElements(_ elements: [EType], to stackView: UIStackView)
    
    /// 根据子控件类型描述生成子控件
    /// - Parameter element: 子控件类型描述
    /// - Returns: 子控件
    func elementView(from element: EType) -> UIView
    
    /// 在子控件添加到 stack view 之后，继续设置子控件的属性
    /// - Parameters:
    ///   - view: 子控件
    ///   - element: 子控件描述
    func configureView(_ view: UIView, for element: EType)
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
