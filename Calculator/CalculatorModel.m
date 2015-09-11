// what is wrong with this import?

#import "CalculatorModel.h"

@interface CalculatorModel ()

//TODO: Any private properties or methods should be declared here.

// Declare operand1.
@property(nonatomic, strong) NSNumber *operand1;
@property(nonatomic, strong) NSNumber *operand2;
@property(nonatomic,strong) NSString *operator;
@property(nonatomic, strong) NSNumber *result;

//TODO: Declare operand2 and something to hold the operator.

@end

@implementation CalculatorModel

- (instancetype)init {
  self = [super init];
  if (self) {
    //TODO: Any setup you need should go here.
      [self reset];
  }
  return self;
}

-(void) reset{
    _operand1 = nil;
    _operand2 = nil;
    _isCalculatorCleared=YES;
}

- (NSNumber *)currentResult {
    return self.operand1;
}

// The result should be calculated when the user presses equals or selects another operator.
- (void)calculateResult {
  //TODO: logic for calculating the result based on the operator and assigning it to operand1.
    
    if([@"+" isEqualToString: _operator]){
        _operand1 = [NSNumber numberWithFloat:([_operand1 floatValue] + [_operand2 floatValue])];
    }
    
    if([@"-" isEqualToString: _operator]){
        _operand1 = [NSNumber numberWithFloat:([_operand1 floatValue] - [_operand2 floatValue])];
    }
    
    if([@"X" isEqualToString: _operator]){
        _operand1 = [NSNumber numberWithFloat:([_operand1 floatValue] * [_operand2 floatValue])];
    }
    
    if([@"/" isEqualToString: _operator]){
        _operand1 = [NSNumber numberWithFloat:([_operand1 floatValue] / [_operand2 floatValue])];
    }
    
    NSLog(@"Result is %@", _operand1);
}

- (void) setOperand2:(NSNumber *)op2{
    if(!_operand2){_operand1 = op2;}
    _operand1 = _operand2;// assign the old op1 to op2
    _operand2 = op2;//
    _isCalculatorCleared=NO;
}

@end
