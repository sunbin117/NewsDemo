//
//  ArticleDModel.m
//  FlutterGo
//
//  Created by Bin Sun 孙斌 on 2019/2/21.
//  Copyright © 2019 NIO. All rights reserved.
//

#import "ArticleDModel.h"
#import "ArticleEntryModel.h"

@implementation ArticleDModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"entrylist" : [ArticleEntryModel class]};
}

@end
