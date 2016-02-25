/**
 * xSnake
 * Snake clone made for OS X.
 *
 * The MIT License (MIT)
 *
 * Copyright (C) 2016 The xSnake Project
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
#define ARC4RANDOM_MAX 0x100000000

#import "GameScene.h"
#import "Coin.h"

@implementation GameScene
static const int snakeHitCategory = 1;
static const int coinHitCategory = 2;

static double screenWidth;
static double screenHeight;

SKShapeNode *shape;
Coin *coinLogic;

const float veloMAX = 200;

SKAction *movement;
SKAction *rotation;

bool moveUp = false;
bool moveLeft = false;
bool moveDown = false;
bool moveRight = false;

float snakeVeloX;
float snakeVeloY;

//@TODO Add Action instead of booleans for moving sprite.
//Fix real collisions, Add classes for snake.

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    self.physicsWorld.contactDelegate = self;
    
    screenWidth = self.frame.size.width;
    screenHeight = self.frame.size.height;
    
    self.backgroundColor = [SKColor colorWithRed: 0.0 green: 0.0 blue: 0.0 alpha: 1.0];
    
    shape = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(50.0, 50.0)];
    shape.strokeColor = [SKColor redColor];
    shape.lineWidth = 3;
    shape.position = CGPointMake(100.0, 100.0);
    shape.fillColor = [SKColor redColor];
    CGSize shapeSize = CGSizeMake(50, 50);
    
    shape.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:shapeSize];
    shape.physicsBody.dynamic = YES;
    shape.physicsBody.usesPreciseCollisionDetection = YES;
    shape.physicsBody.categoryBitMask = snakeHitCategory;
    shape.physicsBody.contactTestBitMask = coinHitCategory;
    shape.physicsBody.collisionBitMask = 0;
    
    snakeVeloX = 0;
    snakeVeloY = 0;
    rotation = [SKAction rotateByAngle:M_PI_4/6 duration:0];
    
    [self createCoin];
    
    
    [self addChild:coinLogic];
    [self addChild:shape];
    
}

/*-(void)mouseDown:(NSEvent *)theEvent {
      Called when a mouse click occurs */
    
  /*  CGPoint location = [theEvent locationInNode:self];
    
    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
    
    sprite.position = location;
    sprite.scale = 0.5;
    
    SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
    
    [sprite runAction:[SKAction repeatActionForever:action]];
    
    [self addChild:sprite];
}*/

-(void)keyDown:(NSEvent *)theEvent {
    NSString *key = [theEvent charactersIgnoringModifiers];
    unichar keyChar = 0;
    
    if ([key length] == 1) {
        keyChar = [key characterAtIndex:0];
        
        switch (keyChar) {
            case NSUpArrowFunctionKey:
                moveUp = true;
                //movement = [SKAction moveByX:0 y:velo duration: 0];
                //[shape runAction:movement withKey: @"MoveUp"];
                //shape.position = CGPointMake(shape.position.x, shape.position.y + velo);
                break;
            case NSLeftArrowFunctionKey:
                moveLeft = true;
                //[shape runAction:rotation withKey:@"Left"];
                //shape.position = CGPointMake(shape.position.x - velo, shape.position.y);
                break;
            case NSDownArrowFunctionKey:
                moveDown = true;
                //shape.position = CGPointMake(shape.position.x, shape.position.y - velo);
                break;
            case NSRightArrowFunctionKey:
                moveRight = true;
                //shape.position = CGPointMake(shape.position.x + velo, shape.position.y);
                break;
        }
    }
}

-(void)keyUp:(NSEvent *)theEvent {
    NSString *key = [theEvent charactersIgnoringModifiers];
    unichar keyChar = 0;
    
    if ([key length] == 1) {
        keyChar = [key characterAtIndex:0];
        
        switch (keyChar) {
            case NSUpArrowFunctionKey:
                moveUp = false;
                [shape removeActionForKey: @"MoveUp"];
                //shape.position = CGPointMake(shape.position.x, shape.position.y + velo);
                break;
            case NSLeftArrowFunctionKey:
                moveLeft = false;
                //shape.position = CGPointMake(shape.position.x - velo, shape.position.y);
                //[shape removeActionForKey: @"Left"];
                break;
            case NSDownArrowFunctionKey:
                moveDown = false;
                //shape.position = CGPointMake(shape.position.x, shape.position.y - velo);
                break;
            case NSRightArrowFunctionKey:
                moveRight = false;
                //shape.position = CGPointMake(shape.position.x + velo, shape.position.y);
                break;
        }
    }
}

-(void)didBeginContact:(SKPhysicsContact *)contact {
    NSLog(@"snake hit the Coin");
    SKPhysicsBody *firstBody, *secondBody;
    
    firstBody = contact.bodyA;
    secondBody = contact.bodyB;
    
    if(firstBody.categoryBitMask == snakeHitCategory || secondBody.categoryBitMask == snakeHitCategory)
    {
        
        NSLog(@"snake hit the Coin");
        //setup your methods and other things here
        [coinLogic removeFromParent];
        [coinLogic respawnCoin];
        [self addChild:coinLogic];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    /*if (moveUp) {
        shape.position = CGPointMake(shape.position.x, shape.position.y + velo);
    }*/
    
    shape.physicsBody.velocity = CGVectorMake(snakeVeloX, 0);
    
    if (moveLeft) {
        //shape.position = CGPointMake(shape.position.x - velo, shape.position.y);
        [shape runAction:rotation withKey:@"Left"];
        NSLog(@"Current Angle: %f", shape.zRotation);
        
        snakeVeloX -= 10;
        snakeVeloY += shape.zRotation * 100;
        
        if (snakeVeloX >= veloMAX) {
            snakeVeloX = veloMAX;
        } else if (snakeVeloX <= -veloMAX) {
            snakeVeloX = -veloMAX;
        }
        
        if (snakeVeloY <= -200) {
            snakeVeloY = -200;
        }
    }
    
    /*if (moveDown) {
        shape.position = CGPointMake(shape.position.x, shape.position.y - velo);
    }*/
    
    if (moveRight) {
        //shape.position = CGPointMake(shape.position.x + velo, shape.position.y);
        [shape runAction:rotation withKey:@"Left"];
        NSLog(@"Current Angle: %f", shape.zRotation);
        
        snakeVeloX += 10;
        snakeVeloY += shape.zRotation * 100;
        
        if (snakeVeloX >= veloMAX) {
            snakeVeloX = veloMAX;
        } else if (snakeVeloX <= -veloMAX) {
            snakeVeloX = -veloMAX;
        }
        
        if (snakeVeloY <= -200) {
            snakeVeloY = -200;
        }
    }
    
}

-(void)createCoin {
    coinLogic = [[Coin new] initWithCollision:snakeHitCategory :coinHitCategory :self.frame.size.width :self.frame.size.height];
    
    [coinLogic setProperties:screenWidth :screenHeight];
    
    coinLogic.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50, 50)];
    coinLogic.physicsBody.dynamic = YES;
    coinLogic.physicsBody.usesPreciseCollisionDetection = YES;
    coinLogic.physicsBody.categoryBitMask = coinHitCategory;
    coinLogic.physicsBody.contactTestBitMask = snakeHitCategory;
    coinLogic.physicsBody.collisionBitMask = 0;
    coinLogic.physicsBody.affectedByGravity = NO;
}

@end
