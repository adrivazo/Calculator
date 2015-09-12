#import "CalculatorViewController.h"

#import "CalculatorModel.h"

@interface CalculatorViewController ()

@property(nonatomic) CalculatorModel *calculatorModel;

//TODO:Drag an outlet to the UILabel here so you can access it via code.
@property (weak, nonatomic) IBOutlet UILabel *currentResultLabel;

@property (weak, nonatomic) UIButton *lastOperatorPressed;

@property BOOL lastPressedWasNumber;
@end

@implementation CalculatorViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Initialize the CalculatorModel
  self.calculatorModel = [[CalculatorModel alloc] init];
    _lastPressedWasNumber = NO;
}

- (void) displayResult {
    NSString *resultString;
    if([_calculatorModel isIntegralNumber:_calculatorModel.currentResult]){
     resultString = [[NSNumber numberWithInteger:[ _calculatorModel.currentResult integerValue] ] stringValue];
    }
    else{
        resultString = _calculatorModel.currentResult.stringValue;
    }
    _currentResultLabel.text= resultString;
}

- (BOOL) labelIsCurrentlyZero{
    return [_currentResultLabel.text isEqualToString:@"0"];
}

- (NSNumber *) readLabel{
    return [NSNumber numberWithFloat: [_currentResultLabel.text floatValue]];
}

- (void) appendToResultLabel: (NSString *) toAdd{
    _currentResultLabel.text = [_currentResultLabel.text stringByAppendingString: toAdd];
}

/**
  * Put any actions you want here.
  * Just control+click and drag from a
  * UI element to here. You can connect
  * multiple UI elements to the same action.
  * For example, you might want all the number
  * buttons to be connected to the same action.
  * This is a sample action (not connected to anything)
  * You can see that the sender argument is actually the
  * UI element that was pressed. You can use this argument
  * to retrieve valuable information about the ui element.
  */

- (IBAction)numberButtonPressed:(id)sender {
    
    // unhighlight the old operator pressed if needed
    [_lastOperatorPressed setSelected:NO];
    
    //if the last thing pressed was a number
        //append to the current number
    
    //if the last thing on the display was 0, overwrite with current number
    
    //if the last thing was an operator, start a new number
    
    //update current result but don't display

    
    // Explicit cast to a UIButton because we know the sender will always be a UIButton.
    UIButton *buttonPressed = (UIButton *)sender;
    
    NSString *pressed =buttonPressed.titleLabel.text;
    
    if(_lastPressedWasNumber){
        if([self labelIsCurrentlyZero]){
            //completely overwrite label
            _currentResultLabel.text = pressed;
        }
        else{
            //append instead
            [self appendToResultLabel: pressed];
        }
    }

    else{//last thing pressed was equals or an operator
        
        //update with previous operand before clearing
        [_calculatorModel setOperand2:[self readLabel]];
        _currentResultLabel.text = pressed;
        //calculate new result
    }
    
    
    NSLog(@"%@", pressed);//print pressed to console
    
    //If the last button pressed was a number, make sure to concatenate
    _lastPressedWasNumber = YES;
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
    
    if(_lastPressedWasNumber){
        _lastPressedWasNumber = NO;
        //if it's the first time after clearing... don't
        //calculate result yet
        if(!_calculatorModel.isCalculatorCleared){
            [_calculatorModel calculateResult];
            [self displayResult];//before updating current opearot, display current resule
        }


        //update current operator... or do that later?
        NSString *operator = buttonPressed.titleLabel.text;
        NSLog(@"%@", operator);
        [_calculatorModel setOperator:operator];
        [_calculatorModel setIsCalculatorCleared:NO];
    }
    
    else{
    
    }
}

- (IBAction)equalButtonPressed: (id)sender{
    //calculate result
    //if equals was pressed, calculate result
    [_calculatorModel setOperand2:[self readLabel]];
    [_calculatorModel calculateResult];
    [self displayResult];
}

- (IBAction)clearButtonPressed: (id)sender{
    [_calculatorModel reset];
    [self displayResult];
}

- (IBAction) plusMinusButtonPressed: (id) sender{
    //TODO fix
    [_calculatorModel negateResult];
}

- (IBAction) decimalButtonPressed: (id) sender{
    //check that current label does't contain decimals already
    if(![_calculatorModel isIntegralNumber:[self readLabel]]){
        //silently ignore
        NSLog(@"Not integral!");
    
    }
    else{
        [self appendToResultLabel:@"."];
    }
}
@end