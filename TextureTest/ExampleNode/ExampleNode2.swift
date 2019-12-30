//
//  ExampleNode2.swift
//  TextureTest
//
//  Created by 박기석 on 2019/12/30.
//  Copyright © 2019 Peter. All rights reserved.
//
//  ----------------------------------
//  Automatic Subnode Management (ASM)
//  layoutSpecThatFits 에서 직접적으로 영향받는 node를 addSubnode하거나
//  이전 layout에서 제거되는 node를 removeFromSupernode 를 자동으로 처리해주는 것

import AsyncDisplayKit

class ExampleNode2: ASDisplayNode {
    
    // MARK: UI Properties
    
    let buttonNode = ASButtonNode()
    let textNode = ASTextNode()
    
    var isButtonNodeOnly = false
    
    // MARK: Node Life Cycle
    
    override init() {
        super.init()
        // TODO: Background Thread에서 동작
        self.automaticallyManagesSubnodes = true // <- HERE!
    }
    
    override func didLoad() {
        super.didLoad()
        // TODO: Main Thread에서 접근 가능한 Property를 사용
        buttonNode.addTarget(self, action: #selector(didTapButton), forControlEvents: .touchUpInside)
    }
    
    @objc func didTapButton() {
        self.isButtonNodeOnly = !self.isButtonNodeOnly
        self.setNeedsLayout() // Layout을 다시 그려줘!
    }
    
    override func layout() {
        super.layout()
        // TODO: layout변화에 따른 업데이트가 필요한 추가적인 요소를 처리합니다.
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        // TODO: 순수하게 Texture에서 제공해주는 LayoutSpec 및 Layout Elements Properties 만 사용
        var elements: [ASLayoutElement] = [buttonNode]
        
        if !isButtonNodeOnly {
            elements.append(textNode)
        }
        
        return ASAbsoluteLayoutSpec(children: elements)
    }
}
