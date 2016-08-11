//
//  CDVSobot.h
//  创业服务
//
//  Created by Dream on 16/4/22.
//
//

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import <Cordova/CDV.h>
#import <SobotKit/SobotKit.h>

@interface CDVSobot : CDVPlugin<ZCReceivedMessageDelegate>

@property(nonatomic, strong)UIViewController *rootVC;
@property(nonatomic, strong)ZCKitInfo *uiInfo;
@property(nonatomic, copy)NSString *currentId;

- (void)init:(CDVInvokedUrlCommand *)command;

- (void)open:(CDVInvokedUrlCommand *)command;

- (void)ui:(CDVInvokedUrlCommand *)command;

@end
