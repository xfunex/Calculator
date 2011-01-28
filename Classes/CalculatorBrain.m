//
//  CalculatorBrain.m
//  Calculator
//
//  Created by james sa on 2010/11/21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"


@implementation CalculatorBrain
//4
@synthesize operand;

- (void)performWaitingOperation
{
	if ([@"+" isEqual:waitingOperation])
		operand = waitingOperand + operand;
	else if ([@"*" isEqual:waitingOperation]) 
		operand = waitingOperand * operand;
	else if ([@"-" isEqual:waitingOperation])
		operand = waitingOperand - operand;
	else if ([@"/" isEqual:waitingOperation])
		if (operand) {
			operand = waitingOperand / operand;
		}
}

- (double)performOperation:(NSString *)operation
{
	if ([operation isEqual:@"sqrt"]) {
		operand = sqrt(operand);
	}
	else if([@"+/-" isEqual:operation]) {
		operand	= - operand;
	}
	else if ([@"sin" isEqual:operation]) {
		operand = sin(operand);
	}
	else if ([@"cos" isEqual:operation]) {
		operand = cos(operand);
	}
	else if ([@"1/x" isEqual:operation]) {
		if (operand) operand = 1 / operand;
	}
	else if ([@"store" isEqual:operation]) {
		memory = operand;
	}
	else if ([@"recall" isEqual:operation]) {
		operand = memory;
	}
	else if ([@"mem+" isEqual:operation]){
		operand += memory;
	}
	else if ([@"C" isEqual:operation]){
		operand	= waitingOperand = memory = 0;
		
	}	else {
		[self performWaitingOperation];
		waitingOperation = operation;
		waitingOperand = operand;
	}

	return operand;
}
@end
