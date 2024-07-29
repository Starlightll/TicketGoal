CREATE DATABASE TicketGoal
GO
USE TicketGoal
GO

CREATE TABLE Role
(
  roleId INT,
  roleName NVARCHAR(200) NOT NULL,
  PRIMARY KEY (roleId)
);

CREATE TABLE Pitch
(
  pitchId INT NOT NULL,
  pitchName NVARCHAR(200) NOT NULL,
  addressName NVARCHAR(2000),
  addressURL NVARCHAR(2000),
  pitchStructure VARBINARY(MAX),
  image VARBINARY(MAX),
  PRIMARY KEY (pitchId)
);

CREATE TABLE Area
(
  areaId INT NOT NULL,
  areaName NVARCHAR(200) UNIQUE NOT NULL,
  pitchId INT NOT NULL,
  PRIMARY KEY (areaId),
  FOREIGN KEY (pitchId) REFERENCES Pitch(pitchId)
);

CREATE TABLE Country
(
  countryId INT IDENTITY(1,1) NOT NULL,
  countryName NVARCHAR(200) NOT NULL,
  PRIMARY KEY (countryId)
);

CREATE TABLE PlayerRole
(
  playerRoleId INT NOT NULL,
  roleName NVARCHAR(200) NOT NULL,
  PRIMARY KEY (playerRoleId)
);

CREATE TABLE Club
(
  clubId INT IDENTITY(1,1) NOT NULL,
  clubName NVARCHAR(200),
  logo NVARCHAR(Max),
  PRIMARY KEY (clubId)
);

CREATE TABLE ticketStatus
(
  ticketStatusId INT NOT NULL,
  statusName NVARCHAR(200) NOT NULL,
  PRIMARY KEY (ticketStatusId)
);

CREATE TABLE seatStatus
(
  seatStatusId INT NOT NULL,
  statusName NVARCHAR(200) NOT NULL,
  PRIMARY KEY (seatStatusId)
);

CREATE TABLE matchStatus
(
  matchStatusId INT NOT NULL,
  statusName NVARCHAR(200) NOT NULL,
  PRIMARY KEY (matchStatusId)
);

CREATE TABLE accountStatus
(
  accountStatusId INT NOT NULL,
  statusName NVARCHAR(200) NOT NULL,
  PRIMARY KEY (accountStatusId)
);

CREATE TABLE Contact
(
  contactId INT IDENTITY (1, 1),
  message NVARCHAR(2000) NOT NULL,
  name NVARCHAR(200),
  createDate DATE,
  title NVARCHAR(200),
  email NVARCHAR(200) NOT NULL,
  PRIMARY KEY (contactId)
);

