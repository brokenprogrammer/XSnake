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

@synthesize coinWidth;
@synthesize coinHeight;
@synthesize coinSize;
@synthesize screenWidth;
@synthesize screenHeight;
@synthesize posX;
@synthesize posY;



-(float) randomPos: (float) min :(float) max {
    return (float)arc4random() / ARC4RANDOM_MAX * (max - min);
}

-(id)initWithCollision:(int)SnakeCat CoinCat:(int)CoinCat screenWidth:(CGFloat)screenW screenHeight:(CGFloat)screenH {
    self = [super init];
    if(self)
    {
        SKTexture* CoinTexture1 = [SKTexture textureWithImageNamed:@"Spaceship"];
        
        self = [Coin spriteNodeWithTexture:CoinTexture1];
        self.name = @"coin";
        self.userInteractionEnabled = YES;
        [self setTexture:CoinTexture1];
        
        self.scale = 0.5;
        
        self.position = CGPointMake([self randomPos:0 :screenW], [self randomPos:0 :screenH]);
        
        self.posX = self.position.x;
        self.posY = self.position.y;
        
        //NSLog(@"POSX: %f, WIDTH: %CGFloat, SHEIGHT: %f", self.posX, self.coinWidth, self.screenHeight);
    }
    return self;
}

-(void)setProperties: (CGFloat) screenW :(CGFloat)screenH {
    self.coinWidth = 25;
    self.coinHeight = 25;
    self.coinSize = CGSizeMake(self.coinWidth, self.coinHeight);
    self.screenWidth = screenW;
    self.screenHeight = screenH;
    self.posX = self.position.x;
    self.posY = self.position.y;
}

-(void) respawnCoin{
    //self.position = CGPointMake([self randomPos:0 :screenW], [self randomPos:0 :screenH]);
    self.position = CGPointMake([self randomPos:0 :self.screenWidth], [self randomPos:0 :self.screenHeight]);
    self.posX = self.position.x;
    self.posY = self.position.y;
    NSLog(@"After: %f", self.position.x);
}

-(void)update:(NSTimeInterval) delta {
    
}

@end