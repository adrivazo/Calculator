#import <Foundation/Foundation.h>

@interface CalculatorModel : NSObject

// declare any public methods or properties here.

// Used to get the current result.
- (NSNumber *)currentResult;
- (void) setOperand2 :(NSNumber *) op2;
- (void) setOperand1 :(NSNumber *) op1;
- (void) setOperator :(NSString *) opt;
- (void) calculateResult;
- (void) reset;
- (void) negateResult;
- (BOOL) isIntegralNumber: (NSNumber *) num;

@property (nonatomic) BOOL isCalculatorCleared;

@end
