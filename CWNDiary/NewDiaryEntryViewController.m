//
//  NewDiaryEntryViewController.m
//  CWNDiary
//
//  Created by Calvin Nisbet on 2015-03-26.
//  Copyright (c) 2015 Calvin Nisbet. All rights reserved.
//

#import "NewDiaryEntryViewController.h"
#import "CNCoreDataStack.h"
#import "DiaryEntry.h"

@interface NewDiaryEntryViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation NewDiaryEntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertDiaryEntry
{
    

    CNCoreDataStack *CoreDataStack = [CNCoreDataStack defaultStack];

    
    DiaryEntry *entry = [NSEntityDescription insertNewObjectForEntityForName:@"DiaryEntry" inManagedObjectContext:CoreDataStack.managedObjectContext];
    entry.body = self.textField.text;
    entry.date = [[NSDate date] timeIntervalSince1970];
    [CoreDataStack saveContext];
    
}

-(void)dismissSelf
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)donePressed:(id)sender {
    [self insertDiaryEntry];
    [self dismissSelf];
}

- (IBAction)cancelPressed:(id)sender {
    [self dismissSelf];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
