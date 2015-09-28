//
//  SecretNoteController.h
//  Calculator
//
//  Created by Adriana Catalina Vazquez Ortiz on 9/28/15.
//  Copyright (c) 2015 CIS195. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecretNoteController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *secretNoteTextArea;
@property (weak, nonatomic) IBOutlet UIButton *clearTextButton;
@property (weak, nonatomic) IBOutlet UIButton *saveNoteButton;
@end
