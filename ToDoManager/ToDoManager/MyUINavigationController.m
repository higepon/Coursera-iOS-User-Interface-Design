//
//  MyUINavigationController.m
//  ToDoManager
//
//  Created by Taro Minowa on 2/3/16.
//  Copyright © 2016 Higepon Taro Minowa. All rights reserved.
//

#import "MyUINavigationController.h"

@interface MyUINavigationController ()

@property(nonatomic) NSManagedObjectContext *managedObjectContext;

@end

@implementation MyUINavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)receiveMOC:(id)incomingMOC
{
    self.managedObjectContext = incomingMOC;
    id<DPHandlesMoc> child = (id<DPHandlesMoc>)self.viewControllers[0];
    [child receiveMOC:self.managedObjectContext];
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
