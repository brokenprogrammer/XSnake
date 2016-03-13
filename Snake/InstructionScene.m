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

#import "InstructionScene.h"
#import "MenuScene.h"

@implementation InstructionScene

SKLabelNode *instructionsTitle;
SKLabelNode *instructionOne;
SKLabelNode *instructionTwo;
SKLabelNode *instructionThree;
SKLabelNode *instructionFour;
SKLabelNode *backLabel;

bool hoverBack = false;

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
    
    instructionsTitle = [SKLabelNode node];
    instructionsTitle.name = @"logo";
    instructionsTitle.text = @"xSnake";
    instructionsTitle.fontSize = 100;
    instructionsTitle.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 150);
    
    instructionOne = [SKLabelNode node];
    instructionOne.text = @"To controll the snake use the left and right arrow keys.";
    instructionOne.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 200);
    
    instructionTwo = [SKLabelNode node];
    instructionTwo.text = @"Collide with the other planes to get points and grow longer.";
    instructionTwo.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 240);
    
    instructionThree = [SKLabelNode node];
    instructionThree.text = @"Collide with the red squares to get a speed boost.";
    instructionThree.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 280);
    
    instructionFour = [SKLabelNode node];
    instructionFour.text = @"Carefull you loose if you collide with yourself.";
    instructionFour.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 320);
    
    backLabel = [SKLabelNode node];
    backLabel.text = @"Back";
    backLabel.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 500);
    
    [self addChild:instructionsTitle];
    [self addChild:instructionOne];
    [self addChild:instructionTwo];
    [self addChild:instructionThree];
    [self addChild:instructionFour];
    [self addChild:backLabel];
}

/*
 * mouseMoved
 * Activates when a mouse was moved.
 *
 * @param theEvent - The current event containing the information about mouse.
 */
-(void)mouseMoved:(NSEvent *)theEvent {
    CGPoint location = [theEvent locationInNode:self];
    
    if(CGRectContainsPoint(backLabel.frame, location)) {
        hoverBack = true;
    } else {
        hoverBack = false;
    }
}

/*
 * mouseDown
 * Activates when a mouse key was pushed down.
 *
 * @param theEvent - The current event containing the information about push.
 */
-(void)mouseDown:(NSEvent *)theEvent {
    CGPoint location = [theEvent locationInNode:self];
    
    if (CGRectContainsPoint(backLabel.frame, location)) {
        /* Display MainMenu */
        SKTransition *reveal = [SKTransition fadeWithDuration:3];
        
        MenuScene *scene = [MenuScene sceneWithSize:CGSizeMake(1024, 768)];
        scene.scaleMode = SKSceneScaleModeAspectFit;
        [self.view presentScene:scene transition:reveal];
    }
}

/*
 * update
 * Function that is called each frame to update the game.
 *
 * @param currentTime - The current time.
 */
-(void)update:(CFTimeInterval)currentTime {
    
    if (hoverBack) {
        [backLabel removeFromParent];
        backLabel.fontColor = [SKColor redColor];
        [self addChild:backLabel];
    } else if (hoverBack == false) {
        [backLabel removeFromParent];
        backLabel.fontColor = [SKColor whiteColor];
        [self addChild:backLabel];
    }
    
}

@end