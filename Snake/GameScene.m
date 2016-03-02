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
#define DEGREES_TO_RADIANS( degrees ) ( ( degrees ) / 180.0 * M_PI )

#import "GameScene.h"
#import "Coin.h"
#import "Snake.h"

@implementation GameScene
static const int snakeHitCategory = 1;
static const int coinHitCategory = 2;

static const int rotateSpeed = 2;
static const int snakeSpeed = 2;

static double screenWidth;
static double screenHeight;

Coin *coinLogic;
Snake *snake;
SKEmitterNode *explosionEmitter;

SKAction *movement;
SKAction *rotation;
SKAction *rotation2;

bool moveUp = false;
bool moveLeft = false;
bool moveDown = false;
bool moveRight = false;

float angle;

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    self.physicsWorld.contactDelegate = self;
    
    NSString *explostionPath = [[NSBundle mainBundle]
                                pathForResource:@"ExplosionParticle" ofType:@"sks"];
    
    explosionEmitter = [NSKeyedUnarchiver unarchiveObjectWithFile:explostionPath];
    
    
    explosionEmitter.name = @"explosion";
    explosionEmitter.targetNode = self.scene;
    
    screenWidth = self.frame.size.width;
    screenHeight = self.frame.size.height;
    
    self.backgroundColor = [SKColor colorWithRed: 0.0 green: 0.0 blue: 0.0 alpha: 1.0];
    
    angle = 1;
    rotation = [SKAction rotateByAngle:M_PI_4/20 duration:0];
    rotation2 = [SKAction rotateByAngle:-(M_PI_4/20) duration:0];
    
    [self createSnake];
    [self createCoin];
    
    
    [self addChild:coinLogic];
    [self addChild:snake];
}

-(void)keyDown:(NSEvent *)theEvent {
    NSString *key = [theEvent charactersIgnoringModifiers];
    unichar keyChar = 0;
    
    if ([key length] == 1) {
        keyChar = [key characterAtIndex:0];
        
        switch (keyChar) {
            case NSUpArrowFunctionKey:
                moveUp = true;
                break;
            case NSLeftArrowFunctionKey:
                moveLeft = true;
                break;
            case NSDownArrowFunctionKey:
                moveDown = true;
                break;
            case NSRightArrowFunctionKey:
                moveRight = true;
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
                break;
            case NSLeftArrowFunctionKey:
                moveLeft = false;
                break;
            case NSDownArrowFunctionKey:
                moveDown = false;
                break;
            case NSRightArrowFunctionKey:
                moveRight = false;
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
        explosionEmitter.position = CGPointMake(coinLogic.position.x, coinLogic.position.y);
        [self addChild:explosionEmitter];
        [coinLogic removeFromParent];
        
        //Make snake longer
        [self newSnake];
        
        [coinLogic respawnCoin];
        [self addChild:coinLogic];
        [explosionEmitter removeFromParent];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    float newXPosition;
    float newYPosition;
    
    newXPosition = snake.position.x - sinf(DEGREES_TO_RADIANS(angle)) * snakeSpeed;
    newYPosition = snake.position.y + cosf(DEGREES_TO_RADIANS(angle)) * snakeSpeed;
    
    snake.position = CGPointMake(newXPosition, newYPosition);
    
    if (moveLeft) {
        angle += rotateSpeed;
        snake.zRotation = snake.zRotation + DEGREES_TO_RADIANS(rotateSpeed);
    }
    
    if (moveRight) {
        angle-= rotateSpeed;
        snake.zRotation = snake.zRotation - DEGREES_TO_RADIANS(rotateSpeed);
    }
    
    [snake updateSnakeParts:snake.position.x :snake.position.y :angle];
    NSLog(@"Angle: %f", angle);
}

-(void)createCoin {
    coinLogic = [[Coin new] initWithCollision:snakeHitCategory
                                      CoinCat:coinHitCategory screenWidth:self.frame.size.width screenHeight:self.frame.size.height];
    
    [coinLogic setProperties:screenWidth :screenHeight];
    
    coinLogic.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50, 50)];
    coinLogic.physicsBody.dynamic = YES;
    coinLogic.physicsBody.usesPreciseCollisionDetection = YES;
    coinLogic.physicsBody.categoryBitMask = coinHitCategory;
    coinLogic.physicsBody.contactTestBitMask = snakeHitCategory;
    coinLogic.physicsBody.collisionBitMask = 0;
    coinLogic.physicsBody.affectedByGravity = NO;
}

-(void)createSnake {
    snake = [[Snake new] initWithCollision:snakeHitCategory :coinHitCategory];
    
    [snake setProperties:screenWidth :screenHeight];
}

-(void)newSnake {
    Snake *newSnake = [[Snake new] initWithCollision:snakeHitCategory :coinHitCategory];
    [newSnake setProperties:screenWidth :screenHeight];
    newSnake.position = CGPointMake(snake.position.x - sinf(DEGREES_TO_RADIANS(angle)) * -1,
                                    snake.position.y + cosf(DEGREES_TO_RADIANS(angle)) * -1);
    newSnake.zRotation = snake.zRotation;
    [[snake snakeParts] addObject:newSnake];
    [snake addSnakePart:newSnake];
    [self addChild:newSnake];
}

@end
