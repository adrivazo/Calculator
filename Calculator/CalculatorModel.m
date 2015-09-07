#import "CalculatorModel.h"

@interface CalculatorModel ()

//TODO: Any private properties or methods should be declared here.

// Declare operand1.
@property(nonatomic, strong) NSNumber *operand1;

//TODO: Declare operand2 and something to hold the operator.

@end

@implementation CalculatorModel

- (instancetype)init {
  self = [super init];
  if (self) {
    //TODO: Any setup you need should go here.
  }
  return self;
}

- (NSNumber *)currentResult {
  return self.operand1;
}


// The result should be calculated when the user presses equals or selects another operator.
- (void)calculateResult {
  //TODO: logic for calculating the result based on the operator and assigning it to operand1.
}

@end
