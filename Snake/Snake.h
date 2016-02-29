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

#ifndef Snake_h
#define Snake_h

#import <SpriteKit/SpriteKit.h>

@interface Snake : SKSpriteNode {
    
}

@property (nonatomic) int snakeWidth;
@property (nonatomic) int snakeHeight;
@property (nonatomic) CGSize snakeSize;
@property (nonatomic) CGFloat screenWidth;
@property (nonatomic) CGFloat screenHeight;
@property (nonatomic) NSMutableArray* snakeParts;

-(id)initWithCollision:  (int)SnakeCat :(int)CoinCat;
-(void)setProperties: (CGFloat) screenW :(CGFloat)screenH;
-(void)update:(NSTimeInterval) delta;
-(void)addSnakePart: (Snake*) newSnake;
-(void)updateSnakeParts: (CGFloat) lastX :(CGFloat) lastY :(CGFloat)lastRotation;
@end

#endif /* Snake_h */
