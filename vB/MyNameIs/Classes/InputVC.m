//
//  InputVC.m
//  MyNameIs
//
//  Created by Production One on 9/24/12.
//  Copyright (c) 2012 Gregory Cowley Studios. All rights reserved.
//

#import "InputVC.h"


@interface InputVC ()

@end

@implementation InputVC

@synthesize mNameField;
@synthesize mAnagramArray;

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
	
	[mNameField setFont: [UIFont fontWithName: @"Gotham-Medium" size:36]];
	mNameField.delegate = self;
	//[mNameField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
	// mNameField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
	//[mNameField autocapitalizationType:]
	//[UIFont *myFont = UIFont fontWithName:@"Agilo Handwriting" size:18];
	
	// Do any additional setup after loading the view.

}

- (void)viewDidAppear:(BOOL)animated{
	NSLog(@"viewDidAppear");
	mNameField.text = @"";
}

- (void)viewDidUnload
{
	[self setMNameField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (void) textFieldDidChange:(NSNotification *)notification {
    // mNameField.text = [mNameField.text uppercaseString];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
	
    // Check if the added string contains lowercase characters.
    // If so, those characters are replaced by uppercase characters.
    // But this has the effect of losing the editing point
    // (only when trying to edit with lowercase characters),
    // because the text of the UITextField is modified.
    // That is why we only replace the text when this is really needed.
    NSRange lowercaseCharRange;
    lowercaseCharRange = [string rangeOfCharacterFromSet:[NSCharacterSet lowercaseLetterCharacterSet]];
	
    if (lowercaseCharRange.location != NSNotFound) {
		
        textField.text = [textField.text stringByReplacingCharactersInRange:range
                                                                 withString:[string uppercaseString]];
        return NO;
    }
	
    return YES;
}

#pragma mark - Public Methods

- (void) loadAnagrams:(NSString *)url originalName:(NSString*)originalName{
	[[SHKActivityIndicator currentIndicator] displayActivity:@"Generating your new name..."];
	[[SHKActivityIndicator currentIndicator] setProperRotation:NO];
	
	
	NSURL *url2 = [[NSURL alloc] initWithString:url];
	//NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url2];
	AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url2];
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
							originalName, @"anagram",
							nil];

	NSURLRequest *request = [httpClient requestWithMethod:@"GET" path:@"anagram/anagram.cgi" parameters:params];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		[[SHKActivityIndicator currentIndicator] hide];
		self.mAnagramArray = [self processResult:operation.responseString];
		[self performSegueWithIdentifier:@"showAnagramTable" sender:self];
		
    }
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         NSLog(@"Error during connection: %@",error.description);
                                        //[[NSNotificationCenter defaultCenter] postNotificationName:@"errorConnecting" object:nil];
                                     }];
	[operation start];
}

- (NSArray *)processResult:(NSString *)responseString{
	NSArray *anagramArray;
	NSArray *elements = [responseString componentsSeparatedByString: @"found. Displaying all:"];
	if ([elements count] > 1 ){
		NSString *refined1 = [elements objectAtIndex:1];
		NSArray *elements2 = [refined1 componentsSeparatedByString: @"<bottomlinks>"];
		NSString *anagrams = [elements2 objectAtIndex:0];
		NSString *anagramsClean = [anagrams stringByReplacingOccurrencesOfString:@"</b>"															  withString:@""];
		anagramArray = [anagramsClean componentsSeparatedByString:@"<br>"];
		
	} else {
		anagramArray = [[NSArray alloc] initWithObjects:@"No anagrams available for this name", nil];
		
	}
	
	return anagramArray;
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"Preparing for segue...");
	//if ( [segue.identifier isEqualToString:@"ShowPhoto"]) {}
	NameSelectionVC *nameVC = [segue destinationViewController];
	nameVC.mAnagramArray = self.mAnagramArray;
    //ivc.currentPhoto = currentPhoto;
}


- (IBAction)generateNewName:(id)sender {
	NSString *originalName = mNameField.text;
	[mNameField resignFirstResponder];
	
	[self loadAnagrams:@"http://wordsmith.org" originalName:originalName];
}
@end
