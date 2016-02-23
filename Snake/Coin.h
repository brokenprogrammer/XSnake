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

#ifndef Coin_h
#define Coin_h

#import <SpriteKit/SpriteKit.h>

@interface Coin : SKShapeNode {
    
}

@property (nonatomic) const int WIDTH;
@property (nonatomic) const int HEIGHT;
@property (nonatomic) const CGSize SIZE;
@property (nonatomic) const int SCREENWIDTH;
@property (nonatomic) const int SCREENHEIGHT;
@property (nonatomic) float posX;
@property (nonatomic) float posY;

- (SKShapeNode *)createCoin: (int)SnakeCat :(int)CoinCat: (int)screenW :(int)screenH;

-(float) randomPos: (float) min :(float) max;

-(void) respawnCoin: (SKShapeNode *)coin;

-(void)update:(NSTimeInterval) delta;

@end


#endif /* Coin_h */