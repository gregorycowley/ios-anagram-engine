//
//  NameSelectionVC.h
//  MyNameIs
//
//  Created by Production One on 9/24/12.
//  Copyright (c) 2012 Gregory Cowley Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultVC.h"

@interface NameSelectionVC : UIViewController <UITableViewDelegate>{
	
}
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (strong, nonatomic) NSArray	*mAnagramArray;
@property (strong, nonatomic) NSString	*mSelectedAnagram;

@property (weak, nonatomic) IBOutlet UITableViewCell *selectedName;

- (IBAction)backButton:(id)sender;

@end
