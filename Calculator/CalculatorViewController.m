#import "CalculatorViewController.h"

#import "CalculatorModel.h"

@interface CalculatorViewController ()

@property(nonatomic) CalculatorModel *calculatorModel;

// Put any outlets you want here.
// Just control+click and drag them
// from the storyboard to here. See
// the provided demo code for examples.

//TODO:Drag an outlet to the UILabel here so you can access it via code.

@end

@implementation CalculatorViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Initialize the CalculatorModel
  self.calculatorModel = [[CalculatorModel alloc] init];
  
  // TODO: Any ViewController setup should go here.
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

#warning Only the 7,8 and 9 buttons are connected to this method. \
         Make sure to connect the rest of the number buttons \
         and remove this warning afterward.
  
  // Explicit cast to a UIButton because we know the sender
  // will always be a UIButton.
  UIButton *buttonPressed = (UIButton *)sender;
  // Print the text on the button to the console
  NSLog(@"%@", buttonPressed.titleLabel.text);

  
  //TODO:Connect the rest of the number buttons to this method by cntrl+click and drag
}

//TODO: Create methods for the operator buttons and equals buttons.

@end
