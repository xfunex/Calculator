//
//  CalculatorViewController.h
//  Calculator
//
//  Created by james sa on 2010/11/21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorBrain.h"

@interface CalculatorViewController : UIViewController {
	IBOutlet UILabel *display;
	CalculatorBrain *brain;
	BOOL userIsInTheMiddleOfTypingANumber;
}

-(IBAction)digitPressed:(UIButton *)sender;
-(IBAction)operationPressed:(UIButton *)sender;

@end

