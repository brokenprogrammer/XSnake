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

/* Collision detection categories */
static const int snakeHitCategory = 1;
static const int coinHitCategory = 2;
static const int snakePartHitCategory = 3;

/* Speed variables */
static const int rotateSpeed = 2; /* Rotation speed in degrees */
static const int snakeSpeed = 2;  /* Movement speed in pixels */

/* Screen size */
static double screenWidth;
static double screenHeight;

float angle;

/* Game Objects */
Coin *coinLogic; /* Coin that will be reused for addding length to the snake */
Snake *snake;    /* The snake that will be player controlled */

SKEmitterNode *explosionEmitter; /* Emitter for effect of picking up coin. */
CFTimeInterval emitterTimer;     /* Timer for stopping emitter */
CFTimeInterval globalTimer;      /* Global time */

SKAction *movement;
SKAction *rotation;
SKAction *rotation2;

SKAction *waitFor;
SKAction *fadeOut;
SKAction *removeNode;
SKAction *emitterSequence;

bool moveUp = false;
bool moveLeft = false;
bool moveDown = false;
bool moveRight = false;

/* 
 * didMoveToView
 * Initializer function here is where the scene starts.
 *
 * @param view - the view that will display the scene.
 */
-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    self.physicsWorld.contactDelegate = self;
    
    screenWidth = self.frame.size.width;
    screenHeight = self.frame.size.height;
    
    self.backgroundColor = [SKColor colorWithRed: 0.0 green: 0.0 blue: 0.0 alpha: 1.0];
    
    angle = 1;
    rotation = [SKAction rotateByAngle:M_PI_4/20 duration:0];
    rotation2 = [SKAction rotateByAngle:-(M_PI_4/20) duration:0];
    
    waitFor = [SKAction waitForDuration:0.8];
    fadeOut = [SKAction fadeOutWithDuration:0.25];
    removeNode = [SKAction removeFromParent];
    emitterSequence = [SKAction sequence:@[waitFor, removeNode]];
    
    [self createSnake];
    [self createCoin];
    [self newExplostionEmitter];
    
    [self addChild:coinLogic];
    [self addChild:snake];
}

/*
 * keyDown
 * Activates when a key was pushed down.
 *
 * @param theEvent - The current event containing the pushed key.
 */
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

/*
 * keyUp
 * Activates when a key was released.
 *
 * @param theEvent - The current event containing the released key.
 */
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

/*
 * didBeginContact
 * The collision logic function that is called immediatley when two objects
 * with registered physicsbodies collides.
 *
 * @param contact - The current contact that was made between objects.
 */
-(void)didBeginContact:(SKPhysicsContact *)contact {
    NSLog(@"snake hit the Coin");
    SKPhysicsBody *firstBody, *secondBody;
    
    firstBody = contact.bodyA;
    secondBody = contact.bodyB;
    
    if((firstBody.categoryBitMask == coinHitCategory && secondBody.categoryBitMask == snakeHitCategory) ||
       (secondBody.categoryBitMask == coinHitCategory && firstBody.categoryBitMask == snakeHitCategory))
    {
        
        NSLog(@"snake hit the Coin");
        //setup your methods and other things here
        //[explosionEmitter removeFromParent];
        
        NSString *explostionPath = [[NSBundle mainBundle]
                                    pathForResource:@"ExplosionParticle" ofType:@"sks"];
        
        SKEmitterNode *exploEmitter;
        exploEmitter = [NSKeyedUnarchiver unarchiveObjectWithFile:explostionPath];
        exploEmitter.name = @"explosion";
        exploEmitter.targetNode = self.scene;
        
        exploEmitter.position = CGPointMake(coinLogic.position.x, coinLogic.position.y);
        [self addChild:exploEmitter];
        [exploEmitter runAction:emitterSequence];
       // emitterTimer = globalTimer + 0.8;
       // [self addChild:explosionEmitter];
        [coinLogic removeFromParent];
        
        //Make snake longer
        [self newSnake];
        
        [coinLogic respawnCoin];
        [self addChild:coinLogic];
    }
}

/*
 * update
 * Function that is called each frame to update the game.
 *
 * @param currentTime - The current time.
 */
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    globalTimer = currentTime;
    
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
    //NSLog(@"Angle: %f", angle);
    NSLog(@"Angle: %lu", (unsigned long)explosionEmitter.numParticlesToEmit);
    //NSLog(@"emitterTimer: %f currentTime: %f", emitterTimer, currentTime);
    //if (emitterTimer < currentTime) {
        //[explosionEmitter runAction:fadeOut];
       // [explosionEmitter removeFromParent];
        //[explosionEmitter runAction:emitterSequence];
   // }
}

/*
 * createCoin
 * Initialiser function for the Coin object.
 */
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

/*
 * createSnake
 * Initialiser function for the player controlled Snake object.
 */
-(void)createSnake {
    snake = [[Snake new] initWithCollision:snakeHitCategory :coinHitCategory];
    
    [snake setProperties:screenWidth :screenHeight];
}

/*
 * newSnake
 * Function used to append the length of the snake by creating a new snake and
 * setting it as a child for the original snake.
 */
-(void)newSnake {
    Snake *newSnake = [[Snake new] initWithCollision:snakePartHitCategory :coinHitCategory];
    [newSnake setProperties:screenWidth :screenHeight];
    
    Snake *lastSnake = [[snake snakeParts] lastObject];
    newSnake.position = CGPointMake(lastSnake.position.x - sinf(DEGREES_TO_RADIANS(angle)) * -1,
                                    lastSnake.position.y + cosf(DEGREES_TO_RADIANS(angle)) * -1);
    newSnake.zRotation = lastSnake.zRotation;
    [[snake snakeParts] addObject:newSnake];
    //[snake addSnakePart:newSnake];
    [self addChild:newSnake];
}

/*
 * newExplostionEmitter
 * Initialiser function for the explosion emitter object.
 */
-(void)newExplostionEmitter {
    NSString *explostionPath = [[NSBundle mainBundle]
                                pathForResource:@"ExplosionParticle" ofType:@"sks"];
    
    
    explosionEmitter = [NSKeyedUnarchiver unarchiveObjectWithFile:explostionPath];
    explosionEmitter.name = @"explosion";
    explosionEmitter.targetNode = self.scene;
}

@end
