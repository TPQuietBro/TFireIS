//
//  TPCaculateObj.h
//  FireIFELSEDemo
//
//  Created by 唐鹏 on 2018/5/21.
//  Copyright © 2018年 唐鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,FireIFELSE){
    FireIFELSE11,
    FireIFELSE22,
    FireIFELSE33
};
@interface TPCaculateObj : NSObject
+ (void)caculateWithType:(FireIFELSE)type;
@end
