//
//  TQWInbriefTableViewCell.h
//  TMTime
//
//  Created by 涂清文 on 16/4/4.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TQWInbriefTableViewCell : UITableViewCell
/** 电影消息的相关属性 **/

@property (weak, nonatomic) IBOutlet UIImageView *inbriefImageView;
@property (weak, nonatomic) IBOutlet UILabel *inbriefContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *inbriefTitleLabel;
@end

@interface TQWAtlas : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *altasTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *altasLeftImageView;

@property (weak, nonatomic) IBOutlet UIImageView *altasRightImageView;
@property (weak, nonatomic) IBOutlet UIImageView *altasCenterImageView;

@end

@interface TQWNewMovieTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *moviePosterImageView;
@property (weak, nonatomic) IBOutlet UIImageView *moviePosterLogoImageView;
@property (weak, nonatomic) IBOutlet UILabel *movieDescriptionLable;
@property (weak, nonatomic) IBOutlet UILabel *movieDescriptionTitleLabel;

@end
