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

#define DEGREES_TO_RADIANS( degrees ) ( ( degrees ) / 180.0 * M_PI )

#import "Snake.h"

@implementation Snake {
    
}

/*
 * initWithCollision
 * Initialiser function for the Snake class.
 *
 * @param SnakeCat - Collision category for the snake it should respond to.
 * @param CoinCat - Collision category the coin should hate.
 *
 * @returns new Snake instance.
 */
-(id)initWithCollision:  (int)SnakeCat :(int)CoinCat{
    self = [super init];
    
    if (self) {
        self = [Snake spriteNodeWithImageNamed:@"Spaceship"];
        
        self.name = @"snake";
        self.userInteractionEnabled = YES;
        
        self.position = CGPointMake(400, 350);
        CGSize shapeSize = CGSizeMake(50, 50);
        self.scale = 0.5;
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:shapeSize];
        self.physicsBody.dynamic = YES;
        self.physicsBody.usesPreciseCollisionDetection = YES;
        self.physicsBody.categoryBitMask = SnakeCat;
        self.physicsBody.contactTestBitMask = CoinCat;
        self.physicsBody.collisionBitMask = 0;
    }
    
    return self;
}

/*
 * setProperties
 * Function to after object is initialised set the properties of the object.
 *
 * @param screenW - Width of the game screen.
 * @param screenH - Height of the game screen.
 */
-(void)setProperties: (CGFloat) screenW :(CGFloat)screenH {
    self.snakeWidth = 50;
    self.snakeHeight = 50;
    self.snakeSize = CGSizeMake(self.snakeWidth, self.snakeHeight);
    self.screenWidth = screenW;
    self.screenHeight = screenH;
    self.snakeParts = [NSMutableArray array];
}

/*
 * update
 * Function that is called each frame to update the game.
 *
 * @param currentTime - The current time.
 */
-(void)update:(NSTimeInterval) delta {
    
}

/*
 * addSnakePart
 * Functions that adds a snake part to the current snake objects
 * snake part array.
 *
 * @param Snake - The Snake object to add.
 */
-(void)addSnakePart: (Snake*) newSnake {
    //[snakeParts addObject:newSnake];
    NSLog(@"snake parts: %lu", (unsigned long)[self.snakeParts count]);
}

/*
 * updateSnakeParts
 * Updates the position of the entire chain of snakeParts connected to this
 * Snake object. Moves the Snake Parts depending on distance to its parrent.
 *
 * @param lastX - The x position of the first Snake object.
 * @param lastY - The y position of the first Snake object.
 * @param lastRotation - The rotation of the first Snake object.
 */
-(void)updateSnakeParts: (CGFloat) lastX :(CGFloat) lastY :(CGFloat)lastRotation{
    if ([self.snakeParts count] > 0) {
        Snake *thisSnake = self.snakeParts[0];
        
        CGFloat oldRot = thisSnake.zRotation;
        CGFloat oldX = thisSnake.position.x;
        CGFloat oldY = thisSnake.position.y;
        
        CGFloat dX = lastX - thisSnake.position.x;
        CGFloat dY = lastY - thisSnake.position.y;
        
        CGFloat dest = atan2f(dY, dX);
        
        thisSnake.zRotation = dest;
        
        float newXPosition;
        float newYPosition;
        if (sqrt((dX * dX) + (dY * dY)) > 25) {
            newXPosition = thisSnake.position.x + cosf(dest) * 2;
            newYPosition = thisSnake.position.y + sinf(dest) * 2;
        
            thisSnake.position = CGPointMake(newXPosition, newYPosition);
        } else {
            newXPosition = thisSnake.position.x + cosf(dest) * 1;
            newYPosition = thisSnake.position.y + sinf(dest) * 1;
            
            thisSnake.position = CGPointMake(newXPosition, newYPosition);
        }
        
        for (int x = 1; x < [self.snakeParts count]; x++) {
            Snake *currSnake = self.snakeParts[x];
        
            CGFloat thisX = currSnake.position.x;
            CGFloat thisY = currSnake.position.y;
        
            CGFloat deltaX = oldX - currSnake.position.x;
            CGFloat deltaY = oldY - currSnake.position.y;
            
            CGFloat destination = atan2(deltaY, deltaX);
            
            currSnake.zRotation = destination;
            
            if (sqrt((deltaX * deltaX) + (deltaY * deltaY)) > 25) {
                currSnake.position = CGPointMake(currSnake.position.x + cosf(destination) * 2,
                                                 currSnake.position.y + sinf(destination) * 2);
            } else {
                currSnake.position = CGPointMake(currSnake.position.x + cosf(destination) * 1,
                                                 currSnake.position.y + sinf(destination) * 1);
            }
            
            oldX = thisX;
            oldY = thisY;
            NSLog(@"X: %i", x);
        }
    }
}

@end