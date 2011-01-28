//
//  CalculatorViewController.m
//  Calculator
//
//  Created by james sa on 2010/11/21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"

//8
@interface CalculatorViewController()
@property (readonly) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

//9
- (CalculatorBrain *)brain
{
	if (!brain) brain = [[CalculatorBrain alloc] init];
	return brain;
}

-(IBAction)digitPressed:(UIButton *)sender
{
	//5 NSString *digit = [[sender titleLabel] text];
	NSString *digit = sender.titleLabel.text;
	NSString *num = display.text;
	
	NSRange range = [num rangeOfString:@"."];
	if ([digit isEqual:@"."]) {
		if (range.location == NSNotFound)
			digit = @".";
		else
			digit = @"";
	}
	
	if (userIsInTheMiddleOfTypingANumber) {
		//6 [display setText:[[display text] stringByAppendingString:digit]];
		display.text = [display.text stringByAppendingString:digit];
	} else {
		//7 [display setText:digit];
		display.text = digit;
		userIsInTheMiddleOfTypingANumber = YES;
	}
}


-(IBAction)operationPressed:(UIButton *)sender
{
	if (userIsInTheMiddleOfTypingANumber){
		//1. [[self brain] setOperand:[[display text] doubleValue]];
		self.brain.operand = display.text.doubleValue;
		userIsInTheMiddleOfTypingANumber = NO;
	}
	NSString *operation = [[sender titleLabel] text];
	//10 double result = [[self brain] performOperation:operation];
	[self.brain performOperation:operation];
	display.text = [NSString stringWithFormat:@"%g", self.brain.operand];
}

@end
