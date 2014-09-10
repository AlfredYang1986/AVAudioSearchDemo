//
//  BFRecordsTableViewController.m
//  Demo
//
//  Created by Alfred Yang on 3/09/2014.
//  Copyright (c) 2014 ByteFusion. All rights reserved.
//

#import "BFRecordsTableViewController.h"
#import "BFRecordDetailViewController.h"

@interface BFRecordsTableViewController ()

@end

@implementation BFRecordsTableViewController {
    UIBarButtonItem * editButton;
    UIBarButtonItem * doneButton;
}

@synthesize pathHelper = _pathHelper;
@synthesize recodsView = _recodsView;

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
    editButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonDidClick:)];
    doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(editButtonDidClick:)];
    
    self.navigationItem.rightBarButtonItem = editButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"record_detail"]) {
        ((BFRecordDetailViewController*)segue.destinationViewController).pathHelper = self.pathHelper;
        self.pathHelper.current = ((NSIndexPath*)sender).row;
    }
}

-(void)editButtonDidClick:(id)sender
{
    NSLog(@"edit button did click");
    if (self.recodsView.editing) {
        [self.recodsView setEditing:false animated:true];
        self.navigationItem.rightBarButtonItem = editButton;
    } else {
        [self.recodsView setEditing:true animated:true];
        self.navigationItem.rightBarButtonItem = doneButton;
    }
}

#pragma mark -- datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"default"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"default"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSArray* cellName = [self.pathHelper getEnumableRecordingPath];
    
    cell.textLabel.text = [cellName objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //    NSString *path = [[NSBundle mainBundle] pathForResource:[item objectForKey:@"imageKey"] ofType:@"png"];
    //    UIImage *theImage = [UIImage imageWithContentsOfFile:path];
    //    cell.imageView.image = theImage;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.pathHelper getTotalRecordNumber];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

#pragma mark -- delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"record_detail" sender:indexPath];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.pathHelper deleteFileWithIndex:indexPath.row];
        [self editButtonDidClick:nil];
        [self.pathHelper resetPathHelper];
        NSArray * array = [NSArray arrayWithObjects:indexPath, nil];
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:array withRowAnimation: UITableViewRowAnimationFade];
        [tableView endUpdates];
    }
}

@end
