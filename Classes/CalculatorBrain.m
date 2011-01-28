//
//  CalculatorBrain.m
//  Calculator
//
//  Created by james sa on 2010/11/21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"
#define VARIABLE_PREFIX @"%"

@implementation CalculatorBrain
@synthesize operand, waitingOperation;

- (NSMutableArray *)internalExpression
{
	if(!internalExpression){
		internalExpression = [[NSMutableArray alloc]initWithCapacity:5];
	}
	return internalExpression;
}

- (void)setOperand:(double)number
{
	[self.internalExpression addObject:[NSNumber numberWithDouble:number]];
	operand = number;
	NSLog(@"%d", [self.internalExpression count]);
}

- (id)expression
{
	return [NSArray arrayWithArray:self.internalExpression];
}

+ (NSString *)descriptionOfExpression:(id)anExpression
{
	NSMutableString *returnValue = [[NSMutableString alloc] init];
	for (id piece in anExpression) {
		if([piece isKindOfClass:[NSString class]])
			if([piece hasPrefix:VARIABLE_PREFIX])
				[returnValue appendString:[piece substringFromIndex:1]];
			else
				[returnValue appendString:piece];
		if([piece isKindOfClass:[NSNumber class]])
			[returnValue appendString:[piece stringValue]]; 
		[returnValue appendString:@" "];
	}
	[returnValue autorelease];
	return returnValue;
}

+ (NSSet *)variablesInExpression:(id)anExpression
{
	NSMutableSet *returnValue = [[NSMutableSet alloc] init];
	for (id piece in anExpression) {
		if([piece isKindOfClass:[NSString class]] && [piece hasPrefix:VARIABLE_PREFIX])
			[returnValue addObject:[piece substringFromIndex:1]];
	}
	[returnValue autorelease];
	if ([returnValue count]==0) {
		return nil;
	}
	return returnValue;
}

+ (id)propertyListForExpression:(id)anExpression
{
	return [NSMutableArray arrayWithArray:anExpression];
}

+ (id)expressionForPropertyList:(id)propertyList
{
	return [NSMutableArray arrayWithArray:propertyList];
}

+ (double)evaluateExpression:(id)anExpression
		 usingVariableValues:(NSDictionary *)variables
{
	//init a brain
	CalculatorBrain *brain = [[CalculatorBrain alloc] init];
	//execute each step 
	for (id piece in anExpression) {
		if([piece isKindOfClass:[NSString class]])
			// look up variable value if needed
			if([piece hasPrefix:VARIABLE_PREFIX]){
				brain.operand = [[variables objectForKey:[piece substringFromIndex:1]] doubleValue];
			} else
				[brain performOperation:piece];
		else if([piece isKindOfClass:[NSNumber class]])
			brain.operand = [piece doubleValue];
	}
	[brain autorelease];
	return brain.operand;
}

- (void)setVariableAsOperand:(NSString *)variableName
{
	NSString *vp = VARIABLE_PREFIX;
	[self.internalExpression addObject:[vp stringByAppendingString:variableName] ];
	NSLog(@"%d", [self.internalExpression count]);
}

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
	[self.internalExpression addObject:operation];
	
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
		[internalExpression release];
		internalExpression = [[NSMutableArray alloc] initWithCapacity:5];
	}	else {
		[self performWaitingOperation];
		self.waitingOperation = operation;
		waitingOperand = operand;
	}

	return operand;
}

- (void) dealloc
{
	[self.internalExpression release];
	[super dealloc];
}
@end
