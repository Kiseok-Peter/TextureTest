//
//  FlextBoxNode.swift
//  TextureTest
//
//  Created by 박기석 on 2019/12/30.
//  Copyright © 2019 Peter. All rights reserved.
//

import AsyncDisplayKit

class FlexBoxNode: ASDisplayNode {
    
    // MARK: UI Properties
    
    let imageNode: ASImageNode = {
        let node = ASImageNode()
        node.backgroundColor = .blue
        return node
    }()
    
    let titleNode: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "asdfasef asdfasef asdfasef asdfasef asdfasef asdfasef")
        node.backgroundColor = .red
        return node
    }()
    
    // MARK: Node Life Cycle
    
    override init() {
        super.init()
        // TODO: Background Thread에서 동작
        self.automaticallyManagesSubnodes = true
    }
    
    override func didLoad() {
        super.didLoad()
        // TODO: Main Thread에서 접근 가능한 Property를 사용
    }
    
    override func layout() {
        super.layout()
        // TODO: layout변화에 따른 업데이트가 필요한 추가적인 요소를 처리합니다.
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let imageLayout = ASRatioLayoutSpec(ratio: 1.0, child: imageNode)
        imageLayout.style.width = .init(unit: .points, value: 50.0)
        
        imageLayout.style.flexShrink = 0.0
        imageLayout.style.flexGrow = 0.0
        titleNode.style.flexShrink = 0.0
        titleNode.style.flexGrow = 0.0
        
        let containerLayout = ASStackLayoutSpec(direction: .horizontal,
                                                spacing: 10,
                                                justifyContent: .start,
                                                alignItems: .stretch,
                                                children: [imageLayout, titleNode])
        
        return ASInsetLayoutSpec(insets: .zero, child: containerLayout)
    }
}
