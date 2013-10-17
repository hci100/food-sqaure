//
//  SettingViewController.h
//  food－square
//
//  Created by Apple on 13-9-28.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UITableViewController
<UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) NSArray *rowArray;

@property (strong, nonatomic) IBOutlet UIPickerView *pickerNotification;

@end
