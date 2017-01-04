//
//  NotificationService.m
//  NotificationService
//
//  Created by WengHengcong on 2017/1/4.
//  Copyright © 2017年 WengHengcong. All rights reserved.
//

#import "NotificationService.h"



@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    // Modify the notification content here...
    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
    
    //在此处修改category，可达到对应category的手段！！！
    //可以配合服务端针对category来进行不同的自定义页面的设置。
    NSString *categoryFormServer = [self.bestAttemptContent.userInfo objectForKey:@"js_category"];
    self.bestAttemptContent.categoryIdentifier = categoryFormServer;
    
    //自定义一个字段image，用于下载地址：
    //同时，需要注意的是，在下载图片是采用http时，需要在extension info.plist加上 app transport
    self.contentHandler(self.bestAttemptContent);
}


/*
 在一定时间内没有调用 contentHandler 的话，系统会调用这个方法，来告诉你大限已到。你可以选择什么都不做，这样的话系统将当作什么都没发生，简单地显示原来的通知。可能你其实已经设置好了绝大部分内容，只是有很少一部分没有完成，这时你也可以像例子中这样调用 contentHandler 来显示一个变更“中途”的通知
 */
- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end