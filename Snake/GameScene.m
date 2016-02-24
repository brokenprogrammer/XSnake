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
//SKShapeNode *gameCoin;

const float velo = 5.0;

SKAction *movement;

bool moveUp = false;
bool moveLeft = false;
bool moveDown = false;
bool moveRight = false;

//@TODO Add Action instead of booleans for moving sprite.
//http://stackoverflow.com/questions/22495285/sprite-kit-collision-detection
//Fix real collisions, Add classes for snake & Coin.

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    self.physicsWorld.contactDelegate = self;
    
    screenWidth = self.frame.size.width;
    screenHeight = self.frame.size.height;
    
    /*SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    myLabel.text = @"Hello, World!";
    myLabel.fontSize = 45;
    myLabel.fontColor = [SKColor colorWithRed: 255.0 green: 0.0 blue: 0.0 alpha: 1.0];
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    [self addChild:myLabel];*/
    
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
    
    //gameCoin = [coinLogic createCoin:snakeHitCategory :coinHitCategory :self.frame.size.width :self.frame.size.height];
    //coinLogic = [[Coin alloc] initWithCollision:snakeHitCategory :coinHitCategory :self.frame.size.width :self.frame.size.height];
    coinLogic = [[Coin new] initWithCollision:snakeHitCategory :coinHitCategory :self.frame.size.width :self.frame.size.height];
    
    coinLogic.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50, 50)];
    coinLogic.physicsBody.dynamic = YES;
    coinLogic.physicsBody.usesPreciseCollisionDetection = YES;
    coinLogic.physicsBody.categoryBitMask = coinHitCategory;
    coinLogic.physicsBody.contactTestBitMask = snakeHitCategory;
    coinLogic.physicsBody.collisionBitMask = 0;
    coinLogic.physicsBody.affectedByGravity = NO;
    
    [self addChild:coinLogic];
    [self addChild:shape];
    
    //movement = [SKAction moveByX:<#(CGFloat)#> y:<#(CGFloat)#> duration:<#(NSTimeInterval)#>];
    
    //[self drawGrid:view];
}

-(void)mouseDown:(NSEvent *)theEvent {
     /* Called when a mouse click occurs */
    
    CGPoint location = [theEvent locationInNode:self];
    
    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
    
    sprite.position = location;
    sprite.scale = 0.5;
    
    SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
    
    [sprite runAction:[SKAction repeatActionForever:action]];
    
    [self addChild:sprite];
}

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
        //[gameCoin removeFromParent];
        [coinLogic removeFromParent];
        [coinLogic respawnCoin:screenWidth :screenHeight];
        [self addChild:coinLogic];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    if (moveUp) {
        shape.position = CGPointMake(shape.position.x, shape.position.y + velo);
    }
    
    if (moveLeft) {
        shape.position = CGPointMake(shape.position.x - velo, shape.position.y);
    }
    
    if (moveDown) {
        shape.position = CGPointMake(shape.position.x, shape.position.y - velo);
    }
    
    if (moveRight) {
        shape.position = CGPointMake(shape.position.x + velo, shape.position.y);
    }
    
}

-(void)drawGrid:(SKView *)view {
    CGSize screenSize = CGSizeMake(CGRectGetMaxX(view.frame), CGRectGetMaxY(view.frame));
    
    float columns = screenSize.width / 25;
    float rows = screenSize.height / 25;
    
    NSLog(@"Columns: %f, Rows: %f", columns, rows);
    NSLog(@"Height: %f, Width: %f", screenSize.height, screenSize.width);
    
    for (int x = 0; x < columns; x++) {
        int pos = x*25;
        SKShapeNode *yourline = [SKShapeNode node];
        CGMutablePathRef pathToDraw = CGPathCreateMutable();
        CGPathMoveToPoint(pathToDraw, NULL, pos, 0.0);
        CGPathAddLineToPoint(pathToDraw, NULL, pos, screenSize.height);
        yourline.path = pathToDraw;
        [yourline setStrokeColor:[SKColor whiteColor]];
        [self addChild:yourline];
    }
    
    for (int y = 0; y < rows; y++) {
        int pos = y*25;
        SKShapeNode *yourline = [SKShapeNode node];
        CGMutablePathRef pathToDraw = CGPathCreateMutable();
        CGPathMoveToPoint(pathToDraw, NULL, 0.0, pos);
        CGPathAddLineToPoint(pathToDraw, NULL, screenSize.width, pos);
        yourline.path = pathToDraw;
        [yourline setStrokeColor:[SKColor whiteColor]];
        [self addChild:yourline];
    }
}

@end
