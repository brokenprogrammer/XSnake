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

#ifndef SpeedPowerUp_h
#define SpeedPowerUp_h

#import <SpriteKit/SpriteKit.h>

@interface SpeedPowerUp : SKNode

@property (nonatomic) CGFloat screenWidth;     /* Width of the game screen */
@property (nonatomic) CGFloat screenHeight;    /* Height of the game screen */
@property (nonatomic) SKAction *squareRotation; /**/

/* FIRST SQUARE PROPERTIES */
@property (nonatomic) SKShapeNode *Square1;  /**/
@property (nonatomic) CGFloat Square1_WIDTH; /**/
@property (nonatomic) CGFloat Square1_HEIGHT;/**/
@property (nonatomic) CGSize Square1_SIZE;   /**/
@property (nonatomic) CGFloat Square1_X;     /**/
@property (nonatomic) CGFloat Square1_Y;     /**/

/*
 * setProperties
 * Function to after object is initialised set the properties of the object.
 *
 * @param screenW - Width of the game screen.
 * @param screenH - Height of the game screen.
 */
-(void)setProperties: (CGFloat) screenW :(CGFloat)screenH;

/*
 * randomPos
 * Returns random number within the range of specified numbers.
 *
 * @param min - Min number object can spawn at.
 * @param man - Max number object can spawn at.
 *
 * @returns random number within range min & max.
 */
-(float) randomPos: (float) min :(float) max;

/*
 * respawnSpeedPowerUp
 * Function used by outside classes to respawn the powerUp in the game.
 */
-(void) respawnSpeedPowerUp;

@end

#endif /* SpeedPowerUp_h */