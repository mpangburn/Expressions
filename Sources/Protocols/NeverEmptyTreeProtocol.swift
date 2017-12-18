//
//  NeverEmptyTreeProtocol.swift
//  Expression
//
//  Created by Michael Pangburn on 12/17/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


public protocol NeverEmptyTreeProtocol: TreeProtocol { }

extension NeverEmptyTreeProtocol {
    public var safeKind: Either<Leaf, Node> {
        guard let kind = kind else { fatalError("The tree cannot be empty.") }
        return kind
    }
}
