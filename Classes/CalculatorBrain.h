//
//  CalculatorBrain.h
//  Calculator
//
//  Created by james sa on 2010/11/21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject {
@private
	double waitingOperand;
	double memory;
	NSMutableArray *internalExpression;
}

- (void)setVariableAsOperand:(NSString *)variableName;
- (double)performOperation:(NSString *)operation;

@property double operand;
@property (retain) NSString *waitingOperation;
@property (readonly) id expression;

+ (double)evaluateExpression:(id)anExpression
		 usingVariableValues:(NSDictionary *)variables;

+ (NSSet *)variablesInExpression:(id)anExpression;
+ (NSString *)descriptionOfExpression:(id)anExpression;

+ (id)propertyListForExpression:(id)anExpression;
+ (id)expressionForPropertyList:(id)propertyList;

@end
