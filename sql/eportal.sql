CREATE TABLE `traffic` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SourceURL` varchar(200) DEFAULT NULL,
  `TargetURL` varchar(200) DEFAULT NULL,
  `IP` varchar(20) DEFAULT NULL,
  `Area` varchar(40) DEFAULT NULL,
  `VisitDate` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='����ͳ�Ʊ�';

CREATE TABLE `ip` (
  `ipid` int(11) NOT NULL AUTO_INCREMENT,
  `startip` decimal(10,0) DEFAULT NULL,
  `endip` decimal(10,0) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ipid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='IP��ַ��';

CREATE TABLE `admin` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `LoginName` varchar(20) DEFAULT NULL,
  `LoginPwd` varchar(50) DEFAULT NULL,
  `Privileges` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ϵͳ����Ա��';

CREATE TABLE `cart` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `MemberID` int(11) DEFAULT NULL,
  `Money` decimal(9,2) DEFAULT NULL,
  `CartStatus` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='���ﳵ��';

CREATE TABLE `cartselectedmer` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CartID` int(11) DEFAULT NULL,
  `MerchandiseID` int(11) DEFAULT NULL,
  `Number` int(11) DEFAULT NULL,
  `Price` decimal(8,2) DEFAULT NULL,
  `Money` decimal(9,2) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='���ﳵ��Ʒѡ����¼��';

CREATE TABLE `category` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ParentID` int(11) DEFAULT NULL,
  `CateName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='��Ʒ�����';

CREATE TABLE `member` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `MemberlevelID` int(11) DEFAULT NULL,
  `LoginName` varchar(20) DEFAULT NULL,
  `LoginPwd` varchar(50) DEFAULT NULL,
  `MemberName` char(12) DEFAULT NULL,
  `Phone` varchar(40) DEFAULT NULL,
  `Address` varchar(100) DEFAULT NULL,
  `Zip` char(6) DEFAULT NULL,
  `RegDate` datetime DEFAULT NULL,
  `LastDate` datetime DEFAULT NULL,
  `LoginTimes` int(11) DEFAULT NULL,
  `EMail` varchar(100) DEFAULT NULL,
  `Integral` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ע���Ա��';

CREATE TABLE `memberlevel` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `LevelName` varchar(20) DEFAULT NULL,
  `Integral` int(11) DEFAULT NULL,
  `Favourable` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='��Ա�����';

CREATE TABLE `merchandise` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CategoryID` int(11) DEFAULT NULL,
  `MerName` varchar(50) DEFAULT NULL,
  `Price` decimal(8,2) DEFAULT NULL,
  `SPrice` decimal(8,2) DEFAULT NULL,
  `MerModel` varchar(40) DEFAULT NULL,
  `Picture` varchar(100) DEFAULT NULL,
  `Video` varchar(100) DEFAULT NULL,
  `MerDesc` text,
  `Manufacturer` varchar(50) DEFAULT NULL,
  `LeaveFactoryDate` datetime DEFAULT NULL,
  `Special` int(11) DEFAULT NULL,
  `HtmlPath` varchar(100) DEFAULT NULL,
  `Status` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='��Ʒ��';

CREATE TABLE `news` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ColumnsID` int(11) DEFAULT NULL,
  `Title` varchar(50) DEFAULT NULL,
  `Content` text,
  `Abstract` varchar(400) DEFAULT NULL,
  `KeyWords` varchar(200) DEFAULT NULL,
  `IsPicNews` int(11) DEFAULT NULL,
  `Picture` varchar(100) DEFAULT NULL,
  `From` varchar(40) DEFAULT NULL,
  `CDate` datetime DEFAULT NULL,
  `Author` char(12) DEFAULT NULL,
  `Editor` char(12) DEFAULT NULL,
  `Clicks` int(11) DEFAULT NULL,
  `NewsType` int(11) DEFAULT NULL,
  `Priority` int(11) DEFAULT NULL,
  `red` int(11) DEFAULT NULL,
  `HtmlPath` varchar(100) DEFAULT NULL,
  `Status` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='��Ѷ��';

CREATE TABLE `newscolumns` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ParentID` int(11) DEFAULT NULL,
  `ColumnCode` varchar(20) DEFAULT NULL,
  `ColumnName` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='��Ѷ��Ŀ��';

CREATE TABLE `newsrule` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ColumnsID` int(11) DEFAULT NULL,
  `RuleName` varchar(100) DEFAULT NULL,
  `Encode` char(10) DEFAULT NULL,
  `URL` varchar(100) DEFAULT NULL,
  `MidEnd` text,
  `MidBegin` text,
  `ContentEnd` text,
  `ContentBegin` text,
  `FromEnd` text,
  `FromBegin` text,
  `AuthorEnd` text,
  `AuthorBegin` text,
  `TitleEnd` text,
  `TitleBegin` text,
  `ListEnd` text,
  `ListBegin` text,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='���Ųɼ������';

CREATE TABLE `orders` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `MemberID` int(11) DEFAULT NULL,
  `CartID` int(11) DEFAULT NULL,
  `OrderNO` varchar(20) DEFAULT NULL,
  `OrderDate` datetime DEFAULT NULL,
  `OrderStatus` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='������';

CREATE DEFINER=`root@%` PROCEDURE `pro_iptoaddress`(IN ipvalue double(53,0),OUT ipaddress varchar(100) CHARACTER SET utf8)
BEGIN
     select address into ipaddress  from ip where ipvalue between startip and endip limit 1;
END;