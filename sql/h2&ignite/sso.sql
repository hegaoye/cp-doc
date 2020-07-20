DROP TABLE domain IF EXISTS;
DROP TABLE domain_log IF EXISTS;
DROP TABLE setting IF EXISTS;
CREATE TABLE domain
(
  id          bigint GENERATED BY DEFAULT AS IDENTITY,
  code        varchar(64)  NOT NULL,
  domain      varchar(128) NOT NULL UNIQUE,
  public_key  varchar(1024),
  private_key varchar(1024),
  status      varchar(16),
  summary     varchar(128),
  create_time datetime,
  modify_time datetime,
  PRIMARY KEY (id, code)
);
CREATE TABLE domain_log
(
  id          bigint GENERATED BY DEFAULT AS IDENTITY,
  domain_code varchar(64)  NOT NULL,
  domain      varchar(128) NOT NULL UNIQUE,
  ip          varchar(20),
  url         varchar(256),
  header      varchar(512),
  status      varchar(16),
  type        varchar(16),
  user_code   varchar(64),
  account     varchar(32),
  "return"    tinytext,
  create_time datetime,
  PRIMARY KEY (id, domain_code)
);
CREATE TABLE setting
(
  id       bigint GENERATED BY DEFAULT AS IDENTITY,
  name     varchar(64) NOT NULL,
  "option" varchar(64),
  summary  varchar(128),
  PRIMARY KEY (id, name)
);