CREATE TABLE Contact_Category
(
  id INT NOT NULL,
  name NVARCHAR(200) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE Contact_Cate
(
  ContactID INT NOT NULL,
  CategoryID INT NOT NULL,
  PRIMARY KEY (ContactID, CategoryID),
  FOREIGN KEY (ContactID) REFERENCES Contact(contactId),
  FOREIGN KEY (CategoryID) REFERENCES Contact_Category(id)
);

CREATE TABLE Message(
	id int IDENTITY(1,1) NOT NULL,
	email nvarchar(max) NOT NULL,
	subject nvarchar(max) NOT NULL,
	message nvarchar(max) NOT NULL,
	createDate datetime NOT NULL,
	PRIMARY KEY (id)
)

CREATE TABLE Account
(
  accountId INT IDENTITY(1,1) NOT NULL,
  username NVARCHAR(200) NOT NULL,
  password NVARCHAR(500) NOT NULL,
  email NVARCHAR(200) NOT NULL,
  firstname NVARCHAR(200),
  lastname NVARCHAR(200),
  phoneNumber NVARCHAR(20),
  gender INT,
  address NVARCHAR(500),
  birth DATE,
  roleId INT NOT NULL,
  accountStatusId INT NOT NULL,
  PRIMARY KEY (accountId),
  FOREIGN KEY (roleId) REFERENCES Role(roleId),
  FOREIGN KEY (accountStatusId) REFERENCES accountStatus(accountStatusId)
);

CREATE TABLE Match
(
  matchId INT IDENTITY(1,1) NOT NULL,
  matchTitle NVARCHAR(100),
  schedule DATETIME NOT NULL,
  pitchId INT NOT NULL,
  matchStatusId INT NOT NULL,
  club1 INT NOT NULL,
  club2 INT NOT NULL,
  club1Score INT,
  club2Score INT,
  PRIMARY KEY (matchId),
  FOREIGN KEY (pitchId) REFERENCES Pitch(pitchId),
  FOREIGN KEY (matchStatusId) REFERENCES matchStatus(matchStatusId)
);

CREATE TABLE Seat
(
  seatId INT IDENTITY(1,1) NOT NULL,
  seatNumber INT,
  row NVARCHAR(50),
  price INT,
  areaId INT,
  seatStatusId INT,
  matchId INT,
  PRIMARY KEY (seatId),
  FOREIGN KEY (matchId) REFERENCES Match(matchId),
  FOREIGN KEY (areaId) REFERENCES Area(areaId),
  FOREIGN KEY (seatStatusId) REFERENCES seatStatus(seatStatusId)
);

CREATE TABLE Player
(
  playerId INT IDENTITY(1,1) NOT NULL,
  playerName NVARCHAR(200),
  playerNumber INT,
  dateOfBirth date,
  height FLOAT,
  weight FLOAT,
  biography NVARCHAR(2000),
  playerImage VARBINARY(MAX),
  countryId INT,
  playerRoleId INT,
  PRIMARY KEY (playerId),
  FOREIGN KEY (countryId) REFERENCES Country(countryId),
  FOREIGN KEY (playerRoleId) REFERENCES PlayerRole(playerRoleId)
);

CREATE TABLE Performance
(
  performanceId INT IDENTITY(1,1) NOT NULL,
  atk INT,
  def INT,
  spd INT,
  playerId INT UNIQUE,
  PRIMARY KEY (performanceId),
  FOREIGN KEY (playerId) REFERENCES Player(playerId)
);

CREATE TABLE Cart
(
  cartId INT IDENTITY(1000,1) NOT NULL,
  accountId INT NOT NULL,
  PRIMARY KEY (cartId),
  FOREIGN KEY (accountId) REFERENCES Account(accountId)
);

CREATE TABLE OrderStatus(
	orderStatusId INT NOT NULL,
	orderStatusName NVARCHAR(100),
	PRIMARY KEY (orderStatusId)
);

CREATE TABLE [Order](
	orderId INT IDENTITY(1,1) NOT NULL,
	totalAmount FLOAT,
	accountId INT,
	orderStatusId INT,
	orderDate DATETIME,
	PRIMARY KEY (orderId),
	FOREIGN KEY (accountId) REFERENCES Account(accountId),
	FOREIGN KEY (orderStatusId) REFERENCES OrderStatus(orderStatusId)
);




CREATE TABLE Ticket
(
  ticketId INT IDENTITY(100,1) NOT NULL,
  code NVARCHAR(MAX),
  date DATE NOT NULL,
  seatId INT NOT NULL,
  ticketStatusId INT NOT NULL,
  cartId INT NOT NULL,
  matchId INT NOT NULL,
  PRIMARY KEY (ticketId),
  FOREIGN KEY (seatId) REFERENCES Seat(seatId),
  FOREIGN KEY (ticketStatusId) REFERENCES ticketStatus(ticketStatusId),
  FOREIGN KEY (cartId) REFERENCES Cart(cartId),
  FOREIGN KEY (matchId) REFERENCES Match(matchId),
);

CREATE TABLE OrderLine(
	ticketId INT NOT NULL FOREIGN KEY (ticketId) REFERENCES Ticket(ticketId),
	orderId INT NOT NULL FOREIGN KEY (orderId) REFERENCES [Order](orderId),
	PRIMARY KEY (orderId, ticketId)
);


CREATE TABLE [dbo].[Promotion] (
    promotionId INT IDENTITY(1,1) PRIMARY KEY,
    promotionCode VARCHAR(10) NOT NULL,
    promotionDescription NVARCHAR(100),
    promotionStartDate DATETIME NOT NULL,
    promotionEndDate DATETIME NOT NULL,
	promotionMatchId INT NOT NULL,
	promotionDiscount INT NOT NULL,
);


CREATE TABLE [dbo].[PromotionMatch] (
    promotionMatchId INT IDENTITY(1,1) PRIMARY KEY,
    promotionId INT NOT NULL,
    matchId INT NOT NULL,
    FOREIGN KEY (matchId) REFERENCES [dbo].[Match](matchId),
    FOREIGN KEY (promotionId) REFERENCES [dbo].[Promotion](promotionId)
);



INSERT INTO accountStatus (accountStatusId, statusName) Values (1, 'Enable'), (2, 'Disable')

INSERT INTO Role (roleId, roleName) VALUES (1, 'Admin'), (2, 'Customer'), (3, 'Operater')


INSERT INTO OrderStatus (orderStatusId, orderStatusName) VALUES (1, 'Paid')
INSERT INTO OrderStatus (orderStatusId, orderStatusName) VALUES (2, 'Pending')
INSERT INTO OrderStatus (orderStatusId, orderStatusName) VALUES (3, 'Cancelled')
INSERT INTO OrderStatus (orderStatusId, orderStatusName) VALUES (4, 'Refunded')
INSERT INTO OrderStatus (orderStatusId, orderStatusName) VALUES (0, 'Removed')

INSERT INTO matchStatus (matchStatusId, statusName) VALUES (1, 'Upcoming')
INSERT INTO matchStatus (matchStatusId, statusName) VALUES (2, 'Ongoing')
INSERT INTO matchStatus (matchStatusId, statusName) VALUES (3, 'Finished')
INSERT INTO matchStatus (matchStatusId, statusName) VALUES (4, 'Cancelled')
INSERT INTO matchStatus (matchStatusId, statusName) VALUES (0, 'Removed')

INSERT INTO seatStatus (seatStatusId, statusName) VALUES (1, 'Available')
INSERT INTO seatStatus (seatStatusId, statusName) VALUES (2, 'Reserved')
INSERT INTO seatStatus (seatStatusId, statusName) VALUES (3, 'Sold')
INSERT INTO seatStatus (seatStatusId, statusName) VALUES (4, 'Unavailable')
INSERT INTO seatStatus (seatStatusId, statusName) VALUES (5, 'InCart')

INSERT INTO PlayerRole (playerRoleId, roleName) VALUES (1, 'Goalkeeper')
INSERT INTO PlayerRole (playerRoleId, roleName) VALUES (2, 'Defender')
INSERT INTO PlayerRole (playerRoleId, roleName) VALUES (3, 'Midfielder')
INSERT INTO PlayerRole (playerRoleId, roleName) VALUES (4, 'Forward')

INSERT INTO ticketStatus (ticketStatusId, statusName) VALUES (1, 'Paid')
INSERT INTO ticketStatus (ticketStatusId, statusName) VALUES (2, 'Unpaid')
INSERT INTO ticketStatus (ticketStatusId, statusName) VALUES (3, 'Cancelled')
INSERT INTO ticketStatus (ticketStatusId, statusName) VALUES (4, 'Refunded')
INSERT INTO ticketStatus (ticketStatusId, statusName) VALUES (5, 'Used')

INSERT [dbo].[Contact_Category] ([id], [name]) VALUES (1, N'read')
INSERT [dbo].[Contact_Category] ([id], [name]) VALUES (2, N'unread    ')
INSERT [dbo].[Contact_Category] ([id], [name]) VALUES (3, N'important ')
INSERT [dbo].[Contact_Category] ([id], [name]) VALUES (4, N'starred   ')

INSERT INTO Pitch (pitchId, pitchName, addressName, addressURL, pitchStructure, image) 
VALUES (1, 'Stadium 1', 'Ha Noi, Viet Nam', 'https://g.co/kgs/zZ8vYMs', null, null)


INSERT INTO Area (areaId, areaName, pitchId) VALUES (111, 'ARO', 1)
INSERT INTO Area (areaId, areaName, pitchId) VALUES (112, 'ALO', 1)
INSERT INTO Area (areaId, areaName, pitchId) VALUES (121, 'BRO', 1)
INSERT INTO Area (areaId, areaName, pitchId) VALUES (131, 'CRO', 1)
INSERT INTO Area (areaId, areaName, pitchId) VALUES (132, 'CLO', 1)
INSERT INTO Area (areaId, areaName, pitchId) VALUES (141, 'DLO', 1)


INSERT INTO Country (countryName) VALUES (N'United States');
INSERT INTO Country (countryName) VALUES (N'Afghanistan');
INSERT INTO Country (countryName) VALUES (N'Albania');
INSERT INTO Country (countryName) VALUES (N'Algeria');
INSERT INTO Country (countryName) VALUES (N'American Samoa');
INSERT INTO Country (countryName) VALUES (N'Andorra');
INSERT INTO Country (countryName) VALUES (N'Angola');
INSERT INTO Country (countryName) VALUES (N'Anguilla');
INSERT INTO Country (countryName) VALUES (N'Antarctica');
INSERT INTO Country (countryName) VALUES (N'Antigua and Barbuda');
INSERT INTO Country (countryName) VALUES (N'Argentina');
INSERT INTO Country (countryName) VALUES (N'Armenia');
INSERT INTO Country (countryName) VALUES (N'Aruba');
INSERT INTO Country (countryName) VALUES (N'Australia');
INSERT INTO Country (countryName) VALUES (N'Austria');
INSERT INTO Country (countryName) VALUES (N'Azerbaijan');
INSERT INTO Country (countryName) VALUES (N'Bahamas');
INSERT INTO Country (countryName) VALUES (N'Bahrain');
INSERT INTO Country (countryName) VALUES (N'Bangladesh');
INSERT INTO Country (countryName) VALUES (N'Barbados');
INSERT INTO Country (countryName) VALUES (N'Belarus');
INSERT INTO Country (countryName) VALUES (N'Belgium');
INSERT INTO Country (countryName) VALUES (N'Belize');
INSERT INTO Country (countryName) VALUES (N'Benin');
INSERT INTO Country (countryName) VALUES (N'Bermuda');
INSERT INTO Country (countryName) VALUES (N'Bhutan');
INSERT INTO Country (countryName) VALUES (N'Bolivia');
INSERT INTO Country (countryName) VALUES (N'Bosnia and Herzegovina');
INSERT INTO Country (countryName) VALUES (N'Botswana');
INSERT INTO Country (countryName) VALUES (N'Bouvet Island');
INSERT INTO Country (countryName) VALUES (N'Brazil');
INSERT INTO Country (countryName) VALUES (N'British Indian Ocean Territory');
INSERT INTO Country (countryName) VALUES (N'Brunei Darussalam');
INSERT INTO Country (countryName) VALUES (N'Bulgaria');
INSERT INTO Country (countryName) VALUES (N'Burkina Faso');
INSERT INTO Country (countryName) VALUES (N'Burundi');
INSERT INTO Country (countryName) VALUES (N'Cambodia');
INSERT INTO Country (countryName) VALUES (N'Cameroon');
INSERT INTO Country (countryName) VALUES (N'Canada');
INSERT INTO Country (countryName) VALUES (N'Cape Verde');
INSERT INTO Country (countryName) VALUES (N'Cayman Islands');
INSERT INTO Country (countryName) VALUES (N'Central African Republic');
INSERT INTO Country (countryName) VALUES (N'Chad');
INSERT INTO Country (countryName) VALUES (N'Chile');
INSERT INTO Country (countryName) VALUES (N'China');
INSERT INTO Country (countryName) VALUES (N'Christmas Island');
INSERT INTO Country (countryName) VALUES (N'Cocos (Keeling) Islands');
INSERT INTO Country (countryName) VALUES (N'Colombia');
INSERT INTO Country (countryName) VALUES (N'Comoros');
INSERT INTO Country (countryName) VALUES (N'Congo');
INSERT INTO Country (countryName) VALUES (N'Congo, the Democratic Republic of the');
INSERT INTO Country (countryName) VALUES (N'Cook Islands');
INSERT INTO Country (countryName) VALUES (N'Costa Rica');
INSERT INTO Country (countryName) VALUES (N'Cote d''Ivoire');
INSERT INTO Country (countryName) VALUES (N'Croatia');
INSERT INTO Country (countryName) VALUES (N'Cuba');
INSERT INTO Country (countryName) VALUES (N'Cyprus');
INSERT INTO Country (countryName) VALUES (N'Czech Republic');
INSERT INTO Country (countryName) VALUES (N'Denmark');
INSERT INTO Country (countryName) VALUES (N'Djibouti');
INSERT INTO Country (countryName) VALUES (N'Dominica');
INSERT INTO Country (countryName) VALUES (N'Dominican Republic');
INSERT INTO Country (countryName) VALUES (N'East Timor');
INSERT INTO Country (countryName) VALUES (N'Ecuador');
INSERT INTO Country (countryName) VALUES (N'Egypt');
INSERT INTO Country (countryName) VALUES (N'El Salvador');
INSERT INTO Country (countryName) VALUES (N'Equatorial Guinea');
INSERT INTO Country (countryName) VALUES (N'Eritrea');
INSERT INTO Country (countryName) VALUES (N'Estonia');
INSERT INTO Country (countryName) VALUES (N'Ethiopia');
INSERT INTO Country (countryName) VALUES (N'Falkland Islands (Malvinas)');
INSERT INTO Country (countryName) VALUES (N'Faroe Islands');
INSERT INTO Country (countryName) VALUES (N'Fiji');
INSERT INTO Country (countryName) VALUES (N'Finland');
INSERT INTO Country (countryName) VALUES (N'France');
INSERT INTO Country (countryName) VALUES (N'France, Metropolitan');
INSERT INTO Country (countryName) VALUES (N'French Guiana');
INSERT INTO Country (countryName) VALUES (N'French Polynesia');
INSERT INTO Country (countryName) VALUES (N'French Southern Territories');
INSERT INTO Country (countryName) VALUES (N'Gabon');
INSERT INTO Country (countryName) VALUES (N'Gambia');
INSERT INTO Country (countryName) VALUES (N'Georgia');
INSERT INTO Country (countryName) VALUES (N'Germany');
INSERT INTO Country (countryName) VALUES (N'Ghana');
INSERT INTO Country (countryName) VALUES (N'Gibraltar');
INSERT INTO Country (countryName) VALUES (N'Greece');
INSERT INTO Country (countryName) VALUES (N'Greenland');
INSERT INTO Country (countryName) VALUES (N'Grenada');
INSERT INTO Country (countryName) VALUES (N'Guadeloupe');
INSERT INTO Country (countryName) VALUES (N'Guam');
INSERT INTO Country (countryName) VALUES (N'Guatemala');
INSERT INTO Country (countryName) VALUES (N'Guinea');
INSERT INTO Country (countryName) VALUES (N'Guinea-Bissau');
INSERT INTO Country (countryName) VALUES (N'Guyana');
INSERT INTO Country (countryName) VALUES (N'Haiti');
INSERT INTO Country (countryName) VALUES (N'Heard and Mc Donald Islands');
INSERT INTO Country (countryName) VALUES (N'Holy See (Vatican City State)');
INSERT INTO Country (countryName) VALUES (N'Honduras');
INSERT INTO Country (countryName) VALUES (N'Hong Kong');
INSERT INTO Country (countryName) VALUES (N'Hungary');
INSERT INTO Country (countryName) VALUES (N'Iceland');
INSERT INTO Country (countryName) VALUES (N'India');
INSERT INTO Country (countryName) VALUES (N'Indonesia');
INSERT INTO Country (countryName) VALUES (N'Iran (Islamic Republic of)');
INSERT INTO Country (countryName) VALUES (N'Iraq');
INSERT INTO Country (countryName) VALUES (N'Ireland');
INSERT INTO Country (countryName) VALUES (N'Israel');
INSERT INTO Country (countryName) VALUES (N'Italy');
INSERT INTO Country (countryName) VALUES (N'Jamaica');
INSERT INTO Country (countryName) VALUES (N'Japan');
INSERT INTO Country (countryName) VALUES (N'Jordan');
INSERT INTO Country (countryName) VALUES (N'Kazakhstan');
INSERT INTO Country (countryName) VALUES (N'Kenya');
INSERT INTO Country (countryName) VALUES (N'Kiribati');
INSERT INTO Country (countryName) VALUES (N'Korea, Democratic People''s Republic of');
INSERT INTO Country (countryName) VALUES (N'Korea, Republic of');
INSERT INTO Country (countryName) VALUES (N'Kuwait');
INSERT INTO Country (countryName) VALUES (N'Kyrgyzstan');
INSERT INTO Country (countryName) VALUES (N'Lao People''s Democratic Republic');
INSERT INTO Country (countryName) VALUES (N'Latvia');
INSERT INTO Country (countryName) VALUES (N'Lebanon');
INSERT INTO Country (countryName) VALUES (N'Lesotho');
INSERT INTO Country (countryName) VALUES (N'Liberia');
INSERT INTO Country (countryName) VALUES (N'Libyan Arab Jamahiriya');
INSERT INTO Country (countryName) VALUES (N'Liechtenstein');
INSERT INTO Country (countryName) VALUES (N'Lithuania');
INSERT INTO Country (countryName) VALUES (N'Luxembourg');
INSERT INTO Country (countryName) VALUES (N'Macau');
INSERT INTO Country (countryName) VALUES (N'Macedonia, The Former Yugoslav Republic of');
INSERT INTO Country (countryName) VALUES (N'Madagascar');
INSERT INTO Country (countryName) VALUES (N'Malawi');
INSERT INTO Country (countryName) VALUES (N'Malaysia');
INSERT INTO Country (countryName) VALUES (N'Maldives');
INSERT INTO Country (countryName) VALUES (N'Mali');
INSERT INTO Country (countryName) VALUES (N'Malta');
INSERT INTO Country (countryName) VALUES (N'Marshall Islands');
INSERT INTO Country (countryName) VALUES (N'Martinique');
INSERT INTO Country (countryName) VALUES (N'Mauritania');
INSERT INTO Country (countryName) VALUES (N'Mauritius');
INSERT INTO Country (countryName) VALUES (N'Mayotte');
INSERT INTO Country (countryName) VALUES (N'Mexico');
INSERT INTO Country (countryName) VALUES (N'Micronesia, Federated States of');
INSERT INTO Country (countryName) VALUES (N'Moldova, Republic of');
INSERT INTO Country (countryName) VALUES (N'Monaco');
INSERT INTO Country (countryName) VALUES (N'Mongolia');
INSERT INTO Country (countryName) VALUES (N'Montserrat');
INSERT INTO Country (countryName) VALUES (N'Morocco');
INSERT INTO Country (countryName) VALUES (N'Mozambique');
INSERT INTO Country (countryName) VALUES (N'Myanmar');
INSERT INTO Country (countryName) VALUES (N'Namibia');
INSERT INTO Country (countryName) VALUES (N'Nauru');
INSERT INTO Country (countryName) VALUES (N'Nepal');
INSERT INTO Country (countryName) VALUES (N'Netherlands');
INSERT INTO Country (countryName) VALUES (N'Netherlands Antilles');
INSERT INTO Country (countryName) VALUES (N'New Caledonia');
INSERT INTO Country (countryName) VALUES (N'New Zealand');
INSERT INTO Country (countryName) VALUES (N'Nicaragua');
INSERT INTO Country (countryName) VALUES (N'Niger');
INSERT INTO Country (countryName) VALUES (N'Nigeria');
INSERT INTO Country (countryName) VALUES (N'Niue');
INSERT INTO Country (countryName) VALUES (N'Norfolk Island');
INSERT INTO Country (countryName) VALUES (N'Northern Mariana Islands');
INSERT INTO Country (countryName) VALUES (N'Norway');
INSERT INTO Country (countryName) VALUES (N'Oman');
INSERT INTO Country (countryName) VALUES (N'Pakistan');
INSERT INTO Country (countryName) VALUES (N'Palau');
INSERT INTO Country (countryName) VALUES (N'Panama');
INSERT INTO Country (countryName) VALUES (N'Papua New Guinea');
INSERT INTO Country (countryName) VALUES (N'Paraguay');
INSERT INTO Country (countryName) VALUES (N'Peru');
INSERT INTO Country (countryName) VALUES (N'Philippines');
INSERT INTO Country (countryName) VALUES (N'Pitcairn');
INSERT INTO Country (countryName) VALUES (N'Poland');
INSERT INTO Country (countryName) VALUES (N'Portugal');
INSERT INTO Country (countryName) VALUES (N'Puerto Rico');
INSERT INTO Country (countryName) VALUES (N'Qatar');
INSERT INTO Country (countryName) VALUES (N'Reunion');
INSERT INTO Country (countryName) VALUES (N'Romania');
INSERT INTO Country (countryName) VALUES (N'Russian Federation');
INSERT INTO Country (countryName) VALUES (N'Rwanda');
INSERT INTO Country (countryName) VALUES (N'Saint Kitts and Nevis');
INSERT INTO Country (countryName) VALUES (N'Saint Lucia');
INSERT INTO Country (countryName) VALUES (N'Saint Vincent and the Grenadines');
INSERT INTO Country (countryName) VALUES (N'Samoa');
INSERT INTO Country (countryName) VALUES (N'San Marino');
INSERT INTO Country (countryName) VALUES (N'Sao Tome and Principe');
INSERT INTO Country (countryName) VALUES (N'Saudi Arabia');
INSERT INTO Country (countryName) VALUES (N'Senegal');
INSERT INTO Country (countryName) VALUES (N'Seychelles');
INSERT INTO Country (countryName) VALUES (N'Sierra Leone');
INSERT INTO Country (countryName) VALUES (N'Singapore');
INSERT INTO Country (countryName) VALUES (N'Slovakia (Slovak Republic)');
INSERT INTO Country (countryName) VALUES (N'Slovenia');
INSERT INTO Country (countryName) VALUES (N'Solomon Islands');
INSERT INTO Country (countryName) VALUES (N'Somalia');
INSERT INTO Country (countryName) VALUES (N'South Africa');
INSERT INTO Country (countryName) VALUES (N'South Georgia and the South Sandwich Islands');
INSERT INTO Country (countryName) VALUES (N'Spain');
INSERT INTO Country (countryName) VALUES (N'Sri Lanka');
INSERT INTO Country (countryName) VALUES (N'St. Helena');
INSERT INTO Country (countryName) VALUES (N'St. Pierre and Miquelon');
INSERT INTO Country (countryName) VALUES (N'Sudan');
INSERT INTO Country (countryName) VALUES (N'Suriname');
INSERT INTO Country (countryName) VALUES (N'Svalbard and Jan Mayen Islands');
INSERT INTO Country (countryName) VALUES (N'Swaziland');
INSERT INTO Country (countryName) VALUES (N'Sweden');
INSERT INTO Country (countryName) VALUES (N'Switzerland');
INSERT INTO Country (countryName) VALUES (N'Syrian Arab Republic');
INSERT INTO Country (countryName) VALUES (N'Taiwan, Province of China');
INSERT INTO Country (countryName) VALUES (N'Tajikistan');
INSERT INTO Country (countryName) VALUES (N'Tanzania, United Republic of');
INSERT INTO Country (countryName) VALUES (N'Thailand');
INSERT INTO Country (countryName) VALUES (N'Togo');
INSERT INTO Country (countryName) VALUES (N'Tokelau');
INSERT INTO Country (countryName) VALUES (N'Tonga');
INSERT INTO Country (countryName) VALUES (N'Trinidad and Tobago');
INSERT INTO Country (countryName) VALUES (N'Tunisia');
INSERT INTO Country (countryName) VALUES (N'Turkey');
INSERT INTO Country (countryName) VALUES (N'Turkmenistan');
INSERT INTO Country (countryName) VALUES (N'Turks and Caicos Islands');
INSERT INTO Country (countryName) VALUES (N'Tuvalu');
INSERT INTO Country (countryName) VALUES (N'Uganda');
INSERT INTO Country (countryName) VALUES (N'Ukraine');
INSERT INTO Country (countryName) VALUES (N'United Arab Emirates');
INSERT INTO Country (countryName) VALUES (N'United Kingdom');
INSERT INTO Country (countryName) VALUES (N'United States Minor Outlying Islands');
INSERT INTO Country (countryName) VALUES (N'Uruguay');
INSERT INTO Country (countryName) VALUES (N'Uzbekistan');
INSERT INTO Country (countryName) VALUES (N'Vanuatu');
INSERT INTO Country (countryName) VALUES (N'Venezuela');
INSERT INTO Country (countryName) VALUES (N'Viet Nam');
INSERT INTO Country (countryName) VALUES (N'Virgin Islands (British)');
INSERT INTO Country (countryName) VALUES (N'Virgin Islands (U.S.)');
INSERT INTO Country (countryName) VALUES (N'Wallis and Futuna Islands');
INSERT INTO Country (countryName) VALUES (N'Western Sahara');
INSERT INTO Country (countryName) VALUES (N'Yemen');
INSERT INTO Country (countryName) VALUES (N'Serbia');
INSERT INTO Country (countryName) VALUES (N'Zambia');
INSERT INTO Country (countryName) VALUES (N'Zimbabwe');

INSERT INTO Account (username, password, email, phoneNumber, gender, address, roleId, accountStatusId) VALUES ('Admin', '123', 'mosddm2003@gmail.com', NULL, NULL, NULL, 1, 1)

Select * From Match
Select * From Seat
select * from Account

insert into Seat (seatNumber, row, price, areaId, seatStatusId)
VALUES (1, 1, 21, 111, 1),
       (2, 1, 21, 111, 1),
       (3, 1, 21, 111, 1),
       (4, 1, 21, 111, 1),
       (5, 1, 21, 111, 1),
       (6, 1, 21, 111, 1),
       (7, 1, 21, 111, 1),
       (8, 1, 21, 111, 1),
       (9, 1, 21, 111, 1),
       (10, 1, 21, 111, 1),
       (11, 1, 21, 111, 1),
       (12, 1, 21, 111, 1),
       (13, 1, 21, 111, 1),
       (14, 1, 21, 111, 1),
       (15, 1, 21, 111, 1),
       (16, 1, 21, 111, 1),
       (17, 1, 21, 111, 1),
       (18, 1, 21, 111, 1),
       (19, 1, 21, 111, 1),
       (20, 1, 21, 111, 1),
       (21, 1, 21, 111, 1),
       (22, 1, 21, 111, 1),
       (23, 1, 21, 111, 1),
       (24, 1, 21, 111, 1),
       (1, 2, 22, 111, 1),
       (2, 2, 22, 111, 1),
       (3, 2, 22, 111, 1),
       (4, 2, 22, 111, 1),
       (5, 2, 22, 111, 1),
       (6, 2, 22, 111, 1),
       (7, 2, 22, 111, 1),
       (8, 2, 22, 111, 1),
       (9, 2, 22, 111, 1),
       (10, 2, 22, 111, 1),
       (11, 2, 22, 111, 1),
       (12, 2, 22, 111, 1),
       (13, 2, 22, 111, 1),
       (14, 2, 22, 111, 1),
       (15, 2, 22, 111, 1),
       (16, 2, 22, 111, 1),
       (17, 2, 22, 111, 1),
       (18, 2, 22, 111, 1),
       (19, 2, 22, 111, 1),
       (20, 2, 22, 111, 1),
       (21, 2, 22, 111, 1),
       (22, 2, 22, 111, 1),
       (23, 2, 22, 111, 1),
       (24, 2, 22, 111, 1),
       (1, 3, 23, 111, 1),
       (2, 3, 23, 111, 1),
       (3, 3, 23, 111, 1),
       (4, 3, 23, 111, 1),
       (5, 3, 23, 111, 1),
       (6, 3, 23, 111, 1),
       (7, 3, 23, 111, 1),
       (8, 3, 23, 111, 1),
       (9, 3, 23, 111, 1),
       (10, 3, 23, 111, 1),
       (11, 3, 23, 111, 1),
       (12, 3, 23, 111, 1),
       (13, 3, 23, 111, 1),
       (14, 3, 23, 111, 1),
       (15, 3, 23, 111, 1),
       (16, 3, 23, 111, 1),
       (17, 3, 23, 111, 1),
       (18, 3, 23, 111, 1),
       (19, 3, 23, 111, 1),
       (20, 3, 23, 111, 1),
       (21, 3, 23, 111, 1),
       (22, 3, 23, 111, 1),
       (23, 3, 23, 111, 1),
       (24, 3, 23, 111, 1),
       (1, 4, 24, 111, 1),
       (2, 4, 24, 111, 1),
       (3, 4, 24, 111, 1),
       (4, 4, 24, 111, 1),
       (5, 4, 24, 111, 1),
       (6, 4, 24, 111, 1),
       (7, 4, 24, 111, 1),
       (8, 4, 24, 111, 1),
       (9, 4, 24, 111, 1),
       (10, 4, 24, 111, 1),
       (11, 4, 24, 111, 1),
       (12, 4, 24, 111, 1),
       (13, 4, 24, 111, 1),
       (14, 4, 24, 111, 1),
       (15, 4, 24, 111, 1),
       (16, 4, 24, 111, 1),
       (17, 4, 24, 111, 1),
       (18, 4, 24, 111, 1),
       (19, 4, 24, 111, 1),
       (20, 4, 24, 111, 1),
       (21, 4, 24, 111, 1),
       (22, 4, 24, 111, 1),
       (23, 4, 24, 111, 1),
       (24, 4, 24, 111, 1),
       (1, 5, 25, 111, 1),
       (2, 5, 25, 111, 1),
       (3, 5, 25, 111, 1),
       (4, 5, 25, 111, 1),
       (5, 5, 25, 111, 1),
       (6, 5, 25, 111, 1),
       (7, 5, 25, 111, 1),
       (8, 5, 25, 111, 1),
       (9, 5, 25, 111, 1),
       (10, 5, 25, 111, 1),
       (11, 5, 25, 111, 1),
       (12, 5, 25, 111, 1),
       (13, 5, 25, 111, 1),
       (14, 5, 25, 111, 1),
       (15, 5, 25, 111, 1),
       (16, 5, 25, 111, 1),
       (17, 5, 25, 111, 1),
       (18, 5, 25, 111, 1),
       (19, 5, 25, 111, 1),
       (20, 5, 25, 111, 1),
       (21, 5, 25, 111, 1),
       (22, 5, 25, 111, 1),
       (23, 5, 25, 111, 1),
       (24, 5, 25, 111, 1),
       (1, 6, 26, 111, 1),
       (2, 6, 26, 111, 1),
       (3, 6, 26, 111, 1),
       (4, 6, 26, 111, 1),
       (5, 6, 26, 111, 1),
       (6, 6, 26, 111, 1),
       (7, 6, 26, 111, 1),
       (8, 6, 26, 111, 1),
       (9, 6, 26, 111, 1),
       (10, 6, 26, 111, 1),
       (11, 6, 26, 111, 1),
       (12, 6, 26, 111, 1),
       (13, 6, 26, 111, 1),
       (14, 6, 26, 111, 1),
       (15, 6, 26, 111, 1),
       (16, 6, 26, 111, 1),
       (17, 6, 26, 111, 1),
       (18, 6, 26, 111, 1),
       (19, 6, 26, 111, 1),
       (20, 6, 26, 111, 1),
       (21, 6, 26, 111, 1),
       (22, 6, 26, 111, 1),
       (23, 6, 26, 111, 1),
       (24, 6, 26, 111, 1),
       (1, 7, 27, 111, 1),
       (2, 7, 27, 111, 1),
       (3, 7, 27, 111, 1),
       (4, 7, 27, 111, 1),
       (5, 7, 27, 111, 1),
       (6, 7, 27, 111, 1),
       (7, 7, 27, 111, 1),
       (8, 7, 27, 111, 1),
       (9, 7, 27, 111, 1),
       (10, 7, 27, 111, 1),
       (11, 7, 27, 111, 1),
       (12, 7, 27, 111, 1),
       (13, 7, 27, 111, 1),
       (14, 7, 27, 111, 1),
       (15, 7, 27, 111, 1),
       (16, 7, 27, 111, 1),
       (17, 7, 27, 111, 1),
       (18, 7, 27, 111, 1),
       (19, 7, 27, 111, 1),
       (20, 7, 27, 111, 1),
       (21, 7, 27, 111, 1),
       (22, 7, 27, 111, 1),
       (23, 7, 27, 111, 1),
       (24, 7, 27, 111, 1),
       (1, 8, 28, 111, 1),
       (2, 8, 28, 111, 1),
       (3, 8, 28, 111, 1),
       (4, 8, 28, 111, 1),
       (5, 8, 28, 111, 1),
       (6, 8, 28, 111, 1),
       (7, 8, 28, 111, 1),
       (8, 8, 28, 111, 1),
       (9, 8, 28, 111, 1),
       (10, 8, 28, 111, 1),
       (11, 8, 28, 111, 1),
       (12, 8, 28, 111, 1),
       (13, 8, 28, 111, 1),
       (14, 8, 28, 111, 1),
       (15, 8, 28, 111, 1),
       (16, 8, 28, 111, 1),
       (17, 8, 28, 111, 1),
       (18, 8, 28, 111, 1),
       (19, 8, 28, 111, 1),
       (20, 8, 28, 111, 1),
       (21, 8, 28, 111, 1),
       (22, 8, 28, 111, 1),
       (23, 8, 28, 111, 1),
       (24, 8, 28, 111, 1),
       (1, 9, 29, 111, 1),
       (2, 9, 29, 111, 1),
       (3, 9, 29, 111, 1),
       (4, 9, 29, 111, 1),
       (5, 9, 29, 111, 1),
       (6, 9, 29, 111, 1),
       (7, 9, 29, 111, 1),
       (8, 9, 29, 111, 1),
       (9, 9, 29, 111, 1),
       (10, 9, 29, 111, 1),
       (11, 9, 29, 111, 1),
       (12, 9, 29, 111, 1),
       (13, 9, 29, 111, 1),
       (14, 9, 29, 111, 1),
       (15, 9, 29, 111, 1),
       (16, 9, 29, 111, 1),
       (17, 9, 29, 111, 1),
       (18, 9, 29, 111, 1),
       (19, 9, 29, 111, 1),
       (20, 9, 29, 111, 1),
       (21, 9, 29, 111, 1),
       (22, 9, 29, 111, 1),
       (23, 9, 29, 111, 1),
       (24, 9, 29, 111, 1),
       (1, 10, 30, 111, 1),
       (2, 10, 30, 111, 1),
       (3, 10, 30, 111, 1),
       (4, 10, 30, 111, 1),
       (5, 10, 30, 111, 1),
       (6, 10, 30, 111, 1),
       (7, 10, 30, 111, 1),
       (8, 10, 30, 111, 1),
       (9, 10, 30, 111, 1),
       (10, 10, 30, 111, 1),
       (11, 10, 30, 111, 1),
       (12, 10, 30, 111, 1),
       (13, 10, 30, 111, 1),
       (14, 10, 30, 111, 1),
       (15, 10, 30, 111, 1),
       (16, 10, 30, 111, 1),
       (17, 10, 30, 111, 1),
       (18, 10, 30, 111, 1),
       (19, 10, 30, 111, 1),
       (20, 10, 30, 111, 1),
       (21, 10, 30, 111, 1),
       (22, 10, 30, 111, 1),
       (23, 10, 30, 111, 1),
       (24, 10, 30, 111, 1),
       (1, 11, 31, 111, 1),
       (2, 11, 31, 111, 1),
       (3, 11, 31, 111, 1),
       (4, 11, 31, 111, 1),
       (5, 11, 31, 111, 1),
       (6, 11, 31, 111, 1),
       (7, 11, 31, 111, 1),
       (8, 11, 31, 111, 1),
       (9, 11, 31, 111, 1),
       (10, 11, 31, 111, 1),
       (11, 11, 31, 111, 1),
       (12, 11, 31, 111, 1),
       (13, 11, 31, 111, 1),
       (14, 11, 31, 111, 1),
       (15, 11, 31, 111, 1),
       (16, 11, 31, 111, 1),
       (17, 11, 31, 111, 1),
       (18, 11, 31, 111, 1),
       (19, 11, 31, 111, 1),
       (20, 11, 31, 111, 1),
       (21, 11, 31, 111, 1),
       (22, 11, 31, 111, 1),
       (23, 11, 31, 111, 1),
       (24, 11, 31, 111, 1),
       (1, 12, 32, 111, 1),
       (2, 12, 32, 111, 1),
       (3, 12, 32, 111, 1),
       (4, 12, 32, 111, 1),
       (5, 12, 32, 111, 1),
       (6, 12, 32, 111, 1),
       (7, 12, 32, 111, 1),
       (8, 12, 32, 111, 1),
       (9, 12, 32, 111, 1),
       (10, 12, 32, 111, 1),
       (11, 12, 32, 111, 1),
       (12, 12, 32, 111, 1),
       (13, 12, 32, 111, 1),
       (14, 12, 32, 111, 1),
       (15, 12, 32, 111, 1),
       (16, 12, 32, 111, 1),
       (17, 12, 32, 111, 1),
       (18, 12, 32, 111, 1),
       (19, 12, 32, 111, 1),
       (20, 12, 32, 111, 1),
       (21, 12, 32, 111, 1),
       (22, 12, 32, 111, 1),
       (23, 12, 32, 111, 1),
       (24, 12, 32, 111, 1)

insert into Seat (seatNumber, row, price, areaId, seatStatusId)
VALUES (1, 1, 21, 112, 1),
       (2, 1, 21, 112, 1),
       (3, 1, 21, 112, 1),
       (4, 1, 21, 112, 1),
       (5, 1, 21, 112, 1),
       (6, 1, 21, 112, 1),
       (7, 1, 21, 112, 1),
       (8, 1, 21, 112, 1),
       (9, 1, 21, 112, 1),
       (10, 1, 21, 112, 1),
       (11, 1, 21, 112, 1),
       (12, 1, 21, 112, 1),
       (13, 1, 21, 112, 1),
       (14, 1, 21, 112, 1),
       (15, 1, 21, 112, 1),
       (16, 1, 21, 112, 1),
       (17, 1, 21, 112, 1),
       (18, 1, 21, 112, 1),
       (19, 1, 21, 112, 1),
       (20, 1, 21, 112, 1),
       (21, 1, 21, 112, 1),
       (22, 1, 21, 112, 1),
       (23, 1, 21, 112, 1),
       (24, 1, 21, 112, 1),
       (1, 2, 22, 112, 1),
       (2, 2, 22, 112, 1),
       (3, 2, 22, 112, 1),
       (4, 2, 22, 112, 1),
         (5, 2, 22, 112, 1),
         (6, 2, 22, 112, 1),
         (7, 2, 22, 112, 1),
         (8, 2, 22, 112, 1),
         (9, 2, 22, 112, 1),
         (10, 2, 22, 112, 1),
         (11, 2, 22, 112, 1),
         (12, 2, 22, 112, 1),
         (13, 2, 22, 112, 1),
         (14, 2, 22, 112, 1),
         (15, 2, 22, 112, 1),
         (16, 2, 22, 112, 1),
         (17, 2, 22, 112, 1),
         (18, 2, 22, 112, 1),
         (19, 2, 22, 112, 1),
         (20, 2, 22, 112, 1),
         (21, 2, 22, 112, 1),
         (22, 2, 22, 112, 1),
         (23, 2, 22, 112, 1),
         (24, 2, 22, 112, 1),
         (1, 3, 23, 112, 1),
         (2, 3, 23, 112, 1),
         (3, 3, 23, 112, 1),
         (4, 3, 23, 112, 1),
         (5, 3, 23, 112, 1),
         (6, 3, 23, 112, 1),
         (7, 3, 23, 112, 1),
         (8, 3, 23, 112, 1),
         (9, 3, 23, 112, 1),
         (10, 3, 23, 112, 1),
         (11, 3, 23, 112, 1),
         (12, 3, 23, 112, 1),
            (13, 3, 23, 112, 1),
            (14, 3, 23, 112, 1),
            (15, 3, 23, 112, 1),
            (16, 3, 23, 112, 1),
            (17, 3, 23, 112, 1),
            (18, 3, 23, 112, 1),
            (19, 3, 23, 112, 1),
            (20, 3, 23, 112, 1),
            (21, 3, 23, 112, 1),
            (22, 3, 23, 112, 1),
            (23, 3, 23, 112, 1),
            (24, 3, 23, 112, 1),
            (1, 4, 24, 112, 1),
            (2, 4, 24, 112, 1),
            (3, 4, 24, 112, 1),
            (4, 4, 24, 112, 1),
            (5, 4, 24, 112, 1),
            (6, 4, 24, 112, 1),
            (7, 4, 24, 112, 1),
            (8, 4, 24, 112, 1),
            (9, 4, 24, 112, 1),
            (10, 4, 24, 112, 1),
            (11, 4, 24, 112, 1),
            (12, 4, 24, 112, 1),
            (13, 4, 24, 112, 1),
            (14, 4, 24, 112, 1),
            (15, 4, 24, 112, 1),
            (16, 4, 24, 112, 1),
            (17, 4, 24, 112, 1),
            (18, 4, 24, 112, 1),
            (19, 4, 24, 112, 1),
            (20, 4, 24, 112, 1),
            (21, 4, 24, 112, 1),
            (22, 4, 24, 112, 1),
            (23, 4, 24, 112, 1),
            (24, 4, 24, 112, 1),
            (1, 5, 25, 112, 1),
            (2, 5, 25, 112, 1),
            (3, 5, 25, 112, 1),
            (4, 5, 25, 112, 1),
            (5, 5, 25, 112, 1),
            (6, 5, 25, 112, 1),
            (7, 5, 25, 112, 1),
            (8, 5, 25, 112, 1),
            (9, 5, 25, 112, 1),
            (10, 5, 25, 112, 1),
            (11, 5, 25, 112, 1),
            (12, 5, 25, 112, 1),
            (13, 5, 25, 112, 1),
            (14, 5, 25, 112, 1),
            (15, 5, 25, 112, 1),
            (16, 5, 25, 112, 1),
            (17, 5, 25, 112, 1),
            (18, 5, 25, 112, 1),
            (19, 5, 25, 112, 1),
            (20, 5, 25, 112, 1),
            (21, 5, 25, 112, 1),
            (22, 5, 25, 112, 1),
            (23, 5, 25, 112, 1),
            (24, 5, 25, 112, 1),
            (1, 6, 26, 112, 1),
            (2, 6, 26, 112, 1),
            (3, 6, 26, 112, 1),
            (4, 6, 26, 112, 1),
            (5, 6, 26, 112, 1),
            (6, 6, 26, 112, 1),
            (7, 6, 26, 112, 1),
            (8, 6, 26, 112, 1),
            (9, 6, 26, 112, 1),
            (10, 6, 26, 112, 1),
            (11, 6, 26, 112, 1),
            (12, 6, 26, 112, 1),
            (13, 6, 26, 112, 1),
            (14, 6, 26, 112, 1),
            (15, 6, 26, 112, 1),
            (16, 6, 26, 112, 1),
            (17, 6, 26, 112, 1),
            (18, 6, 26, 112, 1),
            (19, 6, 26, 112, 1),
            (20, 6, 26, 112, 1),
            (21, 6, 26, 112, 1),
            (22, 6, 26, 112, 1),
            (23, 6, 26, 112, 1),
            (24, 6, 26, 112, 1),
            (1, 7, 27, 112, 1),
            (2, 7, 27, 112, 1),
            (3, 7, 27, 112, 1),
            (4, 7, 27, 112, 1),
            (5, 7, 27, 112, 1),
            (6, 7, 27, 112, 1),
            (7, 7, 27, 112, 1),
            (8, 7, 27, 112, 1),
            (9, 7, 27, 112, 1),
            (10, 7, 27, 112, 1),
            (11, 7, 27, 112, 1),
            (12, 7, 27, 112, 1),
            (13, 7, 27, 112, 1),
            (14, 7, 27, 112, 1),
            (15, 7, 27, 112, 1),
            (16, 7, 27, 112, 1),
            (17, 7, 27, 112, 1),
            (18, 7, 27, 112, 1),
            (19, 7, 27, 112, 1),
            (20, 7, 27, 112, 1),
            (21, 7, 27, 112, 1),
            (22, 7, 27, 112, 1),
            (23, 7, 27, 112, 1),
            (24, 7, 27, 112, 1),
            (1, 8, 28, 112, 1),
            (2, 8, 28, 112, 1),
            (3, 8, 28, 112, 1),
            (4, 8, 28, 112, 1),
            (5, 8, 28, 112, 1),
            (6, 8, 28, 112, 1),
            (7, 8, 28, 112, 1),
            (8, 8, 28, 112, 1),
            (9, 8, 28, 112, 1),
            (10, 8, 28, 112, 1),
            (11, 8, 28, 112, 1),
            (12, 8, 28, 112, 1),
            (13, 8, 28, 112, 1),
            (14, 8, 28, 112, 1),
            (15, 8, 28, 112, 1),
            (16, 8, 28, 112, 1),
            (17, 8, 28, 112, 1),
            (18, 8, 28, 112, 1),
            (19, 8, 28, 112, 1),
            (20, 8, 28, 112, 1),
            (21, 8, 28, 112, 1),
            (22, 8, 28, 112, 1),
            (23, 8, 28, 112, 1),
            (24, 8, 28, 112, 1),
            (1, 9, 29, 112, 1),
            (2, 9, 29, 112, 1),
            (3, 9, 29, 112, 1),
            (4, 9, 29, 112, 1),
            (5, 9, 29, 112, 1),
            (6, 9, 29, 112, 1),
            (7, 9, 29, 112, 1),
            (8, 9, 29, 112, 1),
            (9, 9, 29, 112, 1),
            (10, 9, 29, 112, 1),
            (11, 9, 29, 112, 1),
            (12, 9, 29, 112, 1),
            (13, 9, 29, 112, 1),
            (14, 9, 29, 112, 1),
            (15, 9, 29, 112, 1),
            (16, 9, 29, 112, 1),
            (17, 9, 29, 112, 1),
            (18, 9, 29, 112, 1),
            (19, 9, 29, 112, 1),
            (20, 9, 29, 112, 1),
            (21, 9, 29, 112, 1),
            (22, 9, 29, 112, 1),
            (23, 9, 29, 112, 1),
            (24, 9, 29, 112, 1),
            (1, 10, 30, 112, 1),
            (2, 10, 30, 112, 1),
            (3, 10, 30, 112, 1),
            (4, 10, 30, 112, 1),
            (5, 10, 30, 112, 1),
            (6, 10, 30, 112, 1),
            (7, 10, 30, 112, 1),
            (8, 10, 30, 112, 1),
            (9, 10, 30, 112, 1),
            (10, 10, 30, 112, 1),
            (11, 10, 30, 112, 1),
            (12, 10, 30, 112, 1),
            (13, 10, 30, 112, 1),
            (14, 10, 30, 112, 1),
            (15, 10, 30, 112, 1),
            (16, 10, 30, 112, 1),
            (17, 10, 30, 112, 1),
            (18, 10, 30, 112, 1),
            (19, 10, 30, 112, 1),
            (20, 10, 30, 112, 1),
            (21, 10, 30, 112, 1),
            (22, 10, 30, 112, 1),
            (23, 10, 30, 112, 1),
            (24, 10, 30, 112, 1),
            (1, 11, 31, 112, 1),
            (2, 11, 31, 112, 1),
            (3, 11, 31, 112, 1),
            (4, 11, 31, 112, 1),
            (5, 11, 31, 112, 1),
            (6, 11, 31, 112, 1),
            (7, 11, 31, 112, 1),
            (8, 11, 31, 112, 1),
            (9, 11, 31, 112, 1),
            (10, 11, 31, 112, 1),
            (11, 11, 31, 112, 1),
            (12, 11, 31,112, 1),
            (13, 11, 31, 112, 1),
            (14, 11, 31, 112, 1),
            (15, 11, 31, 112, 1),
            (16, 11, 31, 112, 1),
            (17, 11, 31, 112, 1),
            (18, 11, 31, 112, 1),
            (19, 11, 31, 112, 1),
            (20, 11, 31, 112, 1),
            (21, 11, 31, 112, 1),
            (22, 11, 31, 112, 1),
            (23, 11, 31, 112, 1),
            (24, 11, 31, 112, 1),
            (1, 12, 32, 112, 1),
            (2, 12, 32, 112, 1),
            (3, 12, 32, 112, 1),
            (4, 12, 32, 112, 1),
            (5, 12, 32, 112, 1),
            (6, 12, 32, 112, 1),
            (7, 12, 32, 112, 1),
            (8, 12, 32, 112, 1),
            (9, 12, 32, 112, 1),
            (10, 12, 32, 112, 1),
            (11, 12, 32, 112, 1),
            (12, 12, 32, 112, 1),
            (13, 12, 32, 112, 1),
            (14, 12, 32, 112, 1),
            (15, 12, 32, 112, 1),
            (16, 12, 32, 112, 1),
            (17, 12, 32, 112, 1),
            (18, 12, 32, 112, 1),
            (19, 12, 32, 112, 1),
            (20, 12, 32, 112, 1),
            (21, 12, 32, 112, 1),
            (22, 12, 32, 112, 1),
            (23, 12, 32, 112, 1),
            (24, 12, 32, 112, 1)

insert into Seat (seatNumber, row, price, areaId, seatStatusId)
VAlUES (1, 1, 19, 121, 1),
       (2, 1, 19, 121, 1),
         (3, 1, 19, 121, 1),
         (4, 1, 19, 121, 1),
         (5, 1, 19, 121, 1),
         (6, 1, 19, 121, 1),
         (7, 1, 19, 121, 1),
         (8, 1, 19, 121, 1),
         (9, 1, 19, 121, 1),
         (10, 1, 19, 121, 1),
         (11, 1, 19, 121, 1),
         (12, 1, 19, 121, 1),
         (13, 1, 19, 121, 1),
         (14, 1, 19, 121, 1),
         (15, 1, 19, 121, 1),
         (16, 1, 19, 121, 1),
         (17, 1, 19, 121, 1),
         (18, 1, 19, 121, 1),
         (19, 1, 19, 121, 1),
         (20, 1, 19, 121, 1),
         (21, 1, 19, 121, 1),
         (22, 1, 19, 121, 1),
         (23, 1, 19, 121, 1),
         (24, 1, 19, 121, 1),
         (1, 2, 20, 121, 1),
         (2, 2, 20, 121, 1),
         (3, 2, 20, 121, 1),
         (4, 2, 20, 121, 1),
         (5, 2, 20, 121, 1),
         (6, 2, 20, 121, 1),
         (7, 2, 20, 121, 1),
         (8, 2, 20, 121, 1),
         (9, 2, 20, 121, 1),
         (10, 2, 20, 121, 1),
            (11, 2, 20, 121, 1),
            (12, 2, 20, 121, 1),
            (13, 2, 20, 121, 1),
            (14, 2, 20, 121, 1),
            (15, 2, 20, 121, 1),
            (16, 2, 20, 121, 1),
            (17, 2, 20, 121, 1),
            (18, 2, 20, 121, 1),
            (19, 2, 20, 121, 1),
            (20, 2, 20, 121, 1),
            (21, 2, 20, 121, 1),
            (22, 2, 20, 121, 1),
            (23, 2, 20, 121, 1),
            (24, 2, 20, 121, 1),
            (1, 3, 21, 121, 1),
            (2, 3, 21, 121, 1),
            (3, 3, 21, 121, 1),
            (4, 3, 21, 121, 1),
            (5, 3, 21, 121, 1),
            (6, 3, 21, 121, 1),
            (7, 3, 21, 121, 1),
            (8, 3, 21, 121, 1),
            (9, 3, 21, 121, 1),
            (10, 3, 21, 121, 1),
            (11, 3, 21, 121, 1),
            (12, 3, 21, 121, 1),
            (13, 3, 21, 121, 1),
            (14, 3, 21, 121, 1),
            (15, 3, 21, 121, 1),
            (16, 3, 21, 121, 1),
            (17, 3, 21, 121, 1),
            (18, 3, 21, 121, 1),
            (19, 3, 21, 121, 1),
            (20, 3, 21, 121, 1),
            (21, 3, 21, 121, 1),
            (22, 3, 21, 121, 1),
            (23, 3, 21, 121, 1),
            (24, 3, 21, 121, 1),
            (1, 4, 22, 121, 1),
            (2, 4, 22, 121, 1),
            (3, 4, 22, 121, 1),
            (4, 4, 22, 121, 1),
            (5, 4, 22, 121, 1),
            (6, 4, 22, 121, 1),
            (7, 4, 22, 121, 1),
            (8, 4, 22, 121, 1),
            (9, 4, 22, 121, 1),
            (10, 4, 22, 121, 1),
            (11, 4, 22, 121, 1),
            (12, 4, 22, 121, 1),
            (13, 4, 22, 121, 1),
            (14, 4, 22, 121, 1),
            (15, 4, 22, 121, 1),
            (16, 4, 22, 121, 1),
            (17, 4, 22, 121, 1),
            (18, 4, 22, 121, 1),
            (19, 4, 22, 121, 1),
            (20, 4, 22, 121, 1),
            (21, 4, 22, 121, 1),
            (22, 4, 22, 121, 1),
            (23, 4, 22, 121, 1),
            (24, 4, 22, 121, 1),
            (1, 5, 23, 121, 1),
            (2, 5, 23, 121, 1),
            (3, 5, 23, 121, 1),
            (4, 5, 23, 121, 1),
            (5, 5, 23, 121, 1),
            (6, 5, 23, 121, 1),
            (7, 5, 23, 121, 1),
            (8, 5, 23, 121, 1),
            (9, 5, 23, 121, 1),
            (10, 5, 23, 121, 1),
            (11, 5, 23, 121, 1),
            (12, 5, 23, 121, 1),
            (13, 5, 23, 121, 1),
            (14, 5, 23, 121, 1),
            (15, 5, 23, 121, 1),
            (16, 5, 23, 121, 1),
            (17, 5, 23, 121, 1),
            (18, 5, 23, 121, 1),
            (19, 5, 23, 121, 1),
            (20, 5, 23, 121, 1),
            (21, 5, 23, 121, 1),
            (22, 5, 23, 121, 1),
            (23, 5, 23, 121, 1),
            (24, 5, 23, 121, 1),
            (1, 6, 24, 121, 1),
            (2, 6, 24, 121, 1),
            (3, 6, 24, 121, 1),
            (4, 6, 24, 121, 1),
            (5, 6, 24, 121, 1),
            (6, 6, 24, 121, 1),
            (7, 6, 24, 121, 1),
            (8, 6, 24, 121, 1),
            (9, 6, 24, 121, 1),
            (10, 6, 24, 121, 1),
            (11, 6, 24, 121, 1),
            (12, 6, 24, 121, 1),
            (13, 6, 24, 121, 1),
            (14, 6, 24, 121, 1),
            (15, 6, 24, 121, 1),
            (16, 6, 24, 121, 1),
            (17, 6, 24, 121, 1),
            (18, 6, 24, 121, 1),
            (19, 6, 24, 121, 1),
            (20, 6, 24, 121, 1),
            (21, 6, 24, 121, 1),
            (22, 6, 24, 121, 1),
            (23, 6, 24, 121, 1),
            (24, 6, 24, 121, 1),
            (1, 7, 25, 121, 1),
            (2, 7, 25, 121, 1),
            (3, 7, 25, 121, 1),
            (4, 7, 25, 121, 1),
            (5, 7, 25, 121, 1),
            (6, 7, 25, 121, 1),
            (7, 7, 25, 121, 1),
            (8, 7, 25, 121, 1),
            (9, 7, 25, 121, 1),
            (10, 7, 25, 121, 1),
            (11, 7, 25, 121, 1),
            (12, 7, 25, 121, 1),
            (13, 7, 25, 121, 1),
            (14, 7, 25, 121, 1),
            (15, 7, 25, 121, 1),
            (16, 7, 25, 121, 1),
            (17, 7, 25, 121, 1),
            (18, 7, 25, 121, 1),
            (19, 7, 25, 121, 1),
            (20, 7, 25, 121, 1),
            (21, 7, 25, 121, 1),
            (22, 7, 25, 121, 1),
            (23, 7, 25, 121, 1),
            (24, 7, 25, 121, 1),
            (1, 8, 26, 121, 1),
            (2, 8, 26, 121, 1),
            (3, 8, 26, 121, 1),
            (4, 8, 26, 121, 1),
            (5, 8, 26, 121, 1),
            (6, 8, 26, 121, 1),
            (7, 8, 26, 121, 1),
            (8, 8, 26, 121, 1),
            (9, 8, 26, 121, 1),
            (10, 8, 26, 121, 1),
            (11, 8, 26, 121, 1),
            (12, 8, 26, 121, 1),
            (13, 8, 26, 121, 1),
            (14, 8, 26, 121, 1),
            (15, 8, 26, 121, 1),
            (16, 8, 26, 121, 1),
            (17, 8, 26, 121, 1),
            (18, 8, 26, 121, 1),
            (19, 8, 26, 121, 1),
            (20, 8, 26, 121, 1),
            (21, 8, 26, 121, 1),
            (22, 8, 26, 121, 1),
            (23, 8, 26, 121, 1),
            (24, 8, 26, 121, 1),
            (1, 9, 27, 121, 1),
            (2, 9, 27, 121, 1),
            (3, 9, 27, 121, 1),
            (4, 9, 27, 121, 1),
            (5, 9, 27, 121, 1),
            (6, 9, 27, 121, 1),
            (7, 9, 27, 121, 1),
            (8, 9, 27, 121, 1),
            (9, 9, 27, 121, 1),
            (10, 9, 27, 121, 1),
            (11, 9, 27, 121, 1),
            (12, 9, 27, 121, 1),
            (13, 9, 27, 121, 1),
            (14, 9, 27, 121, 1),
            (15, 9, 27, 121, 1),
            (16, 9, 27, 121, 1),
            (17, 9, 27, 121, 1),
            (18, 9, 27, 121, 1),
            (19, 9, 27, 121, 1),
            (20, 9, 27, 121, 1),
            (21, 9, 27, 121, 1),
            (22, 9, 27, 121, 1),
            (23, 9, 27, 121, 1),
            (24, 9, 27, 121, 1),
            (1, 10, 28, 121, 1),
            (2, 10, 28, 121, 1),
            (3, 10, 28, 121, 1),
            (4, 10, 28, 121, 1),
            (5, 10, 28, 121, 1),
            (6, 10, 28, 121, 1),
            (7, 10, 28, 121, 1),
            (8, 10, 28, 121, 1),
            (9, 10, 28, 121, 1),
            (10, 10, 28, 121, 1),
            (11, 10, 28, 121, 1),
            (12, 10, 28, 121, 1),
            (13, 10, 28, 121, 1),
            (14, 10, 28, 121, 1),
            (15, 10, 28, 121, 1),
            (16, 10, 28, 121, 1),
            (17, 10, 28, 121, 1),
            (18, 10, 28, 121, 1),
            (19, 10, 28, 121, 1),
            (20, 10, 28, 121, 1),
            (21, 10, 28, 121, 1),
            (22, 10, 28, 121, 1),
            (23, 10, 28, 121, 1),
            (24, 10, 28, 121, 1),
            (1, 11, 29, 121, 1),
            (2, 11, 29, 121, 1),
            (3, 11, 29, 121, 1),
            (4, 11, 29, 121, 1),
            (5, 11, 29, 121, 1),
            (6, 11, 29, 121, 1),
            (7, 11, 29, 121, 1),
            (8, 11, 29, 121, 1),
            (9, 11, 29, 121, 1),
            (10, 11, 29, 121, 1),
            (11, 11, 29, 121, 1),
            (12, 11, 29, 121, 1),
            (13, 11, 29, 121, 1),
            (14, 11, 29, 121, 1),
            (15, 11, 29, 121, 1),
            (16, 11, 29, 121, 1),
            (17, 11, 29, 121, 1),
            (18, 11, 29, 121, 1),
            (19, 11, 29, 121, 1),
            (20, 11, 29, 121, 1),
            (21, 11, 29, 121, 1),
            (22, 11, 29, 121, 1),
            (23, 11, 29, 121, 1),
            (24, 11, 29, 121, 1),
            (1, 12, 30, 121, 1),
            (2, 12, 30, 121, 1),
            (3, 12, 30, 121, 1),
            (4, 12, 30, 121, 1),
            (5, 12, 30, 121, 1),
            (6, 12, 30, 121, 1),
            (7, 12, 30, 121, 1),
            (8, 12, 30, 121, 1),
            (9, 12, 30, 121, 1),
            (10, 12, 30, 121, 1),
            (11, 12, 30, 121, 1),
            (12, 12, 30, 121, 1),
            (13, 12, 30, 121, 1),
            (14, 12, 30, 121, 1),
            (15, 12, 30, 121, 1),
            (16, 12, 30, 121, 1),
            (17, 12, 30, 121, 1),
            (18, 12, 30, 121, 1),
            (19, 12, 30, 121, 1),
            (20, 12, 30, 121, 1),
            (21, 12, 30, 121, 1),
            (22, 12, 30, 121, 1),
            (23, 12, 30, 121, 1),
            (24, 12, 30, 121, 1)

INSERT INTO Seat (seatNumber, row, price, areaId, seatStatusId)
VALUES (1, 1, 21, 131, 1),
       (2, 1, 21, 131, 1),
         (3, 1, 21, 131, 1),
         (4, 1, 21, 131, 1),
         (5, 1, 21, 131, 1),
         (6, 1, 21, 131, 1),
         (7, 1, 21, 131, 1),
         (8, 1, 21, 131, 1),
         (9, 1, 21, 131, 1),
         (10, 1, 21, 131, 1),
         (11, 1, 21, 131, 1),
         (12, 1, 21, 131, 1),
         (13, 1, 21, 131, 1),
         (14, 1, 21, 131, 1),
         (15, 1, 21, 131, 1),
         (16, 1, 21, 131, 1),
         (17, 1, 21, 131, 1),
         (18, 1, 21, 131, 1),
         (19, 1, 21, 131, 1),
         (20, 1, 21, 131, 1),
         (21, 1, 21, 131, 1),
         (22, 1, 21, 131, 1),
         (23, 1, 21, 131, 1),
         (24, 1, 21, 131, 1),
         (1, 2, 22, 131, 1),
         (2, 2, 22, 131, 1),
         (3, 2, 22, 131, 1),
         (4, 2, 22, 131, 1),
         (5, 2, 22, 131, 1),
         (6, 2, 22, 131, 1),
         (7, 2, 22, 131, 1),
         (8, 2, 22, 131, 1),
         (9, 2, 22, 131, 1),
         (10, 2, 22, 131, 1),
    (11, 2, 22, 131, 1),
                (12, 2, 22, 131, 1),
                (13, 2, 22, 131, 1),
                (14, 2, 22, 131, 1),
                (15, 2, 22, 131, 1),
                (16, 2, 22, 131, 1),
                (17, 2, 22, 131, 1),
                (18, 2, 22, 131, 1),
                (19, 2, 22, 131, 1),
                (20, 2, 22, 131, 1),
                (21, 2, 22, 131, 1),
                (22, 2, 22, 131, 1),
                (23, 2, 22, 131, 1),
                (24, 2, 22, 131, 1),
                (1, 3, 23, 131, 1),
                (2, 3, 23, 131, 1),
                (3, 3, 23, 131, 1),
                (4, 3, 23, 131, 1),
                (5, 3, 23, 131, 1),
                (6, 3, 23, 131, 1),
                (7, 3, 23, 131, 1),
                (8, 3, 23, 131, 1),
                (9, 3, 23, 131, 1),
                (10, 3, 23, 131, 1),
                (11, 3, 23, 131, 1),
                (12, 3, 23, 131, 1),
                (13, 3, 23, 131, 1),
                (14, 3, 23, 131, 1),
                (15, 3, 23, 131, 1),
                (16, 3, 23, 131, 1),
                (17, 3, 23, 131, 1),
                (18, 3, 23, 131, 1),
                (19, 3, 23, 131, 1),
                (20, 3, 23, 131, 1),
                (21, 3, 23, 131, 1),
                (22, 3, 23, 131, 1),
                (23, 3, 23, 131, 1),
                (24, 3, 23, 131, 1),
                (1, 4, 24, 131, 1),
                (2, 4, 24, 131, 1),
                (3, 4, 24, 131, 1),
                (4, 4, 24, 131, 1),
                (5, 4, 24, 131, 1),
                (6, 4, 24, 131, 1),
                (7, 4, 24, 131, 1),
                (8, 4, 24, 131, 1),
                (9, 4, 24, 131, 1),
                (10, 4, 24, 131, 1),
                (11, 4, 24, 131, 1),
                (12, 4, 24, 131, 1),
                (13, 4, 24, 131, 1),
                (14, 4, 24, 131, 1),
                (15, 4, 24, 131, 1),
                (16, 4, 24, 131, 1),
                (17, 4, 24, 131, 1),
                (18, 4, 24, 131, 1),
                (19, 4, 24, 131, 1),
                (20, 4, 24, 131, 1),
                (21, 4, 24, 131, 1),
                (22, 4, 24, 131, 1),
                (23, 4, 24, 131, 1),
                (24, 4, 24, 131, 1),
                (1, 5, 25, 131, 1),
                (2, 5, 25, 131, 1),
                (3, 5, 25, 131, 1),
                (4, 5, 25, 131, 1),
                (5, 5, 25, 131, 1),
                (6, 5, 25, 131, 1),
                (7, 5, 25, 131, 1),
                (8, 5, 25, 131, 1),
                (9, 5, 25, 131, 1),
                (10, 5, 25, 131, 1),
                (11, 5, 25, 131, 1),
                (12, 5, 25, 131, 1),
                (13, 5, 25, 131, 1),
                (14, 5, 25, 131, 1),
                (15, 5, 25, 131, 1),
                (16, 5, 25, 131, 1),
                (17, 5, 25, 131, 1),
                (18, 5, 25, 131, 1),
                (19, 5, 25, 131, 1),
                (20, 5, 25, 131, 1),
                (21, 5, 25, 131, 1),
                (22, 5, 25, 131, 1),
                (23, 5, 25, 131, 1),
                (24, 5, 25, 131, 1),
                (1, 6, 26, 131, 1),
                (2, 6, 26, 131, 1),
                (3, 6, 26, 131, 1),
                (4, 6, 26, 131, 1),
                (5, 6, 26, 131, 1),
                (6, 6, 26, 131, 1),
                (7, 6, 26, 131, 1),
                (8, 6, 26, 131, 1),
                (9, 6, 26, 131, 1),
                (10, 6, 26, 131, 1),
                (11, 6, 26, 131, 1),
                (12, 6, 26, 131, 1),
                (13, 6, 26, 131, 1),
                (14, 6, 26, 131, 1),
                (15, 6, 26, 131, 1),
                (16, 6, 26, 131, 1),
                (17, 6, 26, 131, 1),
                (18, 6, 26, 131, 1),
                (19, 6, 26, 131, 1),
                (20, 6, 26, 131, 1),
                (21, 6, 26, 131, 1),
                (22, 6, 26, 131, 1),
                (23, 6, 26, 131, 1),
                (24, 6, 26, 131, 1),
                (1, 7, 27, 131, 1),
                (2, 7, 27, 131, 1),
                (3, 7, 27, 131, 1),
                (4, 7, 27, 131, 1),
                (5, 7, 27, 131, 1),
                (6, 7, 27, 131, 1),
                (7, 7, 27, 131, 1),
                (8, 7, 27, 131, 1),
                (9, 7, 27, 131, 1),
                (10, 7, 27, 131, 1),
                (11, 7, 27, 131, 1),
                (12, 7, 27, 131, 1),
                (13, 7, 27, 131, 1),
                (14, 7, 27, 131, 1),
                (15, 7, 27, 131, 1),
                (16, 7, 27, 131, 1),
                (17, 7, 27, 131, 1),
                (18, 7, 27, 131, 1),
                (19, 7, 27, 131, 1),
                (20, 7, 27, 131, 1),
                (21, 7, 27, 131, 1),
                (22, 7, 27, 131, 1),
                (23, 7, 27, 131, 1),
                (24, 7, 27, 131, 1),
                (1, 8, 28, 131, 1),
                (2, 8, 28, 131, 1),
                (3, 8, 28, 131, 1),
                (4, 8, 28, 131, 1),
                (5, 8, 28, 131, 1),
                (6, 8, 28, 131, 1),
                (7, 8, 28, 131, 1),
                (8, 8, 28, 131, 1),
                (9, 8, 28, 131, 1),
                (10, 8, 28, 131, 1),
                (11, 8, 28, 131, 1),
                (12, 8, 28, 131, 1),
                (13, 8, 28, 131, 1),
                (14, 8, 28, 131, 1),
                (15, 8, 28, 131, 1),
                (16, 8, 28, 131, 1),
                (17, 8, 28, 131, 1),
                (18, 8, 28, 131, 1),
                (19, 8, 28, 131, 1),
                (20, 8, 28, 131, 1),
                (21, 8, 28, 131, 1),
                (22, 8, 28, 131, 1),
                (23, 8, 28, 131, 1),
                (24, 8, 28, 131, 1),
                (1, 9, 29, 131, 1),
                (2, 9, 29, 131, 1),
                (3, 9, 29, 131, 1),
                (4, 9, 29, 131, 1),
                (5, 9, 29, 131, 1),
                (6, 9, 29, 131, 1),
                (7, 9, 29, 131, 1),
                (8, 9, 29, 131, 1),
                (9, 9, 29, 131, 1),
                (10, 9, 29, 131, 1),
                (11, 9, 29, 131, 1),
                (12, 9, 29, 131, 1),
                (13, 9, 29, 131, 1),
                (14, 9, 29, 131, 1),
                (15, 9, 29, 131, 1),
                (16, 9, 29, 131, 1),
                (17, 9, 29, 131, 1),
                (18, 9, 29, 131, 1),
                (19, 9, 29, 131, 1),
                (20, 9, 29, 131, 1),
                (21, 9, 29, 131, 1),
                (22, 9, 29, 131, 1),
                (23, 9, 29, 131, 1),
                (24, 9, 29, 131, 1),
                (1, 10, 30, 131, 1),
                (2, 10, 30, 131, 1),
                (3, 10, 30, 131, 1),
                (4, 10, 30, 131, 1),
                (5, 10, 30, 131, 1),
                (6, 10, 30, 131, 1),
                (7, 10, 30, 131, 1),
                (8, 10, 30, 131, 1),
                (9, 10, 30, 131, 1),
                (10, 10, 30, 131, 1),
                (11, 10, 30, 131, 1),
                (12, 10, 30, 131, 1),
                (13, 10, 30, 131, 1),
                (14, 10, 30, 131, 1),
                (15, 10, 30, 131, 1),
                (16, 10, 30, 131, 1),
                (17, 10, 30, 131, 1),
                (18, 10, 30, 131, 1),
                (19, 10, 30, 131, 1),
                (20, 10, 30, 131, 1),
                (21, 10, 30, 131, 1),
                (22, 10, 30, 131, 1),
                (23, 10, 30, 131, 1),
                (24, 10, 30, 131, 1),
                (1, 11, 31, 131, 1),
                (2, 11, 31, 131, 1),
                (3, 11, 31, 131, 1),
                (4, 11, 31, 131, 1),
                (5, 11, 31, 131, 1),
                (6, 11, 31, 131, 1),
                (7, 11, 31, 131, 1),
                (8, 11, 31, 131, 1),
                (9, 11, 31, 131, 1),
                (10, 11, 31, 131, 1),
                (11, 11, 31, 131, 1),
                (12, 11, 31, 131, 1),
                (13, 11, 31, 131, 1),
                (14, 11, 31, 131, 1),
                (15, 11, 31, 131, 1),
                (16, 11, 31, 131, 1),
                (17, 11, 31, 131, 1),
                (18, 11, 31, 131, 1),
                (19, 11, 31, 131, 1),
                (20, 11, 31, 131, 1),
                (21, 11, 31, 131, 1),
                (22, 11, 31, 131, 1),
                (23, 11, 31, 131, 1),
                (24, 11, 31, 131, 1),
                (1, 12, 32, 131, 1),
                (2, 12, 32, 131, 1),
                (3, 12, 32, 131, 1),
                (4, 12, 32, 131, 1),
                (5, 12, 32, 131, 1),
                (6, 12, 32, 131, 1),
                (7, 12, 32, 131, 1),
                (8, 12, 32, 131, 1),
                (9, 12, 32, 131, 1),
                (10, 12, 32, 131, 1),
                (11, 12, 32, 131, 1),
                (12, 12, 32, 131, 1),
                (13, 12, 32, 131, 1),
                (14, 12, 32, 131, 1),
                (15, 12, 32, 131, 1),
                (16, 12, 32, 131, 1),
                (17, 12, 32, 131, 1),
                (18, 12, 32, 131, 1),
                (19, 12, 32, 131, 1),
                (20, 12, 32, 131, 1),
                (21, 12, 32, 131, 1),
                (22, 12, 32, 131, 1),
                (23, 12, 32, 131, 1),
                (24, 12, 32, 131, 1)

INSERT INTO Seat (seatNumber, row, price, areaId, seatStatusId)
VALUES (1, 1, 21, 132, 1),
       (2, 1, 21, 132, 1),
       (3, 1, 21, 132, 1),
         (4, 1, 21, 132, 1),
         (5, 1, 21, 132, 1),
         (6, 1, 21, 132, 1),
         (7, 1, 21, 132, 1),
         (8, 1, 21, 132, 1),
         (9, 1, 21, 132, 1),
         (10, 1, 21, 132, 1),
         (11, 1, 21, 132, 1),
         (12, 1, 21, 132, 1),
         (13, 1, 21, 132, 1),
         (14, 1, 21, 132, 1),
         (15, 1, 21, 132, 1),
         (16, 1, 21, 132, 1),
         (17, 1, 21, 132, 1),
         (18, 1, 21, 132, 1),
         (19, 1, 21, 132, 1),
         (20, 1, 21, 132, 1),
         (21, 1, 21, 132, 1),
         (22, 1, 21, 132, 1),
         (23, 1, 21, 132, 1),
         (24, 1, 21, 132, 1),
         (1, 2, 22, 132, 1),
         (2, 2, 22, 132, 1),
         (3, 2, 22, 132, 1),
         (4, 2, 22, 132, 1),
         (5, 2, 22, 132, 1),
         (6, 2, 22, 132, 1),
         (7, 2, 22, 132, 1),
         (8, 2, 22, 132, 1),
         (9, 2, 22, 132, 1),
         (10, 2, 22, 132, 1),
         (11, 2, 22, 132, 1),
         (12, 2, 22, 132, 1),
         (13, 2, 22, 132, 1),
         (14, 2, 22, 132, 1),
         (15, 2, 22, 132, 1),
         (16, 2, 22, 132, 1),
         (17, 2, 22, 132, 1),
         (18, 2, 22, 132, 1),
         (19, 2, 22, 132, 1),
         (20, 2, 22, 132, 1),
         (21, 2, 22, 132, 1),
         (22, 2, 22, 132, 1),
         (23, 2, 22, 132, 1),
         (24, 2, 22, 132, 1),
         (1, 3, 23, 132, 1),
         (2, 3, 23, 132, 1),
         (3, 3, 23, 132, 1),
         (4, 3, 23, 132, 1),
         (5, 3, 23, 132, 1),
         (6, 3, 23, 132, 1),
         (7, 3, 23, 132, 1),
         (8, 3, 23, 132, 1),
         (9, 3, 23, 132, 1),
         (10, 3, 23, 132, 1),
         (11, 3, 23, 132, 1),
         (12, 3, 23, 132, 1),
         (13, 3, 23, 132, 1),
         (14, 3, 23, 132, 1),
         (15, 3, 23, 132, 1),
         (16, 3, 23, 132, 1),
         (17, 3, 23, 132, 1),
         (18, 3, 23, 132, 1),
         (19, 3, 23, 132, 1),
         (20, 3, 23, 132, 1),
         (21, 3, 23, 132, 1),
         (22, 3, 23, 132, 1),
         (23, 3, 23, 132, 1),
         (24, 3, 23, 132, 1),
         (1, 4, 24, 132, 1),
         (2, 4, 24, 132, 1),
         (3, 4, 24, 132, 1),
         (4, 4, 24, 132, 1),
         (5, 4, 24, 132, 1),
         (6, 4, 24, 132, 1),
         (7, 4, 24, 132, 1),
         (8, 4, 24, 132, 1),
         (9, 4, 24, 132, 1),
         (10, 4, 24, 132, 1),
         (11, 4, 24, 132, 1),
         (12, 4, 24, 132, 1),
         (13, 4, 24, 132, 1),
         (14, 4, 24, 132, 1),
         (15, 4, 24, 132, 1),
         (16, 4, 24, 132, 1),
         (17, 4, 24, 132, 1),
         (18, 4, 24, 132, 1),
         (19, 4, 24, 132, 1),
         (20, 4, 24, 132, 1),
         (21, 4, 24, 132, 1),
         (22, 4, 24, 132, 1),
         (23, 4, 24, 132, 1),
         (24, 4, 24, 132, 1),
         (1, 5, 25, 132, 1),
         (2, 5, 25, 132, 1),
         (3, 5, 25, 132, 1),
         (4, 5, 25, 132, 1),
         (5, 5, 25, 132, 1),
         (6, 5, 25, 132, 1),
         (7, 5, 25, 132, 1),
         (8, 5, 25, 132, 1),
         (9, 5, 25, 132, 1),
         (10, 5, 25, 132, 1),
         (11, 5, 25, 132, 1),
         (12, 5, 25, 132, 1),
         (13, 5, 25, 132, 1),
         (14, 5, 25, 132, 1),
         (15, 5, 25, 132, 1),
         (16, 5, 25, 132, 1),
         (17, 5, 25, 132, 1),
         (18, 5, 25, 132, 1),
         (19, 5, 25, 132, 1),
         (20, 5, 25, 132, 1),
         (21, 5, 25, 132, 1),
         (22, 5, 25, 132, 1),
         (23, 5, 25, 132, 1),
         (24, 5, 25, 132, 1),
         (1, 6, 26, 132, 1),
         (2, 6, 26, 132, 1),
         (3, 6, 26, 132, 1),
         (4, 6, 26, 132, 1),
         (5, 6, 26, 132, 1),
         (6, 6, 26, 132, 1),
         (7, 6, 26, 132, 1),
         (8, 6, 26, 132, 1),
         (9, 6, 26, 132, 1),
         (10, 6, 26, 132, 1),
         (11, 6, 26, 132, 1),
         (12, 6, 26, 132, 1),
         (13, 6, 26, 132, 1),
         (14, 6, 26, 132, 1),
         (15, 6, 26, 132, 1),
         (16, 6, 26, 132, 1),
         (17, 6, 26, 132, 1),
         (18, 6, 26, 132, 1),
         (19, 6, 26, 132, 1),
         (20, 6, 26, 132, 1),
         (21, 6, 26, 132, 1),
         (22, 6, 26, 132, 1),
         (23, 6, 26, 132, 1),
         (24, 6, 26, 132, 1),
         (1, 7, 27, 132, 1),
         (2, 7, 27, 132, 1),
         (3, 7, 27, 132, 1),
         (4, 7, 27, 132, 1),
         (5, 7, 27, 132, 1),
         (6, 7, 27, 132, 1),
         (7, 7, 27, 132, 1),
         (8, 7, 27, 132, 1),
         (9, 7, 27, 132, 1),
         (10, 7, 27, 132, 1),
         (11, 7, 27, 132, 1),
         (12, 7, 27, 132, 1),
         (13, 7, 27, 132, 1),
         (14, 7, 27, 132, 1),
         (15, 7, 27, 132, 1),
            (16, 7, 27, 132, 1),
            (17, 7, 27, 132, 1),
            (18, 7, 27, 132, 1),
            (19, 7, 27, 132, 1),
            (20, 7, 27, 132, 1),
            (21, 7, 27, 132, 1),
            (22, 7, 27, 132, 1),
            (23, 7, 27, 132, 1),
            (24, 7, 27, 132, 1),
            (1, 8, 28, 132, 1),
            (2, 8, 28, 132, 1),
            (3, 8, 28, 132, 1),
            (4, 8, 28, 132, 1),
            (5, 8, 28, 132, 1),
            (6, 8, 28, 132, 1),
            (7, 8, 28, 132, 1),
            (8, 8, 28, 132, 1),
            (9, 8, 28, 132, 1),
            (10, 8, 28, 132, 1),
            (11, 8, 28, 132, 1),
            (12, 8, 28, 132, 1),
            (13, 8, 28, 132, 1),
            (14, 8, 28, 132, 1),
            (15, 8, 28, 132, 1),
            (16, 8, 28, 132, 1),
            (17, 8, 28, 132, 1),
            (18, 8, 28, 132, 1),
            (19, 8, 28, 132, 1),
            (20, 8, 28, 132, 1),
            (21, 8, 28, 132, 1),
            (22, 8, 28, 132, 1),
            (23, 8, 28, 132, 1),
            (24, 8, 28, 132, 1),
            (1, 9, 29, 132, 1),
            (2, 9, 29, 132, 1),
            (3, 9, 29, 132, 1),
            (4, 9, 29, 132, 1),
            (5, 9, 29, 132, 1),
            (6, 9, 29, 132, 1),
            (7, 9, 29, 132, 1),
            (8, 9, 29, 132, 1),
            (9, 9, 29, 132, 1),
            (10, 9, 29, 132, 1),
            (11, 9, 29, 132, 1),
            (12, 9, 29, 132, 1),
            (13, 9, 29, 132, 1),
            (14, 9, 29, 132, 1),
            (15, 9, 29, 132, 1),
            (16, 9, 29, 132, 1),
            (17, 9, 29, 132, 1),
            (18, 9, 29, 132, 1),
            (19, 9, 29, 132, 1),
            (20, 9, 29, 132, 1),
            (21, 9, 29, 132, 1),
            (22, 9, 29, 132, 1),
            (23, 9, 29, 132, 1),
            (24, 9, 29, 132, 1),
            (1, 10, 30, 132, 1),
            (2, 10, 30, 132, 1),
            (3, 10, 30, 132, 1),
            (4, 10, 30, 132, 1),
            (5, 10, 30, 132, 1),
            (6, 10, 30, 132, 1),
            (7, 10, 30, 132, 1),
            (8, 10, 30, 132, 1),
            (9, 10, 30, 132, 1),
            (10, 10, 30, 132, 1),
            (11, 10, 30, 132, 1),
            (12, 10, 30, 132, 1),
            (13, 10, 30, 132, 1),
            (14, 10, 30, 132, 1),
            (15, 10, 30, 132, 1),
            (16, 10, 30, 132, 1),
            (17, 10, 30, 132, 1),
            (18, 10, 30, 132, 1),
            (19, 10, 30, 132, 1),
            (20, 10, 30, 132, 1),
            (21, 10, 30, 132, 1),
            (22, 10, 30, 132, 1),
            (23, 10, 30, 132, 1),
            (24, 10, 30, 132, 1),
            (1, 11, 31, 132, 1),
            (2, 11, 31, 132, 1),
            (3, 11, 31, 132, 1),
            (4, 11, 31, 132, 1),
            (5, 11, 31, 132, 1),
            (6, 11, 31, 132, 1),
            (7, 11, 31, 132, 1),
            (8, 11, 31, 132, 1),
            (9, 11, 31, 132, 1),
            (10, 11, 31, 132, 1),
            (11, 11, 31, 132, 1),
            (12, 11, 31, 132, 1),
            (13, 11, 31, 132, 1),
            (14, 11, 31, 132, 1),
            (15, 11, 31, 132, 1),
            (16, 11, 31, 132, 1),
            (17, 11, 31, 132, 1),
            (18, 11, 31, 132, 1),
            (19, 11, 31, 132, 1),
            (20, 11, 31, 132, 1),
            (21, 11, 31, 132, 1),
            (22, 11, 31, 132, 1),
            (23, 11, 31, 132, 1),
            (24, 11, 31, 132, 1),
            (1, 12, 32, 132, 1),
            (2, 12, 32, 132, 1),
            (3, 12, 32, 132, 1),
            (4, 12, 32, 132, 1),
            (5, 12, 32, 132, 1),
            (6, 12, 32, 132, 1),
            (7, 12, 32, 132, 1),
            (8, 12, 32, 132, 1),
            (9, 12, 32, 132, 1),
            (10, 12, 32, 132, 1),
            (11, 12, 32, 132, 1),
            (12, 12, 32, 132, 1),
            (13, 12, 32, 132, 1),
            (14, 12, 32, 132, 1),
            (15, 12, 32, 132, 1),
            (16, 12, 32, 132, 1),
            (17, 12, 32, 132, 1),
            (18, 12, 32, 132, 1),
            (19, 12, 32, 132, 1),
            (20, 12, 32, 132, 1),
            (21, 12, 32, 132, 1),
            (22, 12, 32, 132, 1),
            (23, 12, 32, 132, 1),
            (24, 12, 32, 132, 1)

INSERT INTO Seat (seatNumber, row, price, areaId, seatStatusId)
VALUES (1, 1, 19, 141, 1),
       (2, 1, 19, 141, 1),
       (3, 1, 19, 141, 1),
            (4, 1, 19, 141, 1),
            (5, 1, 19, 141, 1),
            (6, 1, 19, 141, 1),
            (7, 1, 19, 141, 1),
            (8, 1, 19, 141, 1),
            (9, 1, 19, 141, 1),
            (10, 1, 19, 141, 1),
            (11, 1, 19, 141, 1),
            (12, 1, 19, 141, 1),
            (13, 1, 19, 141, 1),
            (14, 1, 19, 141, 1),
            (15, 1, 19, 141, 1),
            (16, 1, 19, 141, 1),
            (17, 1, 19, 141, 1),
            (18, 1, 19, 141, 1),
            (19, 1, 19, 141, 1),
            (20, 1, 19, 141, 1),
            (21, 1, 19, 141, 1),
            (22, 1, 19, 141, 1),
            (23, 1, 19, 141, 1),
            (24, 1, 19, 141, 1),
            (1, 2, 20, 141, 1),
            (2, 2, 20, 141, 1),
            (3, 2, 20, 141, 1),
            (4, 2, 20, 141, 1),
            (5, 2, 20, 141, 1),
            (6, 2, 20, 141, 1),
            (7, 2, 20, 141, 1),
            (8, 2, 20, 141, 1),
            (9, 2, 20, 141, 1),
            (10, 2, 20, 141, 1),
            (11, 2, 20, 141, 1),
            (12, 2, 20, 141, 1),
            (13, 2, 20, 141, 1),
            (14, 2, 20, 141, 1),
            (15, 2, 20, 141, 1),
            (16, 2, 20, 141, 1),
            (17, 2, 20, 141, 1),
            (18, 2, 20, 141, 1),
            (19, 2, 20, 141, 1),
            (20, 2, 20, 141, 1),
            (21, 2, 20, 141, 1),
            (22, 2, 20, 141, 1),
            (23, 2, 20, 141, 1),
            (24, 2, 20, 141, 1),
            (1, 3, 21, 141, 1),
            (2, 3, 21, 141, 1),
            (3, 3, 21, 141, 1),
            (4, 3, 21, 141, 1),
            (5, 3, 21, 141, 1),
            (6, 3, 21, 141, 1),
            (7, 3, 21, 141, 1),
            (8, 3, 21, 141, 1),
            (9, 3, 21, 141, 1),
            (10, 3, 21, 141, 1),
            (11, 3, 21, 141, 1),
            (12, 3, 21, 141, 1),
            (13, 3, 21, 141, 1),
            (14, 3, 21, 141, 1),
            (15, 3, 21, 141, 1),
            (16, 3, 21, 141, 1),
            (17, 3, 21, 141, 1),
            (18, 3, 21, 141, 1),
            (19, 3, 21, 141, 1),
            (20, 3, 21, 141, 1),
            (21, 3, 21, 141, 1),
            (22, 3, 21, 141, 1),
            (23, 3, 21, 141, 1),
            (24, 3, 21, 141, 1),
            (1, 4, 22, 141, 1),
            (2, 4, 22, 141, 1),
            (3, 4, 22, 141, 1),
            (4, 4, 22, 141, 1),
            (5, 4, 22, 141, 1),
            (6, 4, 22, 141, 1),
            (7, 4, 22, 141, 1),
            (8, 4, 22, 141, 1),
            (9, 4, 22, 141, 1),
            (10, 4, 22, 141, 1),
            (11, 4, 22, 141, 1),
            (12, 4, 22, 141, 1),
            (13, 4, 22, 141, 1),
            (14, 4, 22, 141, 1),
            (15, 4, 22, 141, 1),
            (16, 4, 22, 141, 1),
            (17, 4, 22, 141, 1),
            (18, 4, 22, 141, 1),
            (19, 4, 22, 141, 1),
            (20, 4, 22, 141, 1),
            (21, 4, 22, 141, 1),
            (22, 4, 22, 141, 1),
            (23, 4, 22, 141, 1),
            (24, 4, 22, 141, 1),
            (1, 5, 23, 141, 1),
            (2, 5, 23, 141, 1),
            (3, 5, 23, 141, 1),
            (4, 5, 23, 141, 1),
            (5, 5, 23, 141, 1),
            (6, 5, 23, 141, 1),
            (7, 5, 23, 141, 1),
            (8, 5, 23, 141, 1),
            (9, 5, 23, 141, 1),
            (10, 5, 23, 141, 1),
            (11, 5, 23, 141, 1),
            (12, 5, 23, 141, 1),
            (13, 5, 23, 141, 1),
            (14, 5, 23, 141, 1),
            (15, 5, 23, 141, 1),
            (16, 5, 23, 141, 1),
            (17, 5, 23, 141, 1),
            (18, 5, 23, 141, 1),
            (19, 5, 23, 141, 1),
            (20, 5, 23, 141, 1),
            (21, 5, 23, 141, 1),
            (22, 5, 23, 141, 1),
            (23, 5, 23, 141, 1),
            (24, 5, 23, 141, 1),
            (1, 6, 24, 141, 1),
            (2, 6, 24, 141, 1),
            (3, 6, 24, 141, 1),
            (4, 6, 24, 141, 1),
            (5, 6, 24, 141, 1),
            (6, 6, 24, 141, 1),
            (7, 6, 24, 141, 1),
            (8, 6, 24, 141, 1),
            (9, 6, 24, 141, 1),
            (10, 6, 24, 141, 1),
            (11, 6, 24, 141, 1),
            (12, 6, 24, 141, 1),
            (13, 6, 24, 141, 1),
            (14, 6, 24, 141, 1),
            (15, 6, 24, 141, 1),
            (16, 6, 24, 141, 1),
            (17, 6, 24, 141, 1),
            (18, 6, 24, 141, 1),
            (19, 6, 24, 141, 1),
            (20, 6, 24, 141, 1),
            (21, 6, 24, 141, 1),
            (22, 6, 24, 141, 1),
            (23, 6, 24, 141, 1),
            (24, 6, 24, 141, 1),
            (1, 7, 25, 141, 1),
            (2, 7, 25, 141, 1),
            (3, 7, 25, 141, 1),
            (4, 7, 25, 141, 1),
            (5, 7, 25, 141, 1),
            (6, 7, 25, 141, 1),
            (7, 7, 25, 141, 1),
            (8, 7, 25, 141, 1),
            (9, 7, 25, 141, 1),
            (10, 7, 25, 141, 1),
            (11, 7, 25, 141, 1),
            (12, 7, 25, 141, 1),
            (13, 7, 25, 141, 1),
            (14, 7, 25, 141, 1),
            (15, 7, 25, 141, 1),
            (16, 7, 25, 141, 1),
            (17, 7, 25, 141, 1),
            (18, 7, 25, 141, 1),
            (19, 7, 25, 141, 1),
            (20, 7, 25, 141, 1),
            (21, 7, 25, 141, 1),
            (22, 7, 25, 141, 1),
            (23, 7, 25, 141, 1),
            (24, 7, 25, 141, 1),
            (1, 8, 26, 141, 1),
            (2, 8, 26, 141, 1),
            (3, 8, 26, 141, 1),
            (4, 8, 26, 141, 1),
            (5, 8, 26, 141, 1),
            (6, 8, 26, 141, 1),
            (7, 8, 26, 141, 1),
            (8, 8, 26, 141, 1),
            (9, 8, 26, 141, 1),
            (10, 8, 26, 141, 1),
            (11, 8, 26, 141, 1),
            (12, 8, 26, 141, 1),
            (13, 8, 26, 141, 1),
            (14, 8, 26, 141, 1),
            (15, 8, 26, 141, 1),
            (16, 8, 26, 141, 1),
            (17, 8, 26, 141, 1),
            (18, 8, 26, 141, 1),
            (19, 8, 26, 141, 1),
            (20, 8, 26, 141, 1),
            (21, 8, 26, 141, 1),
            (22, 8, 26, 141, 1),
            (23, 8, 26, 141, 1),
            (24, 8, 26, 141, 1),
            (1, 9, 27, 141, 1),
            (2, 9, 27, 141, 1),
            (3, 9, 27, 141, 1),
            (4, 9, 27, 141, 1),
            (5, 9, 27, 141, 1),
            (6, 9, 27, 141, 1),
            (7, 9, 27, 141, 1),
            (8, 9, 27, 141, 1),
            (9, 9, 27, 141, 1),
            (10, 9, 27, 141, 1),
            (11, 9, 27, 141, 1),
            (12, 9, 27, 141, 1),
            (13, 9, 27, 141, 1),
            (14, 9, 27, 141, 1),
            (15, 9, 27, 141, 1),
            (16, 9, 27, 141, 1),
            (17, 9, 27, 141, 1),
            (18, 9, 27, 141, 1),
            (19, 9, 27, 141, 1),
            (20, 9, 27, 141, 1),
            (21, 9, 27, 141, 1),
            (22, 9, 27, 141, 1),
            (23, 9, 27, 141, 1),
            (24, 9, 27, 141, 1),
            (1, 10, 28, 141, 1),
            (2, 10, 28, 141, 1),
            (3, 10, 28, 141, 1),
            (4, 10, 28, 141, 1),
            (5, 10, 28, 141, 1),
            (6, 10, 28, 141, 1),
            (7, 10, 28, 141, 1),
            (8, 10, 28, 141, 1),
            (9, 10, 28, 141, 1),
            (10, 10, 28, 141, 1),
            (11, 10, 28, 141, 1),
            (12, 10, 28, 141, 1),
            (13, 10, 28, 141, 1),
            (14, 10, 28, 141, 1),
            (15, 10, 28, 141, 1),
            (16, 10, 28, 141, 1),
            (17, 10, 28, 141, 1),
            (18, 10, 28, 141, 1),
            (19, 10, 28, 141, 1),
            (20, 10, 28, 141, 1),
            (21, 10, 28, 141, 1),
            (22, 10, 28, 141, 1),
            (23, 10, 28, 141, 1),
            (24, 10, 28, 141, 1),
            (1, 11, 29, 141, 1),
            (2, 11, 29, 141, 1),
            (3, 11, 29, 141, 1),
            (4, 11, 29, 141, 1),
            (5, 11, 29, 141, 1),
            (6, 11, 29, 141, 1),
            (7, 11, 29, 141, 1),
            (8, 11, 29, 141, 1),
            (9, 11, 29, 141, 1),
            (10, 11, 29, 141, 1),
            (11, 11, 29, 141, 1),
            (12, 11, 29, 141, 1),
            (13, 11, 29, 141, 1),
            (14, 11, 29, 141, 1),
            (15, 11, 29, 141, 1),
            (16, 11, 29, 141, 1),
            (17, 11, 29, 141, 1),
            (18, 11, 29, 141, 1),
            (19, 11, 29, 141, 1),
            (20, 11, 29, 141, 1),
            (21, 11, 29, 141, 1),
            (22, 11, 29, 141, 1),
            (23, 11, 29, 141, 1),
            (24, 11, 29, 141, 1),
            (1, 12, 30, 141, 1),
            (2, 12, 30, 141, 1),
            (3, 12, 30, 141, 1),
            (4, 12, 30, 141, 1),
            (5, 12, 30, 141, 1),
            (6, 12, 30, 141, 1),
            (7, 12, 30, 141, 1),
            (8, 12, 30, 141, 1),
            (9, 12, 30, 141, 1),
            (10, 12, 30, 141, 1),
            (11, 12, 30, 141, 1),
            (12, 12, 30, 141, 1),
            (13, 12, 30, 141, 1),
            (14, 12, 30, 141, 1),
            (15, 12, 30, 141, 1),
            (16, 12, 30, 141, 1),
            (17, 12, 30, 141, 1),
            (18, 12, 30, 141, 1),
            (19, 12, 30, 141, 1),
            (20, 12, 30, 141, 1),
            (21, 12, 30, 141, 1),
            (22, 12, 30, 141, 1),
            (23, 12, 30, 141, 1),
            (24, 12, 30, 141, 1)


INSERT INTO Club VALUES
('Manchester United', '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'),
('Manchester City', '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'),
('Liverpool FC', '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'),
('Arsenal FC', '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');

UPDATE Seat SET price = 169000 WHERE price = 19;
UPDATE Seat SET price = 179000 WHERE price = 20;
UPDATE Seat SET price = 189000 WHERE price = 21;
UPDATE Seat SET price = 199000 WHERE price = 22;
UPDATE Seat SET price = 209000 WHERE price = 23;
UPDATE Seat SET price = 219000 WHERE price = 24;
UPDATE Seat SET price = 229000 WHERE price = 25;
UPDATE Seat SET price = 239000 WHERE price = 26;
UPDATE Seat SET price = 249000 WHERE price = 27;
UPDATE Seat SET price = 259000 WHERE price = 28;
UPDATE Seat SET price = 269000 WHERE price = 29;
UPDATE Seat SET price = 279000 WHERE price = 30;
UPDATE Seat SET price = 289000 WHERE price = 31;
UPDATE Seat SET price = 299000 WHERE price = 32;





