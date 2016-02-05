//
//  MyUIViewController.h
//  ToDoManager
//
//  Created by Taro Minowa on 2/3/16.
//  Copyright © 2016 Higepon Taro Minowa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPHandlesMoc.h"
#import "DPHandlesToDoEntity.h"

@interface MyUIViewController : UIViewController <DPHandlesMoc, DPHandlesToDoEntity>

-(void)receiveMOC:(NSManagedObjectContext *)incomingMOC;
-(void)reciveToDoEntity:(ToDoEntity *)incomingEntity;

@end
