//
//  AccountViewController.h
//  food－square
//
//  Created by Apple on 13-9-29.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property(nonatomic, strong) NSString *myUsername;
@property(nonatomic, strong) NSString *myPassword;

@property(nonatomic, strong) IBOutlet UILabel *uiError;

@property(nonatomic, strong) NSMutableArray *userInf;
@property(nonatomic, strong) IBOutlet UITextField *uiUsername;
@property(nonatomic, strong) IBOutlet UITextField *uiPassword;


@end
