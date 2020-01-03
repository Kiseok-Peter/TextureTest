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
    
    let imageNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.defaultImage = UIImage(named: "Image")
        node.borderColor = UIColor.gray.cgColor
        node.borderWidth = 1
        node.cornerRadius = 15
        node.contentMode = .scaleAspectFill
        return node
    }()
    
    let titleNode: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 0
        return node
    }()
    
    let subtitleNode: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 0
        return node
    }()
    
    let userRatingNode: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 0
        return node
    }()
    
    let directorNode: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 0
        return node
    }()
    
    let actorNode: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 0
        return node
    }()
    
    init(item: MovieItem) {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.selectionStyle = .none
        self.backgroundColor = .white
        
        self.imageNode.url = URL(string: item.image)
        self.titleNode.attributedText = NSAttributedString(string: item.title,
                                                           attributes: [.font: UIFont.boldSystemFont(ofSize: 15),
                                                                        .foregroundColor: UIColor.gray])
        self.subtitleNode.attributedText = NSAttributedString(string: item.subtitle,
                                                              attributes: [.font: UIFont.boldSystemFont(ofSize: 13),
                                                                           .foregroundColor: UIColor.lightGray])
        self.userRatingNode.attributedText = NSAttributedString(string: String(describing: item.userRating),
                                                                attributes: [.font: UIFont.boldSystemFont(ofSize: 13),
                                                                             .foregroundColor: UIColor.lightGray])
        self.directorNode.attributedText = NSAttributedString(string: item.actor,
        attributes: [.font: UIFont.boldSystemFont(ofSize: 13),
                     .foregroundColor: UIColor.lightGray])
        self.actorNode.attributedText = NSAttributedString(string: item.actor,
                                                           attributes: [.font: UIFont.boldSystemFont(ofSize: 13),
                                                                        .foregroundColor: UIColor.lightGray])
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let imageLayout = ASRatioLayoutSpec(ratio: 1.0, child: imageNode)
        let contextLayout = layoutSpecThatFitsContext()
        
        imageLayout.style.flexBasis = ASDimension(unit: .fraction, value: 0.3)
        contextLayout.style.flexBasis = ASDimension(unit: .fraction, value: 0.7)
        
        let containerLayout = ASStackLayoutSpec(direction: .horizontal,
                                                spacing: 10.0,
                                                justifyContent: .start,
                                                alignItems: .stretch,
                                                children: [imageLayout, contextLayout])
        
        var containerInsets: UIEdgeInsets = .zero
        containerInsets.left = 15.0
        containerInsets.right = 15.0
        containerInsets.top = 15.0
        containerInsets.bottom = 15.0
        
        return ASInsetLayoutSpec(insets: containerInsets, child: containerLayout)
    }
    
    private func layoutSpecThatFitsContext() -> ASLayoutSpec {
        let containerLayout = ASStackLayoutSpec(direction: .vertical,
                                                spacing: 5.0,
                                                justifyContent: .start,
                                                alignItems: .stretch,
                                                children: [titleNode, subtitleNode, userRatingNode, directorNode, actorNode])
        
        return containerLayout
    }
}
