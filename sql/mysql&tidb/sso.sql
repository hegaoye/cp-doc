DROP TABLE IF EXISTS domain;
DROP TABLE IF EXISTS domain_log;
DROP TABLE IF EXISTS setting;
CREATE TABLE domain
(
  id          bigint(20)   NOT NULL AUTO_INCREMENT comment 'id',
  code        varchar(64)  NOT NULL comment '编码',
  domain      varchar(128) NOT NULL UNIQUE comment '域名',
  public_key  varchar(1024) comment '公钥',
  private_key varchar(1024) comment '私钥',
  status      varchar(16) comment '状态：启用 Enable,停用 Disable,冻结 Freeze',
  summary     varchar(128) comment '说明 64个汉字',
  create_time datetime     NULL comment '创建时间',
  modify_time datetime     NULL comment '修改时间',
  PRIMARY KEY (id, code)
) comment ='域名' ENGINE = InnoDB;
CREATE TABLE domain_log
(
  id          bigint(20)   NOT NULL AUTO_INCREMENT comment 'id',
  domain_code varchar(64)  NOT NULL comment '域名编码',
  domain      varchar(128) NOT NULL UNIQUE comment '域名',
  ip          varchar(20) comment 'ip',
  url         varchar(256) comment '请求的url',
  header      varchar(512) comment 'header',
  status      varchar(16) comment '状态：启用 Enable,停用 Disable,冻结 Freeze',
  type        varchar(16) comment '类型: 玩家 Player,平台 Platform',
  user_code   varchar(64) comment '请求者编码',
  account     varchar(32) comment '账号',
  `return`    tinytext comment '返回信息',
  create_time datetime     NULL comment '创建时间',
  PRIMARY KEY (id, domain_code)
) comment ='域名日志' ENGINE = InnoDB;
CREATE TABLE setting
(
  id       bigint(20)  NOT NULL AUTO_INCREMENT comment 'id',
  name     varchar(64) NOT NULL comment '键',
  `option` varchar(64) comment '值',
  summary  varchar(128) comment '说明 64个汉字',
  PRIMARY KEY (id, name)
) comment ='设置' ENGINE = InnoDB;
