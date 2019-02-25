//
//  ArticleModel.h
//  FlutterGo
//
//  Created by Bin Sun 孙斌 on 2019/2/21.
//  Copyright © 2019 NIO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticleDModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ArticleModel : NSObject

@property (nonatomic, strong) NSString *s;
@property (nonatomic, strong) NSString *m;
@property (nonatomic, strong) ArticleDModel *d;

@end

NS_ASSUME_NONNULL_END
