//
//  MovieCellNode.swift
//  TextureTest
//
//  Created by 박기석 on 2019/12/31.
//  Copyright © 2019 Peter. All rights reserved.
//

import AsyncDisplayKit

class MovieCellNode: ASCellNode {
    
    // MARK: UI Properties
    
//    let imageNode: ASImageNode = {
//        let node = ASImageNode()
//        node.image = UIImage(named: "Image")
//        node.borderColor = UIColor.gray.cgColor
//        node.borderWidth = 1
//        node.cornerRadius = 15
//        node.contentMode = .scaleAspectFit
//        return node
//    }()
    
    let imageNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.defaultImage = UIImage(named: "Image")
        node.borderColor = UIColor.gray.cgColor
        node.borderWidth = 1
        node.cornerRadius = 15
        node.contentMode = .scaleAspectFit
        return node
    }()
    
    let titleNode: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        return node
    }()
    
    init(item: MovieItem) {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.selectionStyle = .none
        self.backgroundColor = .white
        
        self.titleNode.attributedText = NSAttributedString(string: item.title,
                                                           attributes: [.font: UIFont.boldSystemFont(ofSize: 15),
                                                                        .foregroundColor: UIColor.gray])
        self.imageNode.url = URL(string: item.image)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let imageLayout = ASRatioLayoutSpec(ratio: 1.0, child: imageNode)
        
        imageLayout.style.flexBasis = ASDimension(unit: .fraction, value: 0.3)
        titleNode.style.flexBasis = ASDimension(unit: .fraction, value: 0.7)
        
        let containerLayout = ASStackLayoutSpec(direction: .horizontal,
                                                spacing: 10.0,
                                                justifyContent: .start,
                                                alignItems: .stretch,
                                                children: [imageLayout, titleNode])
        
        var containerInsets: UIEdgeInsets = .zero
        containerInsets.left = 15.0
        containerInsets.right = 15.0
        containerInsets.top = 15.0
        containerInsets.bottom = 15.0
        
        return ASInsetLayoutSpec(insets: containerInsets, child: containerLayout)
    }
}
