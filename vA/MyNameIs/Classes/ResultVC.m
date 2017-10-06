//
//  ResultVC.m
//  MyNameIs
//
//  Created by Production One on 9/24/12.
//  Copyright (c) 2012 Gregory Cowley Studios. All rights reserved.
//

#import "ResultVC.h"

@interface ResultVC ()

@end

@implementation ResultVC

@synthesize mSelectedAnagram;
@synthesize mLabelField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[mLabelField setFont: [UIFont fontWithName: @"Agilo Handwriting" size:90]];
	mLabelField.text = mSelectedAnagram;
	
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
	[self setMLabelField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (IBAction)againButtonAction:(id)sender {
	[self.navigationController popToRootViewControllerAnimated:YES];
	
}
@end
