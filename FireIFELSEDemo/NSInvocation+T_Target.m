//
//  NSInvocation+T_Target.m
//  FireIFELSEDemo
//
//  Created by 唐鹏 on 2018/5/21.
//  Copyright © 2018年 唐鹏. All rights reserved.
//

#import "NSInvocation+T_Target.h"
#import <objc/message.h>
@implementation NSInvocation (T_Target)
- (void)setT_target:(NSObject *)t_target{
    objc_setAssociatedObject(self, @"t_target", t_target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSObject *)t_target{
    return objc_getAssociatedObject(self, @"t_target");
}
@end
