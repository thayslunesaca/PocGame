//
//  ObjectHelper.swift
//  Super Indie Runner iOS
//
//  Created by Tales Valente on 19/04/23.
//

import SpriteKit


class ObjectHelper {
    
    static func handleChild(sprite: SKSpriteNode, with name: String) {
        switch name {
            case GameConstants.StringConstants.finishLineName:
                PhysicsHelper.addPhysicsBody(to: sprite, with: name)
            default:
                break
        }
    }
}
