//
//  PasswordViewController.m
//  Calculator
//
//  Created by Adriana Catalina Vazquez Ortiz on 9/28/15.
//  Copyright (c) 2015 CIS195. All rights reserved.
//

#import "PasswordViewController.h"

@interface PasswordViewController ()

@end

@implementation PasswordViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
 _passwordTextField.delegate = self;
    
}


- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"view controller - first tab - appeared");
    
    NSString *password = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
    _passwordTextField.text= password;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)updatePassordButtonPressed:(id)sender {
    //first do some checks on the password... e.g. check it's only numbers, check not blank and that it's a valid entry on calculator
    
    [[NSUserDefaults standardUserDefaults] setValue:_passwordTextField.text forKey:@"password"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location != NSNotFound)
    {
        // BasicAlert(@"", @"This field accepts only numeric entries.");
        return NO;
    }
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
