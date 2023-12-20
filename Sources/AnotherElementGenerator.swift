//
//  AnotherElementGenerator.swift
//  Example-iOS
//
//  Created by liutianyang on 2023/12/12.
//

import UIKit
import RxSwift
import RxCocoa

struct AnotherElementGenerator: ElementGenerator {
    private let disposeBag: DisposeBag

    init(disposeBag: DisposeBag = DisposeBag()) {
        self.disposeBag = disposeBag
    }
    
    // MARK: ElementGenerator
    typealias EType = ElementType
    private(set) weak var containerView: UIStackView?
    
    func elementView(from element: ElementType) -> UIView {
        switch element {
        case let .centeredText(title: title):
            return createSingleLineText(title)
        case let .commonInput(label: label, placeHolder: placeHolder, onTextChanged: onTextChanged):
            return createCommonInput(label: label, placeHolder: placeHolder, onTextChanged: onTextChanged)
        case let .button(title: title, onTapped: onTapped):
            return createButton(title: title, onTapped: onTapped)
        case let .segment(items: items, defaultIndex: defaultIndex, onTapped: onTapped):
            return createSegmentedCountrol(items: items, defaultIndex: defaultIndex, onTapped: onTapped)
        case let .checker(title: title, checked: checked, onTapped: onTapped):
            return createChecker(title: title, checked: checked, onTapped: onTapped)
        case let .spacer(height: height):
            return createSpacer(height: height)
//        default:
//            preconditionFailure()
        }
    }
    
    func configureView(_ view: UIView, for element: ElementType) {
        switch element {
        case let .spacer(height: height):
            view.snp.makeConstraints { make in
                make.height.equalTo(height)
            }
        default: break
        }
    }
}

private extension AnotherElementGenerator {
    
    func createSingleLineText(_ title: String) -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.text = title
        label.textColor = .systemBlue
        return label
    }
    
    func createCommonInput(label: String,
                           placeHolder: String?,
                           onTextChanged: ((String?) -> Void)?) -> UIView {
        let view = UIView()
        
        let promptLabel = UILabel()
        promptLabel.textAlignment = .left
        promptLabel.text = label
        view.addSubview(promptLabel)
        promptLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(0)
        }
        promptLabel.setContentHuggingPriority(.required, for: .horizontal)
        promptLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        let textFiled = UITextField()
        textFiled.placeholder = placeHolder ?? ""
        textFiled.rx.text.subscribe(onNext: { text in
            onTextChanged?(text)
        }).disposed(by: disposeBag)
        view.addSubview(textFiled)
        textFiled.snp.makeConstraints { make in
            make.left.equalTo(promptLabel.snp.right)
            make.right.equalTo(0)
            make.centerY.equalToSuperview()
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        return view
    }
    
    func createButton(title: String, onTapped: (() -> Void)?) -> UIButton {
        let button = UIButton()
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBlue
        button.rx.tap.subscribe(onNext: { onTapped?() }).disposed(by: disposeBag)
        
        return button
    }
    
    func createSegmentedCountrol(items: [Any], defaultIndex: Int, onTapped: ((Int) -> Void)?) -> UISegmentedControl {
        let segment = UISegmentedControl(items: items)
        segment.selectedSegmentIndex = defaultIndex
        segment.rx.selectedSegmentIndex.skip(1).subscribe(onNext: { index in
            onTapped?(index)
        }).disposed(by: disposeBag)
        return segment
    }
    
    func createChecker(title: String, checked: Bool, onTapped: ((Bool) -> Void)?) -> UIView {
        let checkerControl = UIControl()
        checkerControl.isSelected = checked
        
        let contentView = UIView()
        contentView.isUserInteractionEnabled = false
        checkerControl.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        let imageName = checked ? "checkmark.circle.fill" : "checkmark.circle"
        let iconImageView = UIImageView(image: UIImage(systemName: imageName))
        iconImageView.tintColor = .lightGray
        contentView.addSubview(iconImageView)
        
        let label = UILabel()
        label.text = title
        label.textColor = .tertiaryLabel
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalTo(iconImageView.snp.right).offset(5)
        }
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        iconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(label.snp.top)
            make.bottom.equalTo(label.snp.bottom)
            make.width.equalTo(iconImageView.snp.height)
        }
        
        checkerControl.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak checkerControl] in
            guard let weakChecker = checkerControl else { return }
            
            let newChecked = !weakChecker.isSelected
            weakChecker.isSelected = newChecked
            
            let imageName = newChecked ? "checkmark.circle.fill" : "checkmark.circle"
            iconImageView.image = UIImage(systemName: imageName)
            
            onTapped?(newChecked)
        }).disposed(by: disposeBag)
        
        return checkerControl
    }
    
    func createSpacer(height: CGFloat) -> UIView {
        return UIView()
    }
}
