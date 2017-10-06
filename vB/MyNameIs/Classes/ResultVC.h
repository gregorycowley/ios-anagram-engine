//
//  ResultVC.h
//  MyNameIs
//
//  Created by Production One on 9/24/12.
//  Copyright (c) 2012 Gregory Cowley Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultVC : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *mLabelField;
@property (weak,nonatomic) NSString *mSelectedAnagram;

- (IBAction)againButtonAction:(id)sender;

@end
