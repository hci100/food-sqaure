//
//  RMAddReminderViewControoller.m
//  food－square
//
//  Created by Apple on 13-9-29.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "RMAddReminderViewController.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>
#import "RMReminderManager.h"


#define kDefaultCalendarKey @"RMAddReminderViewController.DefaultCalendar"

@interface RMAddReminderViewController () <UITextFieldDelegate, EKCalendarChooserDelegate>{
    BOOL *isFullScreen;
}
@property (weak,nonatomic)IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UITextField *reminderTitleField;
@property (weak, nonatomic) IBOutlet UITableViewCell *reminderListCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *reminderArrivalCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *reminderDepartureCell;

@property (strong, nonatomic) EKCalendar *calendar;

@end

@implementation RMAddReminderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *calendarIdentifier = [[NSUserDefaults standardUserDefaults] objectForKey:kDefaultCalendarKey];
    if (calendarIdentifier)
    {
        self.calendar = [[RMReminderManager defaultManager] calendarWithIdentifier:calendarIdentifier];
    }
    if (!self.calendar)
    {
        self.calendar = [RMReminderManager defaultManager].defaultReminderCalendar;
    }
    if ((self.reminderAnnotation.proximity != EKAlarmProximityEnter) &&
        (self.reminderAnnotation.proximity != EKAlarmProximityLeave))
    {
        self.reminderAnnotation.proximity = EKAlarmProximityEnter;
    }
    TQStarRatingView *starRatingView = [[TQStarRatingView alloc] initWithFrame:CGRectMake(35, 390, 250, 50) numberOfStar:5];
    starRatingView.delegate = self;
    [self.view addSubview:starRatingView];
}


-(void)starRatingView:(TQStarRatingView *)view score:(float)score
{
    NSLog(@"%@",self.reminderTitleField.text);
    self.scoreLabel.text = [NSString stringWithFormat:@"%0.2f",score * 10 ];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.reminderListCell.textLabel.text = self.calendar.title;
    self.reminderListCell.detailTextLabel.text = self.calendar.source.title;
    [self updateProximity];
}

-(void)updateProximity
{
    if (self.reminderAnnotation.proximity == EKAlarmProximityEnter)
    {
        self.reminderArrivalCell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.reminderDepartureCell.accessoryType = UITableViewCellAccessoryNone;
    }
    else
    {
        self.reminderArrivalCell.accessoryType = UITableViewCellAccessoryNone;
        self.reminderDepartureCell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

#pragma mark - Table view delegate

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return (section == 2) ? self.reminderAnnotation.subtitle : nil;
    NSLog(@"%@",self.reminderTitleField.text);
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        [self.reminderTitleField becomeFirstResponder];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSLog(@"%@",self.reminderTitleField.text);
    }
//    else if (indexPath.section ==2)
//    {
//        EKCalendarChooser *vc = [[EKCalendarChooser alloc] initWithSelectionStyle:EKCalendarChooserSelectionStyleSingle
//                                                                     displayStyle:EKCalendarChooserDisplayWritableCalendarsOnly
//                                                                       entityType:EKEntityTypeReminder
//                                                                       eventStore:[RMReminderManager defaultManager].store];
//        vc.delegate = self;
//        vc.selectedCalendars = [NSSet setWithObject:self.calendar];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    else if (indexPath.section == 1)
    {
        self.reminderAnnotation.proximity = (indexPath.row == 0) ? EKAlarmProximityEnter : EKAlarmProximityLeave;
        [self updateProximity];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

#pragma mark - Calendar chooser delegate

-(void)calendarChooserSelectionDidChange:(EKCalendarChooser *)calendarChooser
{
    self.calendar = [calendarChooser.selectedCalendars anyObject];
    [self.navigationController popViewControllerAnimated:YES];
    [[NSUserDefaults standardUserDefaults] setObject:self.calendar.calendarIdentifier forKey:kDefaultCalendarKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark - Text field delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - Segues

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"saveReminder"])
    {
        NSLog(@"%@",self.reminderTitleField.text);
        NSString *subtitleDetail=[@"  score: " stringByAppendingString:self.scoreLabel.text];
        self.reminderAnnotation.title = self.reminderTitleField.text.length ? [self.reminderTitleField.text stringByAppendingString: subtitleDetail] :NSLocalizedString(@"Reminder", @"New reminder default title");
    }
}

- (IBAction)choosePhoto:(id)sender {
    
    UIActionSheet *sheet;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"choose" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"cancel" otherButtonTitles:@"camera",@"choode from photo library", nil];
    }
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"choose" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"cancel" otherButtonTitles:@"choose from photo library", nil];
    }
    
    sheet.tag = 255;
    
    [sheet showInView:self.view];
}

#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self saveImage:image withName:@"currentImage.png"];
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    isFullScreen = NO;
    [self.photoImageView setImage:savedImage];
    
    self.photoImageView.tag = 100;
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissViewControllerAnimated:YES completion:^{}];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    isFullScreen = !isFullScreen;
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:self.view];
    
    CGPoint imagePoint = self.photoImageView.frame.origin;
    //touchPoint.x ，touchPoint.y 就是触点的坐标
    
    // 触点在imageView内，点击imageView时 放大,再次点击时缩小
    if(imagePoint.x <= touchPoint.x && imagePoint.x +self.photoImageView.frame.size.width >=touchPoint.x && imagePoint.y <=  touchPoint.y && imagePoint.y+self.photoImageView.frame.size.height >= touchPoint.y)
    {
        // 设置图片放大动画
        [UIView beginAnimations:nil context:nil];
        // 动画时间
        [UIView setAnimationDuration:1];
        
        if (isFullScreen) {
            // 放大尺寸
            
            self.photoImageView.frame = CGRectMake(0, 0, 320, 480);
        }
        else {
            // 缩小尺寸
            self.photoImageView.frame = CGRectMake(50, 65, 90, 115);
        }
        
        // commit动画
        [UIView commitAnimations];
        
    }
    
}

#pragma mark - actionsheet delegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
        
    }
}


@end
