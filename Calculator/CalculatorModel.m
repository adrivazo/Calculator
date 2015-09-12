// what is wrong with this import?

#import "CalculatorModel.h"

@interface CalculatorModel ()

//TODO: Any private properties or methods should be declared here.

@property(nonatomic, strong) NSNumber *operand1;
@property(nonatomic, strong) NSNumber *operand2;
@property(nonatomic,strong) NSString *operator;


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

//reset all properties
-(void) reset{
    _operand1 = [NSNumber numberWithInteger:[@"0" integerValue]];
    _operand2 = nil;
    _operator=nil;
    _isCalculatorCleared=YES;
}

- (NSNumber *)currentResult {
    return self.operand1;
}


-(void) negateResult{
    //TODO
}


-(BOOL) isIntegralNumber:(NSNumber *)num{
    return (floor([num floatValue]) == [num floatValue]);
}


//method for calculating the result of the division, multiplication, subtraction and addition opea
- (void)calculateResult {
    
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
    _operand2 = op2;
}
@end