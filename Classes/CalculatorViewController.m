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
		display.text = [display.text stringByAppendingString:digit];
	} else {
		display.text = digit;
		userIsInTheMiddleOfTypingANumber = YES;
	}
}


-(IBAction)operationPressed:(UIButton *)sender
{
	if (userIsInTheMiddleOfTypingANumber){
		self.brain.operand = [display.text doubleValue];
		userIsInTheMiddleOfTypingANumber = NO;
	}
	NSString *operation = sender.titleLabel.text;
	
	if ([@"solve" isEqual:operation]) {
		NSDictionary *variables = [NSDictionary dictionaryWithObjectsAndKeys:
								   [NSNumber numberWithInt: 1],@"x",
								   [NSNumber numberWithInt: 10],@"a",
								   [NSNumber numberWithInt: 100],@"b",
								   [NSNumber numberWithInt: 1000],@"c",nil];
		display.text = [NSString stringWithFormat:@"%g",
						[CalculatorBrain evaluateExpression:self.brain.expression
										usingVariableValues:variables]];
	}else{
		[self.brain performOperation:operation];
		if([CalculatorBrain variablesInExpression:self.brain.expression])
			display.text = [CalculatorBrain descriptionOfExpression:self.brain.expression];
		else
			display.text = [NSString stringWithFormat:@"%g", self.brain.operand];
	}
}

-(IBAction)setVariableAsOperand:(UIButton *)sender
{
	if (userIsInTheMiddleOfTypingANumber){
		self.brain.operand = [display.text doubleValue];
		userIsInTheMiddleOfTypingANumber = NO;
	}
	NSString *variable = sender.titleLabel.text;
	[self.brain setVariableAsOperand:variable]; 
	NSLog(@"Got %d items", [self.brain.expression count]);
	display.text = [CalculatorBrain descriptionOfExpression:self.brain.expression];
}

-(void)dealloc
{
	[brain release];
	[super dealloc];
}
@end
