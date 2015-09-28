#import "CalculatorViewController.h"

#import "CalculatorModel.h"

@interface CalculatorViewController ()

@property(nonatomic) CalculatorModel *calculatorModel;

//TODO:Drag an outlet to the UILabel here so you can access it via code.
@property (weak, nonatomic) IBOutlet UILabel *currentResultLabel;

@property (weak, nonatomic) UIButton *lastOperatorPressed;

@property BOOL lastPressedWasNumber;
@property BOOL justCalculatedResult;
@end

@implementation CalculatorViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Initialize the CalculatorModel
  self.calculatorModel = [[CalculatorModel alloc] init];
    _lastPressedWasNumber = NO;
    _justCalculatedResult = NO;
}

- (void) displayResult {
    NSString *resultString;
    if([_calculatorModel isIntegralNumber:_calculatorModel.currentResult]){
     resultString = [[NSNumber numberWithInteger:[ _calculatorModel.currentResult integerValue] ] stringValue];
    }
    else{
        resultString = _calculatorModel.currentResult.stringValue;
    }
    
    if ([resultString length ]>10){
        _currentResultLabel.font = [_currentResultLabel.font fontWithSize:30];
        resultString = [[NSString alloc] initWithFormat:@"%e",[resultString doubleValue]];
    }
    
    else if([resultString length]>5){
         _currentResultLabel.font = [_currentResultLabel.font fontWithSize:30];
    }
    else{
        _currentResultLabel.font = [_currentResultLabel.font fontWithSize:90];
        }

    _currentResultLabel.text= resultString;
    
}

- (BOOL) labelIsCurrentlyZero{
    return [_currentResultLabel.text isEqualToString:@"0"]||[_currentResultLabel.text isEqualToString:@"0."];
}

- (NSNumber *) readLabel{
    return [NSNumber numberWithFloat: [_currentResultLabel.text floatValue]];
}

- (void) appendToResultLabel: (NSString *) toAdd{
    NSString * numberString = [_currentResultLabel.text stringByAppendingString: toAdd];
    
     if([numberString length]>10 ){
        [self displayTooLongMessage];
    }
    else if([numberString length]>5 ){
        _currentResultLabel.font = [_currentResultLabel.font fontWithSize:30];
    }
   
    else{
         _currentResultLabel.font = [_currentResultLabel.font fontWithSize:90];
    }
    
    _currentResultLabel.text = [_currentResultLabel.text stringByAppendingString: toAdd];
}

- (IBAction)numberButtonPressed:(id)sender {
    // unhighlight the old operator pressed if needed
    [_lastOperatorPressed setSelected:NO];
    // Explicit cast to a UIButton because we know the sender will always be a UIButton.
    UIButton *buttonPressed = (UIButton *)sender;
    NSString *pressed =buttonPressed.titleLabel.text;
    
    //if the last thing pressed was a number
    //append to the current number

    if(_lastPressedWasNumber){
        if([self labelIsCurrentlyZero]){
            //completely overwrite label
            _currentResultLabel.font = [_currentResultLabel.font fontWithSize:90];
            _currentResultLabel.text = pressed;
        }
        
    //if the last thing on the display was 0, overwrite with current number
    else{
            [self appendToResultLabel: pressed];
        }
    }
    
    //else, if the last thing was an operator, start a new number
    else{//what if it was equals... think!
        
        //update with previous operand before clearing
        if(![_calculatorModel isCalculatorCleared])
        {[_calculatorModel setOperand2:[self readLabel]];}
        _currentResultLabel.text = pressed;
    }
    
    NSLog(@"%@", pressed);//print pressed to console
    _lastPressedWasNumber = YES;
    _justCalculatedResult=NO;
}

