//
//  AccountViewController.m
//  food－square
//
//  Created by Apple on 13-9-29.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "AccountViewController.h"
#import "SWRevealViewController.h"
#import "Global.h"
#import "MapViewController.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

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
	// Do any additional setup after loading the view.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    self.uiError.text=@"";
    NSString *plistCatPath=[[NSBundle mainBundle] pathForResource:@"Users" ofType:@"plist"];
    self.userInf=[NSMutableArray arrayWithContentsOfFile:plistCatPath];
    
    [self setUpForDismissKeyboard];
}

- (IBAction)loginButtonTapped:(id)sender {
    self.myUsername=self.uiUsername.text;
    self.myPassword=self.uiPassword.text;
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"username == %@", self.myUsername];
    NSArray *filteredArray=[self.userInf filteredArrayUsingPredicate:predicate];
    int array_tot=[filteredArray count];
    if (array_tot==0)
        self.uiError.text=@"Username not found!";
    else if (![self.myPassword isEqualToString:filteredArray[0][@"password"]])
        self.uiError.text=@"Password error!";
    else {
        self.uiError.text=@"Login successful!";
        legalUsername=self.myUsername;
        //[self performSegueWithIdentifier:@"loginSuccess" sender:self];
        MapViewController *mapViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"mapViewController"];
        
        [[self navigationController] pushViewController:mapViewController animated:YES];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpForDismissKeyboard {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view removeGestureRecognizer:singleTapGR];
                }];
}
- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [self.view endEditing:YES];
}


@end
