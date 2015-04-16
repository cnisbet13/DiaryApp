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

@interface EntryViewController ()

@property (strong, nonatomic) IBOutlet UITextField *textField;

@end

@implementation EntryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.entry != nil) {
        self.textField.text = self.entry.body;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dismissSelf {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)insertDiaryEntry {
    CNCoreDataStack *coreDataStack = [CNCoreDataStack defaultStack];
    DiaryEntry *entry = [NSEntityDescription insertNewObjectForEntityForName:@"DiaryEntry" inManagedObjectContext:coreDataStack.managedObjectContext];
    entry.body = self.textField.text;
    entry.date = [[NSDate date] timeIntervalSince1970];
    [coreDataStack saveContext];
}

- (void)updateDiaryEntry {
    self.entry.body = self.textField.text;
    
    CNCoreDataStack *coreDataStack = [CNCoreDataStack defaultStack];
    [coreDataStack saveContext];
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

@end
