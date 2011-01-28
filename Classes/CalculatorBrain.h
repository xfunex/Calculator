//
//  CalculatorBrain.h
//  Calculator
//
//  Created by james sa on 2010/11/21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CalculatorBrain : NSObject {
//2
@private
	double operand;
	NSString *waitingOperation;
	double waitingOperand;
	double memory;
}
//3
@property double operand;
- (double)performOperation:(NSString *)operation;

@end
