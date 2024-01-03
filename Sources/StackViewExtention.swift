//
//  StackViewExtention.swift
//  Example-iOS
//
//  Created by liutianyang on 2023/12/11.
//

import UIKit
import RxSwift
import RxCocoa
import Resolver

enum ElementType {
    /// 居中的文字
    /// - Parameters:
    ///   - title: 居中显示的文字
    case centeredText(title: String)
    
    /// 输入框
    /// - Parameters:
    ///   - label: 左侧说明文字
    ///   - placeHolder: 输入框中的提示文字
    ///   - onTextChanged: 文本发生改变时的回调
    case commonInput(label: String, placeHolder: String?, onTextChanged: ((String?) -> Void)?)
    
    /// 按钮
    /// - Parameters:
    ///   - title: 按钮文字
    ///   - onTapped: 按钮点击回调
    case button(title: String, onTapped: (() -> Void)?)
    
    /// segment
    /// - Parameters:
    ///   - items: 段列表
    ///   - defaultIndex: 默认选中的段
    ///   - onTapped: 点击回调
    case segment(items: [Any], defaultIndex: Int, onTapped: ((Int) -> Void)?)
    
    /// checker
    /// - Parameters:
    ///   - title: checker 说明
    ///   - checked: 是否选中
    ///   - onTapped: 点击回调
    case checker(title: String, checked: Bool, onTapped: ((Bool) -> Void)?)
    
    /// 占位符
    /// - Parameters:
    ///   - height: 高度
    case spacer(height: CGFloat)
    
    /// 可滚动容器
    /// - Parameters:
    ///   - height: 容器高度，传入大于 0 的值表示显式设置控件的高度为 `height`；传入 0 表示不显式指定控件高度，由 `elements` 实际高度撑起此控件。
    ///   - elements: 容器中的元素列表
    case scrollableContainer(height: CGFloat, elements: [ElementType])
}

class ElementStackView<T: ElementGenerator>: UIStackView {
    typealias EType = T.EType
    
    @LazyInjected var elementGenerator: T

    func addArrangedElements<E>(_ elements: [E]) -> Void where E == EType {
        elementGenerator.addArrangedElements(elements, to: self)
    }
}
