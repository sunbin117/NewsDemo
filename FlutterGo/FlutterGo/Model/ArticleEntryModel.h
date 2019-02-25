//
//  ArticleEntryModel.h
//  FlutterGo
//
//  Created by Bin Sun 孙斌 on 2019/2/21.
//  Copyright © 2019 NIO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticleUserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ArticleEntryModel : NSObject

@property (nonatomic, strong) NSString *originalUrl;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) ArticleUserModel *user;

@end

NS_ASSUME_NONNULL_END
