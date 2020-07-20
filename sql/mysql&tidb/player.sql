DROP TABLE IF EXISTS `order`;
DROP TABLE IF EXISTS player;
DROP TABLE IF EXISTS player_account;
DROP TABLE IF EXISTS player_bank;
DROP TABLE IF EXISTS player_financial_account;
DROP TABLE IF EXISTS player_financial_detail;
DROP TABLE IF EXISTS player_lottery;
DROP TABLE IF EXISTS player_lottery_combination_option;
DROP TABLE IF EXISTS player_lottery_settle_bill;
DROP TABLE IF EXISTS player_summary;
DROP TABLE IF EXISTS withdrawal_bill;

CREATE TABLE `order`
(
  id          bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  trade_code  varchar(64) comment '交易码',
  player_id   bigint(20) comment '玩家id',
  order_no    varchar(64) comment '订单号',
  ip          varchar(16) comment 'ip',
  type        varchar(16) comment '类型：自有平台 Own_Platform，外接平台 Out_pPlatform',
  owner_type  varchar(25) comment '下单用户类型：平台 Platform,大股东 Major_Shareholder，股东 Shareholder，总代 General_Agency，代理 Agent，玩家 Player',
  status      varchar(16) comment '状态：待支付 To_Paid，已支付  Paid，取消 Cancel，待退款 To_Refunded，已退款 Refunded',
  amount      decimal(18, 4) comment '订单总额',
  create_time datetime   NULL comment '创建时间',
  modify_time datetime   NULL comment '修改时间',
  PRIMARY KEY (id),
  INDEX (player_id)
) comment ='订单' ENGINE = InnoDB;
CREATE TABLE player
(
  id           bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  name         varchar(32) comment '姓名',
  type         varchar(16) comment '类型： 外接 Out_Platform,自有 Own_Platform',
  nick_name    varchar(32) comment '昵称',
  promote_code varchar(32) comment '推广码',
  qq           varchar(16) comment 'qq',
  wechat       varchar(32) comment '微信',
  email        varchar(32) comment 'email',
  birthday     varchar(16) comment '出生日期',
  phone        varchar(20) comment '电话',
  status       varchar(16) comment '状态： 启用 Enable,停用 Disable,锁定 Locked',
  create_time  datetime   NULL comment '创建时间',
  modify_time  datetime   NULL comment '修改时间',
  PRIMARY KEY (id)
) comment ='玩家' ENGINE = InnoDB;
CREATE TABLE player_account
(
  player_id    bigint(20)  NOT NULL comment '玩家编码',
  account      varchar(32) NOT NULL comment '账户',
  password     varchar(32) comment '密码 md5加密',
  pay_password varchar(32) comment '支付密码',
  avatar       varchar(128) comment '头像',
  login_status varchar(32) comment '登录状态：在线 Online,离线 Offline,踢出 Kick_Out',
  PRIMARY KEY (player_id, account)
) comment ='玩家账户' ENGINE = InnoDB;
CREATE TABLE player_bank
(
  id             bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  player_id      bigint(20) comment '玩家id',
  bank_id        bigint(20) comment '银行id',
  bank_name      varchar(32) comment '银行名称',
  bank_card_no   varchar(64) comment '银行卡号',
  bank_card_name varchar(32) comment '持卡人名',
  status         varchar(16) comment '状态：启用 Enable,停用 Disable',
  type           varchar(16) comment '类型：银行卡 bank，微信 wechat，支付宝 alipay',
  is_default     varchar(4) comment '是否是默认：Y 是，N 否',
  create_time    datetime   NULL comment '创建时间',
  modify_time    datetime   NULL comment '修改时间',
  PRIMARY KEY (id),
  INDEX (player_id),
  INDEX (bank_id)
) comment ='玩家银行卡号' ENGINE = InnoDB;
CREATE TABLE player_financial_account
(
  id          bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  account     varchar(32) comment '财务账户',
  player_id   bigint(20) comment '玩家id',
  amount      decimal(18, 4) comment '资金',
  status      varchar(16) comment '状态：启用 Enable,停用 Disable，冻结 Freeze',
  type        varchar(16) comment '类型：本金账户 Principal，彩金账户 Bonus，佣金账户 Commission，优惠金账户 Discount',
  create_time datetime   NULL comment '创建时间',
  modify_time datetime   NULL comment '修改时间',
  PRIMARY KEY (id),
  INDEX (account)
) comment ='玩家财务账户' ENGINE = InnoDB;
CREATE TABLE player_financial_detail
(
  id                       bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  player_financial_id      bigint(20) comment '玩家财务账户id',
  player_financial_account varchar(32) comment '玩家财务账户',
  trade_code               varchar(64) comment '交易码',
  accounting_title         varchar(32) comment '会计科目',
  amount                   varchar(10) comment '金额',
  before_change_amount     varchar(10) comment '变更前金额',
  after_change_amount      varchar(10) comment '变更后金额',
  type                     varchar(16) comment '流水类型：出账 Out,进账 In',
  settle_type              varchar(20) comment '结算单类型：提现单 Withdrawal_Bill，中奖结算单 Lottery_Bill，充值单 Refill_Bill，佣金结算单 Commission_Bill',
  settle_no                varchar(32) comment '结算单号',
  opt_man                  varchar(32) comment '操作人',
  opt_man_code             varchar(64) comment '操作人编码',
  create_time              datetime   NULL comment '创建时间',
  PRIMARY KEY (id),
  INDEX (player_financial_id),
  INDEX (player_financial_account),
  INDEX (trade_code)
) comment ='财务流水明细' ENGINE = InnoDB;
CREATE TABLE player_lottery
(
  id                 bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  trade_code         varchar(64) comment '交易码',
  player_id          bigint(20) comment '玩家编码',
  order_id           bigint(20) comment '订单id',
  handicap_id        bigint(20) comment '盘口id',
  sub_handicap_id    bigint(20) comment '子盘口id',
  sub_handicap_name  varchar(32) comment '子盘口名',
  lottery_id         bigint(20) comment '彩种id',
  lottery_name       varchar(32) comment '彩种名',
  play_method_id     bigint(20) comment '玩法id',
  play_method_name   varchar(32) comment '玩法名',
  bet_option_id      bigint(20) comment '投注项id',
  bet_value          varchar(32) comment '投注项值',
  seat_number        int(10) comment '位置编号',
  issue_number       varchar(32) comment '期号',
  principal          decimal(18, 4) comment '投注本金',
  num                int(10) comment '投注数',
  odds               float comment '赔率',
  subsidiary_odds    float comment '子公司赔率',
  status             varchar(16) comment '状态：待开奖 No_Draw 中奖 Winning 未中奖 Not_Winning ,冻结 Freeze, 无效 Invalid',
  type               varchar(16) comment '类型：自有平台 Own_Platform，外接平台 Out_pPlatform',
  owner_type         varchar(25) comment '所有者类型：Head_Office 总公司,Subsidiary 子公司,大股东 Major_Shareholder，股东 Shareholder，总代 General_Agency，代理 Agent ，玩家 Player',
  bet_type           varchar(16) comment '投注类型：开 Open,不开 Not_Open',
  redeem_type        varchar(32) comment '兑奖比对类型：投注项值 Bet_Opiton_Value，投注项 Bet_Option，按投注项排列组合 Bet_Option_Combination',
  draw_bet_option_id bigint(20) comment '开奖结果投注项编码',
  draw_number        varchar(32) comment '中奖号',
  draw_time          datetime   NULL comment '开奖时间',
  create_time        datetime   NULL comment '创建时间',
  modify_time        datetime   NULL comment '修改时间',
  PRIMARY KEY (id),
  INDEX (trade_code),
  INDEX (player_id),
  INDEX (order_id),
  INDEX (handicap_id),
  INDEX (sub_handicap_id),
  INDEX (lottery_id),
  INDEX (play_method_id),
  INDEX (bet_option_id),
  INDEX (draw_bet_option_id),
  INDEX (draw_number)
) comment ='彩票' ENGINE = InnoDB;
CREATE TABLE player_lottery_combination_option
(
  id                bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  player_lottery_id bigint(20) comment '玩家彩票id',
  bet_option_id     bigint(20) comment '投注项id',
  combination_up    int(10) comment '排列组合上标',
  combination_down  int(10) comment '排列组合下标',
  index_start       int(10) comment '起始位',
  index_end         int(10) comment '结束位',
  sort              int(10) comment '排序',
  odds              varchar(10) comment '赔率',
  PRIMARY KEY (id),
  INDEX (player_lottery_id),
  INDEX (bet_option_id)
) comment ='玩家彩票排列组合投注项' ENGINE = InnoDB;
CREATE TABLE player_lottery_settle_bill
(
  id                       bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  trade_code               varchar(64) comment '交易码',
  player_lottery_id        bigint(20) comment '玩家彩票id',
  player_id                bigint(20) comment '玩家id',
  player_financial_account varchar(32) comment '玩家财务账户',
  bill_no                  varchar(32) comment '结算单号',
  amount                   decimal(18, 4) comment '结算总金额，保留2位小数',
  status                   varchar(16) comment '状态：创建 Create,结算中 Processing,已结算 Settled,无效 Invalid',
  settle_type              varchar(16) comment '结算类型：手动 Manual，自动 Auto',
  type                     varchar(16) comment '类型：中奖单 Winning，未中奖单 Lost',
  owner_type               varchar(25) comment '所有者类型：Head_Office 总公司,Subsidiary 子公司,大股东 Major_Shareholder，股东 Shareholder，总代 General_Agency，代理 Agent ，玩家 Player',
  draw_time                datetime   NULL comment '开奖时间',
  create_time              datetime   NULL comment '创建时间',
  modify_time              datetime   NULL comment '修改时间',
  PRIMARY KEY (id),
  INDEX (trade_code),
  INDEX (player_lottery_id),
  INDEX (player_id),
  INDEX (player_financial_account)
) comment ='玩家彩票结算单' ENGINE = InnoDB;
CREATE TABLE player_summary
(
  player_id   bigint(20) NOT NULL AUTO_INCREMENT comment '玩家id',
  summary     varchar(255) comment '玩家说明',
  create_time datetime   NULL comment '创建时间',
  modify_time datetime   NULL comment '修改时间',
  PRIMARY KEY (player_id)
) comment ='玩家说明' ENGINE = InnoDB;
CREATE TABLE withdrawal_bill
(
  id                       bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  player_id                bigint(20) comment '玩家id',
  player_financial_account varchar(32) comment '玩家财务账户',
  settle_no                varchar(32) comment '提现单号',
  amount                   decimal(18, 4) comment '提现金额',
  accounting_title         int(10) comment '会计科目',
  status                   varchar(16) comment '状态：申请 Apply，接受 Accept，拒绝 Reject，处理中 Processing，处理完成 Done',
  player_login_account     varchar(32) comment '玩家登录账户',
  player_name              varchar(32) comment '玩家名',
  bank_card_id             bigint(20) comment '银行卡id',
  bank_card_no             varchar(64) comment '银行账户号',
  bank_card_name           varchar(32) comment '银行卡使用者名',
  bank_name                varchar(64) comment '银行名',
  financial_account_type   varchar(16) comment '提现账户类型：本金账户 Principal，彩金账户 Bonus，佣金账户 Commission，优惠金账户 Discount',
  opt_man                  varchar(32) comment '操作人',
  opt_man_id               bigint(20) comment '操作人',
  create_time              datetime   NULL comment '创建时间',
  modify_time              datetime   NULL comment '修改时间',
  PRIMARY KEY (id),
  INDEX (player_id),
  INDEX (settle_no),
  INDEX (player_login_account)
) comment ='提现单' ENGINE = InnoDB;
