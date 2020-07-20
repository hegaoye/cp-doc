DROP TABLE IF EXISTS bet_option_auto_reduce_odds;
DROP TABLE IF EXISTS bet_option_water_level;
DROP TABLE IF EXISTS draw_bet_option_result;
DROP TABLE IF EXISTS draw_bet_option_value_result;
DROP TABLE IF EXISTS draw_result;
DROP TABLE IF EXISTS handicap;
DROP TABLE IF EXISTS handicap_bet_option;
DROP TABLE IF EXISTS handicap_bet_option_config;
DROP TABLE IF EXISTS handicap_bet_option_value;
DROP TABLE IF EXISTS handicap_config;
DROP TABLE IF EXISTS handicap_play_method;
DROP TABLE IF EXISTS handicap_play_method_algorithm;
DROP TABLE IF EXISTS handicap_play_method_config;
DROP TABLE IF EXISTS sub_handicap;

CREATE TABLE bet_option_auto_reduce_odds
(
  id            bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  bet_option_id bigint(20) comment '投注项id',
  water_level   int(10) comment '水位线',
  reduce_odds   varchar(10) comment '降低赔率点数',
  lowest_odds   varchar(10) comment '最低赔率',
  PRIMARY KEY (id),
  INDEX (bet_option_id)
) comment ='自动降赔配置' ENGINE = InnoDB;
CREATE TABLE bet_option_water_level
(
  bet_option_id bigint(20) NOT NULL AUTO_INCREMENT comment '投注项id',
  water_level   int(10) comment '当前水位线',
  odds          varchar(10) comment '当前赔率',
  PRIMARY KEY (bet_option_id)
) comment ='投注项当前水位线' ENGINE = InnoDB;
CREATE TABLE draw_bet_option_result
(
  id              bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  lottery_id      bigint(20) comment '彩票id',
  lottery_name    varchar(64) comment '彩票名',
  handicap_id     bigint(20) comment '盘口id',
  sub_handicap_id bigint(20) comment '子盘口id',
  play_method_id  bigint(20) comment '玩法id',
  draw_id         bigint(20) comment '开奖id',
  issue_number    varchar(32) comment '期号',
  draw_number     varchar(64) comment '开奖号码',
  bet_option_id   bigint(20) comment '中奖投注项id',
  bet_option_name varchar(32) comment '中奖投注项',
  seat_number     int(10) comment '座位号，中奖投注项在开奖号码的第几位上',
  draw_time       datetime   NULL comment '开奖时间',
  create_time     datetime   NULL comment '创建时间',
  PRIMARY KEY (id),
  INDEX (lottery_id),
  INDEX (handicap_id),
  INDEX (sub_handicap_id),
  INDEX (play_method_id),
  INDEX (draw_id),
  INDEX (issue_number),
  INDEX (draw_number),
  INDEX (bet_option_id)
) comment ='开奖投注项结果' ENGINE = InnoDB;
CREATE TABLE draw_bet_option_value_result
(
  id                        bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  draw_bet_option_result_id bigint(20) comment '投注项结果id',
  bet_option_value          varchar(32) comment '开奖投注项值',
  PRIMARY KEY (id),
  INDEX (draw_bet_option_result_id)
) ENGINE = InnoDB;
CREATE TABLE draw_result
(
  id           bigint(20)  NOT NULL AUTO_INCREMENT comment 'id',
  lottery_id   bigint(20) comment '彩票id',
  handicap_id  bigint(20)  NOT NULL comment '盘口id',
  lottery_name varchar(64) comment '彩票名',
  issue_number varchar(32) NOT NULL comment '期号',
  status       varchar(16) comment '状态：待开奖 Draw,开奖中 Drawing,已开奖 Drawn',
  num          int(10) comment '位数',
  create_time  datetime    NULL comment '创建时间',
  modify_time  datetime    NULL comment '修改时间',
  draw_number  varchar(32) comment '开奖号码',
  PRIMARY KEY (id),
  INDEX (lottery_id),
  INDEX (handicap_id),
  INDEX (issue_number)
) comment ='开奖结果' ENGINE = InnoDB;
CREATE TABLE handicap
(
  id           bigint(20)  NOT NULL AUTO_INCREMENT,
  lottery_id   bigint(20) comment '彩种id',
  lottery_name varchar(32) comment '彩种名',
  issue_number varchar(32) comment '期号',
  max_limit    varchar(10) NOT NULL comment '最大投注限额',
  status       varchar(32) comment '状态：启用 Enable,可投注 Betting，停止投注 Stop_Betting，限额 Quota，锁盘 Lock_Betting，封盘  Block_Betting',
  sort         int(10) comment '排序',
  create_time  datetime    NULL comment '创建时间',
  modify_time  datetime    NULL comment '修改时间',
  ver          int(10) comment '版本号',
  PRIMARY KEY (id),
  INDEX (lottery_id),
  INDEX (issue_number)
) comment ='盘口' ENGINE = InnoDB;
CREATE TABLE handicap_bet_option
(
  id               bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  play_method_id   bigint(20) comment '玩法id',
  bet_option_id    bigint(20) comment '投注项id',
  alias            varchar(32) comment '别名',
  name             varchar(32) comment '投注项名',
  combination_up   int(10) comment '排列组合上标',
  combination_down int(10) comment '排列组合下标',
  odds             varchar(10) comment '赔率',
  status           varchar(16) comment '状态：启用 Enable,停用 Disable',
  bet_option_type  varchar(32) comment '投注项类型：大，小，单，双，龙，虎等等',
  sort             int(10) comment '排序',
  create_time      datetime   NULL comment '创建时间',
  modify_time      datetime   NULL comment '修改时间',
  PRIMARY KEY (id),
  INDEX (play_method_id),
  INDEX (bet_option_id)
) comment ='投注项' ENGINE = InnoDB;
CREATE TABLE handicap_bet_option_config
(
  id            bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  bet_option_id bigint(20),
  config_option varchar(32) comment '配置项',
  config_value  varchar(128) comment '配置值',
  status        varchar(16) comment '状态： 启动 Enable, 停用 Disable',
  summary       varchar(128) comment '说明',
  PRIMARY KEY (id),
  INDEX (bet_option_id)
) comment ='投注项配置' ENGINE = InnoDB;
CREATE TABLE handicap_bet_option_value
(
  id                  bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  bet_option_id       bigint(20) comment '投注项id',
  bet_option_value_id bigint(20) comment '投注项值id',
  bet_option_value    varchar(64) comment '投注项值',
  status              varchar(16) comment '状态： 启用 Enable,停用 Disable',
  sort                int(10) comment '排序',
  PRIMARY KEY (id),
  INDEX (bet_option_id),
  INDEX (bet_option_value_id)
) comment ='投注项值' ENGINE = InnoDB;
CREATE TABLE handicap_config
(
  id            bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  handicap_id   bigint(20),
  config_option varchar(32) comment '配置项',
  config_value  varchar(128) comment '配置值',
  status        varchar(16) comment '状态： 启动 Enable, 停用 Disable',
  summary       varchar(128) comment '说明',
  PRIMARY KEY (id),
  INDEX (handicap_id)
) ENGINE = InnoDB;
CREATE TABLE handicap_play_method
(
  id                      bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  pre_id                  bigint(20) comment '上级id',
  play_method_id          bigint(20) comment '玩法id',
  play_method_category_id bigint(20) comment '玩法分类id',
  sub_handicap_id         bigint(20) comment '子盘口id',
  short_code              varchar(64) comment '算法简码',
  name                    varchar(32) comment '玩法名',
  status                  varchar(16) comment '状态： 启用Enable,停用 Disable',
  type                    varchar(16) comment '类型： 节点 Node,叶子 Leef',
  redeem_type             varchar(32) comment '兑奖比对类型：投注项值 Bet_Opiton_Value，投注项 Bet_Option，按投注项排列组合 Bet_Option_Combination',
  create_time             datetime   NULL comment '创建时间',
  modify_time             datetime   NULL comment '修改时间',
  summary                 varchar(128) comment '说明',
  PRIMARY KEY (id),
  INDEX (pre_id),
  INDEX (play_method_id),
  INDEX (play_method_category_id),
  INDEX (sub_handicap_id),
  INDEX (short_code)
) comment ='玩法' ENGINE = InnoDB;
CREATE TABLE handicap_play_method_algorithm
(
  id              bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  play_method_id  bigint(20) comment '玩法id',
  name            varchar(32) comment '算法名',
  short_code      varchar(32) comment '算法名简码',
  annotation_code varchar(32) comment '注解编码',
  mq_topic        varchar(64) comment '消息队列topic',
  url             varchar(128) comment '玩法接口路径',
  type            varchar(16) comment '类型： 反射 Reflection, 消息Mq,接口协议 Http',
  status          varchar(16) comment '状态： 启用Enable ,停用 Disable',
  summary         varchar(128) comment '说明',
  PRIMARY KEY (id),
  INDEX (play_method_id),
  INDEX (short_code)
) comment ='玩法算法' ENGINE = InnoDB;
CREATE TABLE handicap_play_method_config
(
  id                      bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  handicap_play_method_id bigint(20),
  config_option           varchar(32) comment '配置项',
  config_value            varchar(128) comment '配置值',
  status                  varchar(16) comment '状态： 启动 Enable, 停用 Disable',
  summary                 varchar(128) comment '说明',
  PRIMARY KEY (id),
  INDEX (handicap_play_method_id)
) ENGINE = InnoDB;
CREATE TABLE sub_handicap
(
  id           bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  handicap_id  bigint(20) comment '盘口id',
  name         varchar(32) comment '子盘口名 如：A,B,C,D 子盘口',
  issue_number varchar(32) comment '期号',
  status       varchar(16) comment '状态：启用 Enable,可投注 Betting，停止投注 Stop_Betting，限额 Quota，锁盘 Lock_Betting，封盘  Block_Betting',
  sort         int(10) comment '排序',
  create_time  datetime   NULL comment '创建时间',
  modify_time  datetime   NULL comment '修改时间',
  PRIMARY KEY (id),
  INDEX (handicap_id),
  INDEX (issue_number)
) comment ='子盘口' ENGINE = InnoDB;
