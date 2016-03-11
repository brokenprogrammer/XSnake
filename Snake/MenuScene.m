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

#import "MenuScene.h"

@implementation MenuScene

/* Game Objects */
SKLabelNode *logoLabel;
SKLabelNode *newgameLabel;
SKLabelNode *instructionLabel;
SKLabelNode *exitLabel;

bool hoverNew = false;
bool hoverInstruction = false;
bool hoverExit = false;

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
    self.backgroundColor = [SKColor colorWithRed: 0.0 green: 0.0 blue: 0.0 alpha: 1.0];
    
    logoLabel = [SKLabelNode node];
    logoLabel.text = @"xSnake";
    logoLabel.fontSize = 100;
    logoLabel.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 150);
    
    /* Score Tracking Label */
    newgameLabel = [SKLabelNode node];
    newgameLabel.name = @"new";
    newgameLabel.text = @"New Game";
    newgameLabel.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 300);
    
    instructionLabel = [SKLabelNode node];
    instructionLabel.text = @"Instructions";
    instructionLabel.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 400);
    
    exitLabel = [SKLabelNode node];
    exitLabel.text = @"Exit Game";
    exitLabel.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 500);
    
    [self addChild:logoLabel];
    [self addChild:newgameLabel];
    [self addChild:instructionLabel];
    [self addChild:exitLabel];
}

-(void)mouseMoved:(NSEvent *)theEvent {
    /* Called when the mouse has moved */
    CGPoint location = [theEvent locationInNode:self];
    
    if (CGRectContainsPoint(newgameLabel.frame, location)) {
        hoverNew = true;
    } else {
        hoverNew = false;
    }
    
    if (CGRectContainsPoint(instructionLabel.frame, location)) {
        hoverInstruction = true;
    } else {
        hoverInstruction = false;
    }
    
    if (CGRectContainsPoint(exitLabel.frame, location)) {
        hoverExit = true;
    } else {
        hoverExit = false;
    }
}

-(void)mouseDown:(NSEvent *)theEvent {
    /* Called when a mouse click occurs */
    
    CGPoint location = [theEvent locationInNode:self];
    
    //SKNode *node = [self nodeAtPoint:location];
    
    if (CGRectContainsPoint(newgameLabel.frame, location)) {
        /* Start new game */
    }
    
    if (CGRectContainsPoint(instructionLabel.frame, location)) {
        /* Display instructions */
    }
    
    if (CGRectContainsPoint(exitLabel.frame, location)) {
        [NSApp terminate:self];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    if (hoverNew) {
        [newgameLabel removeFromParent];
        newgameLabel.fontColor = [SKColor redColor];
        [self addChild:newgameLabel];
    } else if (hoverNew == false) {
        [newgameLabel removeFromParent];
        newgameLabel.fontColor = [SKColor whiteColor];
        [self addChild:newgameLabel];
    }
    
    if (hoverInstruction) {
        [instructionLabel removeFromParent];
        instructionLabel.fontColor = [SKColor redColor];
        [self addChild:instructionLabel];
    } else if (hoverInstruction == false) {
        [instructionLabel removeFromParent];
        instructionLabel.fontColor = [SKColor whiteColor];
        [self addChild:instructionLabel];
    }
    
    if (hoverExit) {
        [exitLabel removeFromParent];
        exitLabel.fontColor = [SKColor redColor];
        [self addChild:exitLabel];
    } else if (hoverExit == false) {
        [exitLabel removeFromParent];
        exitLabel.fontColor = [SKColor whiteColor];
        [self addChild:exitLabel];
    }
}

@end