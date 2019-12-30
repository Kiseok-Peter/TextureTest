//
//  ExampleNode1.swift
//  TextureTest
//
//  Created by 박기석 on 2019/12/30.
//  Copyright © 2019 Peter. All rights reserved.
//

import AsyncDisplayKit

class ExampleNode1: ASDisplayNode {
    
    // MARK: UI Properties
    
    let imageNode = ASImageNode()
    
    // MARK: Node Life Cycle
    
    override init() {
        super.init()
        // TODO: Background Thread에서 동작
        self.addSubnode(imageNode)
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
        // TODO: 순수하게 Texture에서 제공해주는 LayoutSpec 및 Layout Elements Properties 만 사용
        let layoutSpec = ASInsetLayoutSpec(insets: .zero, child: imageNode)
        layoutSpec.style.height = .init(unit: .points, value: 500)
        return layoutSpec
    }
}
