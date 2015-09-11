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
  
  // TODO: Any ViewController setup should go here.
}

- (void) displayResult {
    _currentResultLabel.text = _calculatorModel.currentResult.stringValue;
}

- (BOOL) labelIsCurrentlyZero{
    return [_currentResultLabel.text isEqualToString:@"0"];
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
            _currentResultLabel.text = pressed;
        }
        else{
         _currentResultLabel.text = [_currentResultLabel.text stringByAppendingString: pressed];
        }
    }

    else{//last thing pressed was equals or an operator
          _currentResultLabel.text = pressed;
        //calculate new result
    }
    
    
    
    // Print the text on the button to the console
    NSLog(@"%@", pressed);
    //TODO:Connect the rest of the number buttons to this method by cntrl+click and drag
    
   // _currentResultLabel.text =pressed;
    //If the last button pressed was a number, make sure to concatenate
    _lastPressedWasNumber = YES;//or could do it by checking if 0?

    
}

- (IBAction)operatorButtonPressed:(id)sender{
    //if the last thing pressed was an operator,
    //then update the operator
    //highlight the new operator pressed and unhighlight the old one
    //otherwise update current result and display current thing//
    
    if(_lastPressedWasNumber){
        _lastPressedWasNumber = NO;
        UIButton *buttonPressed = (UIButton *)sender;
        //unselect previous operator
        [_lastOperatorPressed setSelected:NO];
        //select new operator
        [sender setSelected: YES];
        //update value of last pressed
        _lastOperatorPressed = sender;
        
        //update the model with the value of the number
        //that was just entered
        [_calculatorModel setOperand2:[NSNumber numberWithInteger: [_currentResultLabel.text integerValue]]];
        
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
    }
}

- (IBAction)equalButtonPressed: (id)sender{
    //calculate result
    //if equals was pressed, calculate result
    [_calculatorModel setOperand2:[NSNumber numberWithInteger: [_currentResultLabel.text integerValue]]];
    
    
    [_calculatorModel calculateResult];
    [self displayResult];
}
@end
