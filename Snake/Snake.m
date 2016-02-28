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

#import "Snake.h"

@implementation Snake {
    
}

//NSMutableArray *snakeParts;

-(id)initWithCollision:  (int)SnakeCat :(int)CoinCat{
    self = [super init];
    
    if (self) {
        self = [Snake spriteNodeWithImageNamed:@"Spaceship"];
        
        self.name = @"snake";
        self.userInteractionEnabled = YES;
        
        self.position = CGPointMake(400, 350);
        CGSize shapeSize = CGSizeMake(50, 50);
        
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:shapeSize];
        self.physicsBody.dynamic = YES;
        self.physicsBody.usesPreciseCollisionDetection = YES;
        self.physicsBody.categoryBitMask = SnakeCat;
        self.physicsBody.contactTestBitMask = CoinCat;
        self.physicsBody.collisionBitMask = 0;
        
       // snakeParts = [NSMutableArray array];
    }
    
    return self;
}

-(void)setProperties: (CGFloat) screenW :(CGFloat)screenH {
    self.snakeWidth = 50;
    self.snakeHeight = 50;
    self.snakeSize = CGSizeMake(self.snakeWidth, self.snakeHeight);
    self.screenWidth = screenW;
    self.screenHeight = screenH;
    self.snakeParts = [NSMutableArray array];
}

-(void)update:(NSTimeInterval) delta {
    
}

-(void)addSnakePart: (Snake*) newSnake {
    //[snakeParts addObject:newSnake];
    NSLog(@"snake parts: %lu", (unsigned long)[self.snakeParts count]);
}

-(void)updateSnakeParts: (CGFloat) lastX :(CGFloat) lastY {
    if ([self.snakeParts count] > 0) {
        Snake *thisSnake = self.snakeParts[0];
    
        CGFloat oldX = thisSnake.position.x;
        CGFloat oldY = thisSnake.position.y;
    
        thisSnake.position = CGPointMake(lastX * 1.1, lastY * 1.1);
        for (int x = 1; x < [self.snakeParts count]; x++) {
            Snake *currSnake = self.snakeParts[x];
        
            CGFloat thisX = currSnake.position.x;
            CGFloat thisY = currSnake.position.y;
        
            currSnake.position = CGPointMake(oldX, oldY);
        
            oldX = thisX;
            oldY = thisY;
            NSLog(@"X: %i", x);
        }
    }
}

@end