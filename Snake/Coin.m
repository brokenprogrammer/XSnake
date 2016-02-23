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

#import "Coin.h"

@implementation Coin {
    
}

-(float) randomPos: (float) min :(float) max {
    return (float)arc4random() / ARC4RANDOM_MAX * (max - min);
}

- (SKShapeNode *)createCoin: (int)SnakeCat :(int)CoinCat: (int)screenW :(int)screenH {
    self.WIDTH = 25;
    self.HEIGHT = 25;
    self.SIZE = CGSizeMake(self.WIDTH, self.HEIGHT);
    self.SCREENWIDTH = screenW;
    self.SCREENHEIGHT = screenH;
    
    SKShapeNode *Coin = [SKShapeNode shapeNodeWithRectOfSize:self.SIZE];
    Coin.fillColor = [SKColor yellowColor];
    
    Coin.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.SIZE];
    Coin.physicsBody.dynamic = YES;
    Coin.physicsBody.usesPreciseCollisionDetection = YES;
    Coin.physicsBody.categoryBitMask = CoinCat;
    Coin.physicsBody.contactTestBitMask = SnakeCat;
    Coin.physicsBody.collisionBitMask = 0;
    Coin.position = CGPointMake([self randomPos:0 :screenW], [self randomPos:0 :screenH]);
    
    self.posX = Coin.position.x;
    self.posY = Coin.position.y;
    
    return Coin;
}

-(void) respawnCoin: (SKShapeNode *)coin{
    NSLog(@"Brefore: %f", coin.position.x);
    coin.position = CGPointMake([self randomPos:0 :self.SCREENWIDTH], [self randomPos:0 :self.SCREENHEIGHT]);
    NSLog(@"After: %f", coin.position.x);
}

-(void)update:(NSTimeInterval) delta {
    
}

@end