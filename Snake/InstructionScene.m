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

@implementation InstructionScene

SKScene *menu;
SKLabelNode *instructionsTitle;

SKLabelNode *backLabel;

- (void)setMenuScene: (SKScene*)scene {
    menu = scene;
}

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
    
    [self addChild:instructionsTitle];
}

-(void)mouseMoved:(NSEvent *)theEvent {
}

-(void)mouseDown:(NSEvent *)theEvent {
}

-(void)update:(CFTimeInterval)currentTime {
}

@end