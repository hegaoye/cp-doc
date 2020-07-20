DROP TABLE IF EXISTS commission_settle_bill;
DROP TABLE IF EXISTS org_commission_chain_ratio;
DROP TABLE IF EXISTS org_commission_horizontal_ratio;
DROP TABLE IF EXISTS org_financial_account;
DROP TABLE IF EXISTS org_financial_detail;
DROP TABLE IF EXISTS org_ratio_config;
DROP TABLE IF EXISTS org_share_chain_ratio;
DROP TABLE IF EXISTS org_share_horizontal_ratio;
DROP TABLE IF EXISTS player_chain_relation;
DROP TABLE IF EXISTS player_commission_chain_ratio;
DROP TABLE IF EXISTS player_commission_horizontal_ratio;
DROP TABLE IF EXISTS player_commission_settle_bill;
DROP TABLE IF EXISTS player_horizontal_relation;
DROP TABLE IF EXISTS player_ratio_config;
DROP TABLE IF EXISTS ratio_settle_bill;

CREATE TABLE commission_settle_bill
(
  id                bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  org_id            bigint(20) comment '机构id',
  trade_code        varchar(64) comment '交易码',
  settle_no         varchar(64) comment '结算单号',
  financial_account varchar(32) comment '财务账户',
  player_lottery_id bigint(20) comment '玩家彩票id',
  accountingTitle   varchar(32) comment '会计科目',
  commission_amount varchar(10) comment '占成结算金额',
  settle_type       varchar(16) comment '结算类型：手动 Manual，自动 Auto',
  type              varchar(16) comment '资金流向类型：出 Out,入 In',
  status            varchar(16) comment '状态：创建 Create,结算中 Processing,已结算 Settled,无效 Invalid',
  create_time       datetime   NULL,
  modify_time       datetime   NULL comment '修改时间',
  PRIMARY KEY (id),
  INDEX (org_id),
  INDEX (trade_code),
  INDEX (settle_no),
  INDEX (financial_account),
  INDEX (player_lottery_id)
) ENGINE = InnoDB;
CREATE TABLE org_commission_chain_ratio
(
  id              bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  lottery_id      bigint(20) comment '彩票id',
  pre_id          bigint(20) comment '上级id',
  org_id          bigint(20) comment '机构id',
  ratio           varchar(10) comment '占成',
  left_ratio_type varchar(25) comment '剩余占成归属类型：平台 Platform,大股东 Major_Shareholder',
  org_type        varchar(25) comment '组织类型：平台 Platform,大股东 Major_Shareholder，股东 Shareholder，总代 General Agency，代理 Agent',
  create_time     datetime   NULL comment '创建时间',
  modify_time     datetime   NULL comment '修改时间',
  PRIMARY KEY (id),
  INDEX (lottery_id),
  INDEX (pre_id),
  INDEX (org_id)
) comment ='组织机构链式占成关系' ENGINE = InnoDB;
CREATE TABLE org_commission_horizontal_ratio
(
  id              bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  lottery_id      bigint(20) comment '彩票id',
  pre_id          bigint(20) comment '上级id',
  org_id          bigint(20) comment '机构id',
  ratio           varchar(10) comment '占成',
  left_ratio_type varchar(25) comment '剩余占成归属类型：平台 Platform,大股东 Major_Shareholder',
  org_type        varchar(25) comment '组织类型：平台 Platform,大股东 Major_Shareholder，股东 Shareholder，总代 General Agency，代理 Agent',
  create_time     datetime   NULL comment '创建时间',
  modify_time     datetime   NULL comment '修改时间',
  PRIMARY KEY (id),
  INDEX (lottery_id),
  INDEX (pre_id),
  INDEX (org_id)
) ENGINE = InnoDB;
CREATE TABLE org_financial_account
(
  id                bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  org_id            bigint(20) comment '组织id',
  financial_account varchar(32) comment '财务账户',
  amount            varchar(10) comment '信用金额',
  status            varchar(16) comment '状态：启用 Enable,停用 Disable',
  create_time       datetime   NULL comment '创建时间',
  modify_time       datetime   NULL comment '修改时间',
  PRIMARY KEY (id),
  INDEX (org_id),
  INDEX (financial_account)
) comment ='机构财务账户' ENGINE = InnoDB;
CREATE TABLE org_financial_detail
(
  id                    bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  org_financial_id      bigint(20) comment '玩家财务账户id',
  org_financial_account varchar(32) comment '玩家财务账户',
  trade_code            varchar(64) comment '交易码',
  accounting_title      varchar(32) comment '会计科目',
  amount                varchar(10) comment '金额',
  before_change_amount  varchar(10) comment '变更前金额',
  after_change_amount   varchar(10) comment '变更后金额',
  type                  varchar(16) comment '流水类型：出账 Out,进账 In',
  settle_type           varchar(20) comment '结算单类型：提现单 Withdrawal_Bill，中奖结算单 Lottery_Bill，充值单 Refill_Bill，佣金结算单 Commission_Bill',
  settle_no             varchar(32) comment '结算单号',
  opt_man               varchar(32) comment '操作人',
  opt_man_code          varchar(64) comment '操作人编码',
  create_time           datetime   NULL comment '创建时间',
  PRIMARY KEY (id),
  INDEX (org_financial_id),
  INDEX (org_financial_account),
  INDEX (trade_code)
) ENGINE = InnoDB;
CREATE TABLE org_ratio_config
(
  id         bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  lottery_id bigint(20) comment '彩票id',
  org_id     bigint(20) comment '机构编码',
  ratio      varchar(10) comment '比例',
  type       varchar(16) comment '类型：占成比 Proportion，返佣比 Commission，赔率 Odds',
  org_type   varchar(25) comment '组织类型：平台 Platform,大股东 Major_Shareholder，股东 Shareholder，总代 General Agency，代理 Agent，玩家 Player',
  status     varchar(255) comment '状态: 启用 Enable , 停用 Disable',
  PRIMARY KEY (id),
  INDEX (lottery_id),
  INDEX (org_id)
) comment ='佣金，占成，赔率分配配置比例' ENGINE = InnoDB;
CREATE TABLE org_share_chain_ratio
(
  id              bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  lottery_id      bigint(20) comment '彩票id',
  pre_id          bigint(20) comment '上级id',
  org_id          bigint(20) comment '机构id',
  ratio           varchar(10) comment '占成',
  left_ratio_type varchar(25) comment '剩余占成归属类型：平台 Platform,大股东 Major_Shareholder',
  org_type        varchar(25) comment '组织类型：平台 Platform,大股东 Major_Shareholder，股东 Shareholder，总代 General Agency，代理 Agent',
  create_time     datetime   NULL comment '创建时间',
  modify_time     datetime   NULL comment '修改时间',
  PRIMARY KEY (id),
  INDEX (lottery_id),
  INDEX (pre_id),
  INDEX (org_id)
) ENGINE = InnoDB;
CREATE TABLE org_share_horizontal_ratio
(
  id              bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  lottery_id      bigint(20) comment '彩票id',
  pre_id          bigint(20) comment '上级id',
  org_id          bigint(20) comment '机构id',
  ratio           varchar(10) comment '占成',
  left_ratio_type varchar(25) comment '剩余占成归属类型：平台 Platform,大股东 Major_Shareholder',
  org_type        varchar(25) comment '组织类型：平台 Platform,大股东 Major_Shareholder，股东 Shareholder，总代 General Agency，代理 Agent',
  create_time     datetime   NULL comment '创建时间',
  modify_time     datetime   NULL comment '修改时间',
  PRIMARY KEY (id),
  INDEX (lottery_id),
  INDEX (pre_id),
  INDEX (org_id)
) ENGINE = InnoDB;
CREATE TABLE player_chain_relation
(
  pre_player_id bigint(20) comment '上级玩家id',
  player_id     bigint(20) comment '玩家id',
  INDEX (pre_player_id),
  INDEX (player_id)
) comment ='玩家下线链式关系' ENGINE = InnoDB;
CREATE TABLE player_commission_chain_ratio
(
  id            bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  lottery_id    bigint(20) comment '彩票id',
  pre_id        bigint(20) comment '上级id',
  org_id        bigint(20) comment '组织id',
  ratio         varchar(10) comment '返佣比例',
  org_type      varchar(25) comment '组织类型：平台 Platform,大股东 Major_Shareholder，股东 Shareholder，总代 General Agency，代理 Agent，玩家 Player',
  downward_type varchar(16) comment '向下分配类型：可不同 Custom，相同 Same',
  create_time   datetime   NULL comment '创建时间',
  modify_time   datetime   NULL comment '修改时间',
  PRIMARY KEY (id),
  INDEX (lottery_id),
  INDEX (pre_id),
  INDEX (org_id)
) comment ='佣金链式关系' ENGINE = InnoDB;
CREATE TABLE player_commission_horizontal_ratio
(
  id            bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  lottery_id    bigint(20) comment '彩票id',
  pre_id        bigint(20) comment '上级id',
  org_id        bigint(20) comment '组织id',
  ratio         varchar(10) comment '返佣比例',
  org_type      varchar(25) comment '组织类型：平台 Platform,大股东 Major_Shareholder，股东 Shareholder，总代 General Agency，代理 Agent，玩家 Player',
  downward_type varchar(16) comment '向下分配类型：可不同 Custom，相同 Same',
  create_time   datetime   NULL comment '创建时间',
  modify_time   datetime   NULL comment '修改时间',
  PRIMARY KEY (id),
  INDEX (lottery_id),
  INDEX (pre_id),
  INDEX (org_id)
) comment ='佣金水平比例' ENGINE = InnoDB;
CREATE TABLE player_commission_settle_bill
(
  id                bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  player_id         bigint(20) comment '玩家id',
  trade_code        varchar(64) comment '交易码',
  settle_no         varchar(64) comment '结算单号',
  financial_account varchar(32) comment '财务账户',
  player_lottery_id bigint(20) comment '彩票id',
  accountingTitle   varchar(32) comment '会计科目',
  amount            varchar(10) comment '佣金结算金额',
  settle_type       varchar(16) comment '结算类型：手动 Manual，自动 Auto',
  type              varchar(8) comment '资金流向类型： 出 Out, 入 In',
  status            varchar(16) comment '状态：创建 Create,结算中 Processing,已结算 Settled,无效 Invalid',
  create_time       datetime   NULL comment '创建时间',
  modify_time       datetime   NULL comment '修改时间',
  PRIMARY KEY (id),
  INDEX (player_id),
  INDEX (trade_code),
  INDEX (settle_no),
  INDEX (financial_account),
  INDEX (player_lottery_id)
) comment ='玩家佣金' ENGINE = InnoDB;
CREATE TABLE player_horizontal_relation
(
  pre_player_id bigint(20) comment '上级玩家id',
  player_id     bigint(20) comment '玩家id',
  INDEX (pre_player_id),
  INDEX (player_id)
) comment ='玩家下级，水平关系' ENGINE = InnoDB;
CREATE TABLE player_ratio_config
(
  id         bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  lottery_id bigint(20) comment '彩票id',
  player_id  bigint(20) comment '机构编码',
  ratio      varchar(10) comment '比例',
  type       varchar(16) comment '类型：占成比 Proportion，返佣比 Commission，赔率 Odds',
  status     varchar(255) comment '状态: 启用 Enable , 停用 Disable',
  PRIMARY KEY (id),
  INDEX (lottery_id),
  INDEX (player_id)
) ENGINE = InnoDB;
CREATE TABLE ratio_settle_bill
(
  id                bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  org_id            bigint(20) comment '机构id',
  trade_code        varchar(64) comment '交易码',
  settle_no         varchar(64) comment '结算单号',
  financial_account varchar(32) comment '财务账户',
  player_lottery_id bigint(20) comment '玩家彩票id',
  accountingTitle   varchar(32) comment '会计科目',
  ratio_amount      varchar(10) comment '占成结算金额',
  settle_type       varchar(16) comment '结算类型：手动 Manual，自动 Auto',
  type              varchar(16) comment '资金流向类型：出 Out,入 In',
  status            varchar(16) comment '状态：创建 Create,结算中 Processing,已结算 Settled,无效 Invalid',
  create_time       datetime   NULL,
  modify_time       datetime   NULL comment '修改时间',
  PRIMARY KEY (id),
  INDEX (org_id),
  INDEX (trade_code),
  INDEX (settle_no),
  INDEX (financial_account),
  INDEX (player_lottery_id)
) comment ='占成结算单' ENGINE = InnoDB;
