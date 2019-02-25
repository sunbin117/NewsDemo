//
//  ArticleCell.h
//  FlutterGo
//
//  Created by Bin Sun 孙斌 on 2019/2/21.
//  Copyright © 2019 NIO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArticleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userHeader;

@end

NS_ASSUME_NONNULL_END
