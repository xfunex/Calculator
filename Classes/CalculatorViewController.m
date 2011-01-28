//
//  CalculatorViewController.m
//  Calculator
//
//  Created by james sa on 2010/11/21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"

@implementation CalculatorViewController
- (CalculatorBrain *)brain
{
	if (!brain) brain = [[CalculatorBrain alloc] init];
	return brain;
}

-(IBAction)digitPressed:(UIButton *)sender
{
	NSString *digit = [[sender titleLabel] text];
	
	NSString *num = [display text];
	NSRange range = [num rangeOfString:@"."];
	if ([digit isEqual:@"."]) {
		if (range.location == NSNotFound)
			digit = @".";
		else
			digit = @"";
	}
	
	if (userIsInTheMiddleOfTypingANumber) {
		[display setText:[[display text] stringByAppendingString:digit]];
	} else {
		[display setText:digit];
		userIsInTheMiddleOfTypingANumber = YES;
	}
}


-(IBAction)operationPressed:(UIButton *)sender
{
	if (userIsInTheMiddleOfTypingANumber){
		[[self brain] setOperand:[[display text] doubleValue]];
		userIsInTheMiddleOfTypingANumber = NO;
	}
	NSString *operation = [[sender titleLabel] text];
	double result = [[self brain] performOperation:operation];
	[display setText:[NSString stringWithFormat:@"%g", result]];
}

@end
