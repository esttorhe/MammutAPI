//
// Created by Esteban Torres on 14.04.17.
// Copyright (c) 2017 Esteban Torres. All rights reserved.
//

import Foundation

enum Result<T, E: Error> {
    case success(T)
    case failure(E)

    var value: T? {
        guard case .success(let value) = self else {
            return nil
        }
        return value
    }

    var error: E? {
        guard case .failure(let error) = self else {
            return nil
        }
        return error
    }

    func flatMap<U>(_ f: (T) -> Result<U, E>) -> Result<U, E> {
        switch self {
            case .success(let v): return f(v)
            case .failure(let e): return .failure(e)
        }
    }
}
