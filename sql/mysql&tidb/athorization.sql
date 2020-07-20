DROP TABLE IF EXISTS auth;
DROP TABLE IF EXISTS auth_resource;
DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS department_role;
DROP TABLE IF EXISTS menu;
DROP TABLE IF EXISTS org;
DROP TABLE IF EXISTS org_account;
DROP TABLE IF EXISTS org_account_role;
DROP TABLE IF EXISTS org_role;
DROP TABLE IF EXISTS page;
DROP TABLE IF EXISTS role;
DROP TABLE IF EXISTS role_auth;
DROP TABLE IF EXISTS role_group;
DROP TABLE IF EXISTS role_group_member;
DROP TABLE IF EXISTS staff;
CREATE TABLE auth
(
  id          bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  name        varchar(32) comment '权限名',
  auth_code   varchar(32) comment '权限码',
  summary     varchar(128) comment '说明',
  status      varchar(16) comment '状态：启用 Enable,停用Disable',
  create_time datetime   NULL comment '创建时间',
  modify_time datetime   NULL comment '修改时间',
  PRIMARY KEY (id),
  INDEX (auth_code)
) comment ='权限' ENGINE = InnoDB;
CREATE TABLE auth_resource
(
  auth_id     bigint(20) comment '权限id',
  resource_id bigint(20) comment '页面id',
  type        varchar(16) comment '类型： 页面元素 Page_Element,菜单 Menu',
  INDEX (auth_id),
  INDEX (resource_id)
) comment ='权限页面资源' ENGINE = InnoDB;
CREATE TABLE department
(
  id          bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  org_id      bigint(20) comment '机构id',
  name        varchar(32) comment '部门名称',
  status      varchar(16) comment '状态：启用 Enable,停用Disable',
  summary     varchar(128) comment '说明',
  create_time datetime   NULL comment '创建时间',
  modify_time datetime   NULL comment '修改时间',
  PRIMARY KEY (id),
  INDEX (org_id)
) comment ='部门' ENGINE = InnoDB;
CREATE TABLE department_role
(
  org_id        bigint(20) comment '机构id',
  department_id bigint(20) comment '部门id',
  role_id       bigint(20) comment '角色id',
  status        varchar(16) comment '状态：启用 Enable,停用Disable',
  create_time   datetime NULL comment '创建时间',
  modify_time   datetime NULL comment '修改时间',
  INDEX (org_id),
  INDEX (department_id),
  INDEX (role_id)
) comment ='部门拥有的角色' ENGINE = InnoDB;
CREATE TABLE menu
(
  id          bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  name        varchar(32) comment '菜单名',
  uri         varchar(128) comment '请求uri',
  pre_id      bigint(20) comment '上级id',
  type        varchar(16),
  status      varchar(16) comment '状态：启用 Enable,停用Disable',
  sort        int(10) comment '排序',
  css         varchar(32) comment 'css样式',
  create_time datetime   NULL comment '创建时间',
  modify_time datetime   NULL comment '修改时间',
  PRIMARY KEY (id),
  INDEX (pre_id)
) comment ='菜单' ENGINE = InnoDB;
CREATE TABLE org
(
  id          bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  name        varchar(32) comment '机构名',
  address     varchar(128) comment '地址',
  phone       varchar(16) comment '电话',
  pre_id      bigint(20) comment '上级id',
  type        varchar(255) comment '组织类型：Head_Office 总公司,Subsidiary 子公司,大股东 Major_Shareholder，股东 Shareholder，总代 General_Agency，代理 Agent',
  status      varchar(16) comment '状态：启用 Enable,停用Disable,冻结 Freeze，停权  Disauthority',
  create_time datetime   NULL comment '创建时间',
  modify_time datetime   NULL comment '修改时间',
  PRIMARY KEY (id),
  INDEX (pre_id)
) comment ='机构' ENGINE = InnoDB;
CREATE TABLE org_account
(
  id          bigint(20)  NOT NULL comment 'id',
  staff_id    bigint(20) comment '员工id',
  account     varchar(32) NOT NULL comment '账号',
  password    varchar(32) comment '密码',
  avatar      varchar(128) comment '头像样式',
  status      varchar(16) comment '状态：启用 Enable,停用Disable,作废  Invalid',
  type        varchar(16) comment '账号类型：机构 Organization，部门 Department，员工 Staff',
  create_time datetime    NULL comment '创建时间',
  modify_time datetime    NULL comment '修改时间',
  PRIMARY KEY (id, account)
) comment ='组织机构账号' ENGINE = InnoDB;
CREATE TABLE org_account_role
(
  org_id         bigint(20) comment '机构id',
  department_id  bigint(20) comment '部门id',
  role_id        bigint(20) comment '角色id',
  org_account_id bigint(20) comment '账号id',
  status         varchar(16) comment '状态：启用 Enable,停用 Disable',
  create_time    datetime NULL comment '创建时间',
  modify_time    datetime NULL comment '修改时间',
  INDEX (org_id),
  INDEX (department_id),
  INDEX (org_account_id)
) comment ='机构账号拥有的角色' ENGINE = InnoDB;
CREATE TABLE org_role
(
  org_id      bigint(20) comment '机构id',
  role_id     bigint(20) comment '角色id',
  status      varchar(16) comment '状态：启用 Enable,停用Disable',
  create_time datetime NULL comment '创建时间',
  modify_time datetime NULL comment '修改时间',
  INDEX (org_id)
) comment ='机构的角色' ENGINE = InnoDB;
CREATE TABLE page
(
  id           bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  menu_code    bigint(20) comment '菜单id',
  name         varchar(32) comment '元素名',
  element_code varchar(64) comment '页面元素编码',
  css          varchar(32) comment '样式',
  uri          varchar(128) comment '请求uri',
  status       varchar(16) comment '状态：启用 Enable,停用Disable',
  create_time  datetime   NULL comment '创建时间',
  modify_time  datetime   NULL comment '修改时间',
  sort         int(10) comment '排序',
  summary      varchar(128) comment '说明 仅允许 64汉字',
  PRIMARY KEY (id),
  INDEX (menu_code),
  INDEX (element_code)
) comment ='页面' ENGINE = InnoDB;
CREATE TABLE role
(
  id          bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  name        varchar(32) comment '角色名',
  status      varchar(16) comment '状态：启用 Enable,停用 Disable',
  type        varchar(16) comment '类型：普通 Common,管理员  Administrator,超级管理员 Super',
  assign_type varchar(16) comment '分配类型：多人 Many，单人 One',
  create_time datetime   NULL comment '创建时间',
  modify_time datetime   NULL comment '修改时间',
  PRIMARY KEY (id)
) comment ='角色' ENGINE = InnoDB;
CREATE TABLE role_auth
(
  role_id bigint(20) comment '角色id',
  auth_id bigint(20) comment '权限id',
  INDEX (role_id),
  INDEX (auth_id)
) comment ='角色权限' ENGINE = InnoDB;
CREATE TABLE role_group
(
  id          bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  name        varchar(32) comment '角色组名',
  status      varchar(16) comment '状态：启用 Enable,停用Disable',
  create_time datetime   NULL comment '创建时间',
  modify_time datetime   NULL comment '修改时间',
  PRIMARY KEY (id)
) comment ='角色组' ENGINE = InnoDB;
CREATE TABLE role_group_member
(
  role_id       bigint(20) comment '角色id',
  role_group_id bigint(20) comment '角色组id',
  INDEX (role_id),
  INDEX (role_group_id)
) comment ='角色组成员' ENGINE = InnoDB;
CREATE TABLE staff
(
  id            bigint(20) NOT NULL AUTO_INCREMENT comment 'id',
  department_id bigint(20) comment '部门id',
  name          varchar(32) comment '员工名',
  title         varchar(32) comment '职称',
  phone         varchar(16) comment '电话',
  status        varchar(16) comment '状态：在职 On_Job，离职 Quit',
  create_time   datetime   NULL comment '创建时间',
  modify_time   datetime   NULL comment '修改时间',
  PRIMARY KEY (id)
) comment ='员工' ENGINE = InnoDB;
