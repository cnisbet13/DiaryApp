//
//  NewDiaryEntryViewController.m
//  CWNDiary
//
//  Created by Calvin Nisbet on 2015-03-26.
//  Copyright (c) 2015 Calvin Nisbet. All rights reserved.
//

#import "EntryViewController.h"
#import "CNCoreDataStack.h"
#import "DiaryEntry.h"
#import <CoreLocation/CoreLocation.h>

@interface EntryViewController () <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate>


@property (nonatomic, strong) NSString *location;

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) UIImage *pickedImage;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic, assign) enum DiaryEntryMood pickedMood;

@property (weak, nonatomic) IBOutlet UIButton *badButton;

@property (weak, nonatomic) IBOutlet UIButton *averageButton;

@property (weak, nonatomic) IBOutlet UIButton *goodButton;

@property (strong, nonatomic) IBOutlet UIView *accessoryView;


@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UIButton *imageButton;

@end

@implementation EntryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSDate *date;
    
    if (self.entry != nil) {
        self.textView.text = self.entry.body;
        self.pickedMood = self.entry.mood;
        date = [NSDate dateWithTimeIntervalSince1970:self.entry.date];
    } else {
        self.pickedMood = DiaryEntryMoodGood;
        date = [NSDate date];
        [self loadLocation];
    }
    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"EEEE MMMM d, yyyy"];
    self.dateLabel.text = [dateFormater stringFromDate:date];
    self.textView.inputAccessoryView = self.accessoryView;
    self.imageButton.layer.cornerRadius = CGRectGetWidth(self.imageButton.frame)/2.0f;
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dismissSelf {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadLocation{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = 1000;
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    [self.locationManager startUpdatingLocation];

}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self.locationManager stopUpdatingLocation];
    CLLocation *location = [locations firstObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks firstObject];
        self.location = placemark.name;
    }];
    NSLog(@"%@", [locations lastObject]);
}

- (void)insertDiaryEntry {
    CNCoreDataStack *coreDataStack = [CNCoreDataStack defaultStack];
    DiaryEntry *entry = [NSEntityDescription insertNewObjectForEntityForName:@"DiaryEntry" inManagedObjectContext:coreDataStack.managedObjectContext];
    entry.body = self.textView.text;
    entry.date = [[NSDate date] timeIntervalSince1970];
    entry.imageData = UIImageJPEGRepresentation(self.pickedImage, 0.75);
    entry.location = self.location;
    entry.mood = self.pickedMood;
    [coreDataStack saveContext];
}


- (void)promptForSource {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Image Source" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo Roll", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        if (buttonIndex != actionSheet.firstOtherButtonIndex) {
            [self promptForCamera];
        } else {
            [self promptForPhotoRoll];
        }
    }
}

- (void)promptForCamera {
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)promptForPhotoRoll {
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}


- (void)updateDiaryEntry {
    self.entry.body = self.textView.text;
    
    CNCoreDataStack *coreDataStack = [CNCoreDataStack defaultStack];
    self.entry.imageData = UIImageJPEGRepresentation(self.pickedImage, 0.75);
    self.entry.mood = self.pickedMood;
    [coreDataStack saveContext];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info  {
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.pickedImage = image;
     [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)setPickedMood:(enum DiaryEntryMood)pickedMood{
    _pickedMood = pickedMood;
    self.badButton.alpha = 0.5f;
    self.averageButton.alpha = 0.5f;
    self.goodButton.alpha = 0.5f;

    switch (pickedMood) {
        case DiaryEntryMoodGood:
            self.goodButton.alpha = 1.0f;
            break;
            
        case DiaryEntryMoodAverage:
            self.averageButton.alpha = 1.0f;
            
        case DiaryEntryMoodBad:
            self.badButton.alpha = 1.0f;
            break;
    }

}

- (void)setPickedImage:(UIImage *)pickedImage
{
    _pickedImage = pickedImage;
    
    if (pickedImage == nil) {
        [self.imageButton setImage:[UIImage imageNamed:@"icn_noimage"] forState:UIControlStateNormal];

    } else {
        [self.imageButton setImage:pickedImage forState:UIControlStateNormal];
    }
    
}


- (IBAction)doneWasPressed:(id)sender {
    if (self.entry != nil) {
        [self updateDiaryEntry];
    } else {
        [self insertDiaryEntry];
    }
    [self dismissSelf];
}

- (IBAction)cancelWasPressed:(id)sender {
    [self dismissSelf];
}


- (IBAction)badWasPressed:(id)sender
{
    self.pickedMood = DiaryEntryMoodBad;
}

- (IBAction)averageWasPressed:(id)sender
{
self.pickedMood = DiaryEntryMoodAverage;
}

- (IBAction)goodWasPressed:(id)sender
{
self.pickedMood = DiaryEntryMoodGood;
}

- (IBAction)imageButtonWasPressed:(id)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self promptForSource];
    } else {
        [self promptForPhotoRoll];
    }
}

@end
