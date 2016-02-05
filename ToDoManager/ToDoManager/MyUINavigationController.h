//
//  MyUINavigationController.h
//  ToDoManager
//
//  Created by Taro Minowa on 2/3/16.
//  Copyright © 2016 Higepon Taro Minowa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPHandlesMoc.h"

@interface MyUINavigationController : UINavigationController <DPHandlesMoc>

-(void)receiveMOC:(id)incomingMOC;

@end
