//
//  GameScene.swift
//  sampleGame
//
//  Created by Fayez on 7/21/17.
//  Copyright © 2017 Fayez HELLANI. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var node: SKSpriteNode!
    var pauseLayer: SKSpriteNode!
    var gameState: GameState!
    
    enum GameState {
        case didntStart
        case inProgress
        case paused
    }
    
    //SK Methods:
    override func didMove(to view: SKView) {
        addObs()
        setupNode()
        setupPauseLayer()
        gameState = .didntStart
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameState == .didntStart {
            node.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi/2), duration: 0.2)))
            gameState = .inProgress
        } else if gameState == .inProgress {
            pauseGame()
        } else {
            resumeGame()
        }
    }
    
    //Setup methods:
    private func setupNode() {
        node = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 80))
        node.position = .zero
        self.addChild(node)
    }
    
    private func setupPauseLayer() {
        pauseLayer = SKSpriteNode(color: .blue, size: self.size)
        pauseLayer.position = .zero
        pauseLayer.alpha = 0
        self.addChild(pauseLayer)
    }
    
    //GamePlay methods:
    private func pauseGame() {
        node.isPaused = true
        pauseLayer.run(SKAction.fadeAlpha(to: 0.5, duration: 1))
        gameState = .paused
    }
    
    private func resumeGame() {
        pauseLayer.run(.fadeOut(withDuration: 1))
        node.isPaused = false
        gameState = .inProgress
    }
    
    //AppDelegate connection:
    func addObs() {
        let app = UIApplication.shared
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive(_:)), name: .UIApplicationWillResignActive, object: app)
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground(_:)), name: .UIApplicationDidEnterBackground, object: app)
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterForeground(_:)), name: .UIApplicationDidEnterBackground, object: app)
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive(_:)), name: .UIApplicationDidBecomeActive, object: app)
    }
    
    func applicationWillResignActive(_ notification: NSNotification) {
        print(#function)
    }
    
    func applicationDidEnterBackground(_ notification: NSNotification) {
        print(#function)
    }
    
    func applicationWillEnterForeground(_ notification: NSNotification) {
        print(#function)
    }
    
    func applicationDidBecomeActive(_ notification: NSNotification) {
        if gameState != .didntStart {
            pauseGame()
        }
        print(#function)
    }
    
}
