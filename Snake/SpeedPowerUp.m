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

#import "SpeedPowerUp.h"

@implementation SpeedPowerUp {
    
}

@synthesize screenWidth;
@synthesize screenHeight;

@synthesize Square1;
@synthesize Square1_WIDTH;
@synthesize Square1_HEIGHT;
@synthesize Square1_SIZE;
@synthesize Square1_X;
@synthesize Square1_Y;

@synthesize Square2;
@synthesize Square2_WIDTH;
@synthesize Square2_HEIGHT;
@synthesize Square2_SIZE;
@synthesize Square2_X;
@synthesize Square2_Y;


/*
 * setProperties
 * Function to after object is initialised set the properties of the object.
 *
 * @param screenW - Width of the game screen.
 * @param screenH - Height of the game screen.
 */
-(void)setProperties: (CGFloat) screenW :(CGFloat)screenH {
    self.screenWidth = screenW;
    self.screenHeight = screenH;
    self.squareRotation = [SKAction rotateByAngle:M_PI_4 duration:1];
    
    self.Square1_WIDTH = 50;
    self.Square1_HEIGHT = 50;
    self.Square1_SIZE = CGSizeMake(self.Square1_WIDTH, self.Square1_HEIGHT);
    self.Square1_X = 400;
    self.Square1_Y = 400;
    Square1 = [SKShapeNode shapeNodeWithRectOfSize:self.Square1_SIZE];
    Square1.fillColor = [SKColor redColor];
    Square1.position = CGPointMake(self.Square1_X, self.Square1_Y);
    
    self.Square2_WIDTH = 50;
    self.Square2_HEIGHT = 50;
    self.Square2_SIZE = CGSizeMake(self.Square2_WIDTH, self.Square2_HEIGHT);
    self.Square2_X = 650;
    self.Square2_Y = 400;
    Square2 = [SKShapeNode shapeNodeWithRectOfSize:self.Square2_SIZE];
    Square2.fillColor = [SKColor redColor];
    Square2.position = CGPointMake(self.Square2_X, self.Square2_Y);
    
    [self.Square1 runAction:[SKAction repeatActionForever:self.squareRotation]];
    [self.Square2 runAction:[SKAction repeatActionForever:self.squareRotation]];
    
    [self addChild:self.Square1];
    [self addChild:self.Square2];
}
@end