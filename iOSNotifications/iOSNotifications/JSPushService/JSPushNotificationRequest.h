//
//  JSPushNotificationRequest.h
//  iOSNotifications
//
//  Created by WengHengcong on 2016/11/17.
//  Copyright © 2016年 WengHengcong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSPushNotificationContent.h"
#import "JSPushNotificationTrigger.h"

NS_ASSUME_NONNULL_BEGIN
/*
 * 注册或更新通知实体类
 */
@interface JSPushNotificationRequest : NSObject<NSCopying, NSCoding>

/**
 通知请求标识
 用于查找、删除、更新通知
 */
@property (nonatomic, copy) NSString    *requestIdentifier;

/**
 设置通知的具体内容
 */
@property (nonatomic, copy) JSPushNotificationContent *content;

/**
 设置通知的触发方式
 trigger为nil，则为立即触发
 */
@property (nonatomic, copy ,nullable) JSPushNotificationTrigger *trigger;

/**
 注册或更新通知成功回调，iOS10以上成功则result为UNNotificationRequest对象，失败则result为nil;iOS10以下成功result为UILocalNotification对象，失败则result为nil
 */
@property (nonatomic, copy) void (^completionHandler)(id __nullable result);

+ (instancetype)requestWithIdentifier:(NSString *)identifier content:(JSPushNotificationContent *)content trigger:(nullable JSPushNotificationTrigger *)trigger withCompletionHandler:(void(^)(id __nullable result))completionHandler;
@end

NS_ASSUME_NONNULL_END
