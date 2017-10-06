//
//  InputVC.h
//  MyNameIs
//
//  Created by Production One on 9/24/12.
//  Copyright (c) 2012 Gregory Cowley Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ASIHTTPRequest.h"
//#import "ASIFormDataRequest.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "NameSelectionVC.h"

#import "SHKActivityIndicator.h"

@interface InputVC : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField	*mNameField;
@property (weak,nonatomic) NSArray					*mAnagramArray;

- (IBAction)generateNewName:(id)sender;

@end