- (IBAction)operatorButtonPressed:(id)sender{
    //if the last element pressed was an operator,
    //then update the operator
    //highlight the new operator pressed and unhighlight the old one
    //otherwise update current result and display current thing//
    
    UIButton *buttonPressed = (UIButton *)sender;
    //unselect previous operator
    [_lastOperatorPressed setSelected:NO];
    //select new operator
    [sender setSelected: YES];
    //update value of last pressed
    _lastOperatorPressed = sender;
    //update the model with the value of the number
    //that was just entered
    
     [_calculatorModel setOperand2:[self readLabel]];

    _justCalculatedResult=NO;
    if(_lastPressedWasNumber){
        //reset last pressed was number flag as no longer true
        _lastPressedWasNumber = NO;
        //if it's the first time after clearing... don't
        //calculate result yet, otherwise update result and label
        if(!_calculatorModel.isCalculatorCleared){
            [self calculateAndVerifyResult];
            [self displayResult];//before updating current operator, display current result
            _justCalculatedResult=true;
        }
        //update current operator... or do that later?
        NSString *operator = buttonPressed.titleLabel.text;
        NSLog(@"%@", operator);
        [_calculatorModel setOperator:operator];
        [_calculatorModel setIsCalculatorCleared:NO];
    }
}

- (IBAction)equalButtonPressed: (id)sender{
    //
    
    NSString *password = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
    
    if([password isEqualToString:[[self readLabel] stringValue]]){
    [self performSegueWithIdentifier:@"secretSegue" sender: self];
    
    }
    
    //if equals was pressed, calculate result
    if(!_justCalculatedResult){
        [_calculatorModel setOperand2:[self readLabel]];}
    [self calculateAndVerifyResult];
    [self displayResult];
    _justCalculatedResult=YES;
}

- (IBAction)clearButtonPressed: (id)sender{
    [_calculatorModel reset];
    [self displayResult];
}

- (IBAction) plusMinusButtonPressed: (id) sender{
    _currentResultLabel.text =[[NSNumber numberWithFloat:     [[self readLabel] floatValue] *-1] stringValue];

}

- (IBAction) decimalButtonPressed: (id) sender{
    //check that current label does't contain decimals already
    if([self labelIsCurrentlyZero]){
        _lastPressedWasNumber=YES;//a little hacky
    }
    
    else if(![_calculatorModel isIntegralNumber:[self readLabel]]){
        //silently ignore
        NSLog(@"Not integral!");
    }
    else{
        [self appendToResultLabel:@"."];
    }
}

-(IBAction) percentageButtonPressed: (id) sender{
    // if calculator was just reset,
    //current text /100
    //otherwise get percentage of previous result
    
    //calculate percentage of current result
    //do the operation requested
    //TODO FIX IF PTGOFNUL
    
    NSNumber * ptg = [self readLabel];
    NSNumber * ptgOf;
    
    if(_calculatorModel.isCalculatorCleared){
        ptgOf = [NSNumber numberWithFloat:
                 [[self readLabel] floatValue] / 100];

        _calculatorModel.isCalculatorCleared = NO;
        [_calculatorModel setOperand2:ptgOf];
        
    }
    
    else{
        ptgOf =  [_calculatorModel calculatePercentageOfPrevious:ptg];
    [_calculatorModel setOperand2:ptgOf];
    [self calculateAndVerifyResult];
    _justCalculatedResult = YES;
    }
    
      [self displayResult];
    _lastPressedWasNumber=NO;
}

- (void) calculateAndVerifyResult{
    int res = [_calculatorModel calculateResult];
    if(res==-1){
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                            message:@"Can't perform that operation"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Hm, k"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        [_calculatorModel reset];
    }
}

- (void) displayTooLongMessage{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                        message:@"No. too long"
                                                       delegate:nil
                                              cancelButtonTitle:@"Hm, k"
                                              otherButtonTitles:nil, nil];
    [alertView show];
    [_calculatorModel reset];

}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    UITabBarController *tabBarController = segue.destinationViewController;
    
    tabBarController.selectedIndex = 0;
}


@end