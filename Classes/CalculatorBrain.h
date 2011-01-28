//
//  CalculatorBrain.h
//  Calculator
//
//  Created by james sa on 2010/11/21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CalculatorBrain : NSObject {
	double operand;
	NSString *waitingOperation;
	double waitingOperand;
	double memory;
}

- (void)setOperand:(double)aDouble;
- (double)performOperation:(NSString *)operation;

@end
