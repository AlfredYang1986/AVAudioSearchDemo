//
//  BFSearchResultViewController.m
//  Demo
//
//  Created by Alfred Yang on 6/09/2014.
//  Copyright (c) 2014 ByteFusion. All rights reserved.
//

#import "BFSearchResultViewController.h"

@interface BFSearchResultViewController ()

@end

@implementation BFSearchResultViewController

@synthesize resultData = _resultData;

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

#pragma mark -- datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"default"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"default"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = [[self.resultData objectAtIndex:indexPath.row] objectForKey:@"Title"];
    cell.detailTextLabel.text = [[self.resultData objectAtIndex:indexPath.row] objectForKey:@"Brand"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //    NSString *path = [[NSBundle mainBundle] pathForResource:[item objectForKey:@"imageKey"] ofType:@"png"];
    //    UIImage *theImage = [UIImage imageWithContentsOfFile:path];
    //    cell.imageView.image = theImage;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.resultData count];
}

#pragma mark -- delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"ResultDetail" sender:indexPath];
}

@end
