DROP TABLE IF EXISTS bet_option;
DROP TABLE IF EXISTS bet_option_value;
DROP TABLE IF EXISTS lottery;
DROP TABLE IF EXISTS lottery_category;
DROP TABLE IF EXISTS lottery_play_method;
DROP TABLE IF EXISTS lottery_play_method_category;
DROP TABLE IF EXISTS play_method;
DROP TABLE IF EXISTS play_method_category;
DROP TABLE IF EXISTS sale_field;
DROP TABLE IF EXISTS sale_field_play_method;
CREATE TABLE bet_option
(
  id               bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  play_method_id   bigint(20) comment '玩法id',
  alias            varchar(32) comment '别名',
  name             varchar(32) comment '投注项名',
  status           varchar(16) comment '状态：启用 Enable,停用 Disable',
  odds             varchar(10) comment '赔率',
  combination_up   int(10) comment '排列组合上标',
  combination_down int(10) comment '排列组合下标',
  sort             int(10)    NOT NULL comment '排序',
  bet_option_type  varchar(32) comment '投注项类型',
  create_time      datetime   NULL comment '创建时间',
  modify_time      datetime   NULL comment '修改时间',
  PRIMARY KEY (id),
  INDEX (play_method_id)
) comment ='投注项' ENGINE = InnoDB;
CREATE TABLE bet_option_value
(
  id               bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  bet_option_id    bigint(20) comment '投注项id',
  bet_option_value varchar(64) comment '投注项值',
  status           varchar(16) comment '状态： 启用 Enable,停用 Disable',
  sort             int(10) comment '排序',
  PRIMARY KEY (id),
  INDEX (bet_option_id)
) comment ='投注项值' ENGINE = InnoDB;
CREATE TABLE lottery
(
  id          bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  category_id bigint(20) comment '分类id',
  name        varchar(32) comment '彩种名',
  status      varchar(16) comment '状态：启用 Enable ，停用 Disable',
  num         int(10) comment '开奖号位数',
  sort        int(10) comment '排序',
  create_time datetime   NULL comment '创建时间',
  modify_time datetime   NULL comment '修改时间',
  PRIMARY KEY (id),
  INDEX (category_id)
) comment ='彩种' ENGINE = InnoDB;
CREATE TABLE lottery_category
(
  id          bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  name        varchar(32) comment '分类名',
  status      varchar(16) comment '状态：启用Enable,停用 Disable',
  sort        int(10) comment '排序',
  create_time datetime   NULL comment '创建时间',
  modify_time datetime   NULL comment '修改时间',
  summary     varchar(128) comment '说明',
  PRIMARY KEY (id)
) comment ='彩种分类' ENGINE = InnoDB;
CREATE TABLE lottery_play_method
(
  id                      bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  lottery_id              bigint(20) comment '彩种id',
  play_method_id          bigint(20) comment '玩法id',
  play_method_category_id bigint(20) comment '玩法分类id',
  status                  varchar(255) comment '状态：启用 Enable ,停用 Disable',
  sort                    int(10) comment '排序',
  PRIMARY KEY (id),
  INDEX (lottery_id),
  INDEX (play_method_id),
  INDEX (play_method_category_id)
) ENGINE = InnoDB;
CREATE TABLE lottery_play_method_category
(
  id                      bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  lottery_id              bigint(20) comment '彩种id',
  play_method_category_id bigint(20) comment '玩法分类id',
  status                  varchar(255) comment '状态：启用 Enable ,停用 Disable',
  sort                    int(10) comment '排序',
  PRIMARY KEY (id),
  INDEX (lottery_id),
  INDEX (play_method_category_id)
) comment ='彩种的玩法' ENGINE = InnoDB;
CREATE TABLE play_method
(
  id                      bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  pre_id                  bigint(20) comment '上级id',
  lottery_id              bigint(20) comment '彩票id',
  play_method_category_id bigint(20) comment '玩法分类id',
  name                    varchar(32) comment '玩法名',
  alias                   varchar(32) comment '玩法别名',
  short_code              varchar(64) comment '算法简码，对应具体的算法实现',
  status                  varchar(16) comment '状态： 启用Enable,停用 Disable',
  type                    varchar(16) comment '类型： 节点 Node,叶子 Leef',
  redeem_type             varchar(32) comment '兑奖比对类型：投注项值 Bet_Opiton_Value，投注项 Bet_Option，按投注项排列组合 Bet_Option_Combination',
  create_time             datetime   NULL comment '创建时间',
  modify_time             datetime   NULL comment '修改时间',
  summary                 varchar(128) comment '说明',
  PRIMARY KEY (id),
  INDEX (pre_id),
  INDEX (lottery_id),
  INDEX (play_method_category_id),
  INDEX (short_code)
) comment ='玩法' ENGINE = InnoDB;
CREATE TABLE play_method_category
(
  id          bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  pre_id      bigint(20) comment 'id',
  name        varchar(32) comment '玩法名称',
  status      varchar(16) comment '状态: 启用 Enable, 停用 Disable',
  sort        int(10) comment '排序',
  type        varchar(16) comment '是否上级类型： 叶子 Leaf, 节点 Node',
  create_time datetime   NULL comment '创建时间',
  modify_time datetime   NULL comment '修改时间',
  summary     varchar(128) comment '说明',
  PRIMARY KEY (id),
  INDEX (pre_id)
) comment ='玩法分类' ENGINE = InnoDB;
CREATE TABLE sale_field
(
  id      bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  name    varchar(32) comment '名称',
  status  varchar(16) comment '状态：启用 Enable,停用 Disable',
  summary varchar(128) comment '说明',
  PRIMARY KEY (id)
) comment ='销售属性' ENGINE = InnoDB;
CREATE TABLE sale_field_play_method
(
  sale_field_id  bigint(20) comment '销售属性id',
  lottery_id     bigint(20) comment '彩票id',
  play_method_id bigint(20) comment '玩法id',
  sort           int(10) comment '排序',
  INDEX (sale_field_id),
  INDEX (lottery_id),
  INDEX (play_method_id)
) comment ='销售属性的玩法' ENGINE = InnoDB;
