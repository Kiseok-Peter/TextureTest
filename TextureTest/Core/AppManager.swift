//
//  AppManager.swift
//  TextureTest
//
//  Created by 박기석 on 2019/12/31.
//  Copyright © 2019 Peter. All rights reserved.
//

final class AppManager {
    
    // MARK: Singleton
    
    private init() {}
    
    static let shared = AppManager()
    
    // MARK: Constants
    
    let naverId: String = "C4WWhzY992DA1yOxCHMk"
    let naverSecret: String = "vMabas77u9"
}
