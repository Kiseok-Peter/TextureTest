//
//  NetworkServiceType.swift
//  TextureTest
//
//  Created by 박기석 on 2019/12/31.
//  Copyright © 2019 Peter. All rights reserved.
//

import Moya

protocol NetworkServieType: class {
    func request(_ api: NaverAPI) -> Observable<String>
}
