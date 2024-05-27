CREATE DATABASE TicketGoal
use TicketGoal

CREATE TABLE Role
(
  roleId INT IDENTITY(1,1) NOT NULL,
  roleName NVARCHAR(200) NOT NULL,
  PRIMARY KEY (roleId)
);

CREATE TABLE Pitch
(
  pitchId INT IDENTITY(1,1) NOT NULL,
  pitchName NVARCHAR(200) NOT NULL,
  address NVARCHAR(2000) NOT NULL,
  pitchStructure NVARCHAR(2000) NOT NULL,
  image NVARCHAR(2000) NOT NULL,
  PRIMARY KEY (pitchId)
);

CREATE TABLE Area
(
  areaId INT IDENTITY(1,1) NOT NULL,
  areaName NVARCHAR(200) NOT NULL,
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
  playerRoleId INT IDENTITY(1,1) NOT NULL,
  roleName NVARCHAR(200) NOT NULL,
  PRIMARY KEY (playerRoleId)
);

CREATE TABLE Club
(
  clubId INT IDENTITY(1,1) NOT NULL,
  clubName NVARCHAR(200) NOT NULL,
  logo NVARCHAR(2000) NOT NULL,
  PRIMARY KEY (clubId)
);

CREATE TABLE ticketStatus
(
  ticketStatusId INT IDENTITY(1,1) NOT NULL,
  statusName NVARCHAR(200) NOT NULL,
  PRIMARY KEY (ticketStatusId)
);

CREATE TABLE seatStatus
(
  seatStatusId INT IDENTITY(1,1) NOT NULL,
  statusName NVARCHAR(200) NOT NULL,
  PRIMARY KEY (seatStatusId)
);

CREATE TABLE matchStatus
(
  matchStatusId INT IDENTITY(1,1) NOT NULL,
  statusName NVARCHAR(200) NOT NULL,
  PRIMARY KEY (matchStatusId)
);

CREATE TABLE accountStatus
(
  accountStatusId INT IDENTITY(1,1) NOT NULL,
  statusName NVARCHAR(200) NOT NULL,
  PRIMARY KEY (accountStatusId)
);

CREATE TABLE Contact
(
  contactId INT IDENTITY(1,1) NOT NULL,
  message NVARCHAR(2000) NOT NULL,
  mail NVARCHAR(200) NOT NULL,
  date DATE NOT NULL,
  PRIMARY KEY (contactId)
);

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
  schedule DATETIME NOT NULL,
  pitchId INT NOT NULL,
  matchStatusId INT NOT NULL,
  club1 INT NOT NULL,
  club2 INT NOT NULL,
  PRIMARY KEY (matchId),
  FOREIGN KEY (pitchId) REFERENCES Pitch(pitchId),
  FOREIGN KEY (matchStatusId) REFERENCES matchStatus(matchStatusId)
);

CREATE TABLE Seat
(
  seatId INT IDENTITY(1,1) NOT NULL,
  seatNumber INT NOT NULL,
  price INT NOT NULL,
  areaId INT,
  seatStatusId INT NOT NULL,
  PRIMARY KEY (seatId),
  FOREIGN KEY (areaId) REFERENCES Area(areaId),
  FOREIGN KEY (seatStatusId) REFERENCES seatStatus(seatStatusId)
);

CREATE TABLE Player
(
  playerId INT IDENTITY(1,1) NOT NULL,
  playerName INT NOT NULL,
  playerNumber INT,
  dateOfBirth INT,
  height INT,
  weight INT,
  biography INT,
  playerImage NVARCHAR(200),
  countryId INT NOT NULL,
  playerRoleId INT NOT NULL,
  PRIMARY KEY (playerId),
  FOREIGN KEY (countryId) REFERENCES Country(countryId),
  FOREIGN KEY (playerRoleId) REFERENCES PlayerRole(playerRoleId)
);

CREATE TABLE Performance
(
  performanceId INT IDENTITY(1,1) NOT NULL,
  performanceName NVARCHAR(200) NOT NULL,
  level INT NOT NULL,
  playerId INT NOT NULL,
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


CREATE TABLE Ticket
(
  ticketId INT IDENTITY(100,1) NOT NULL,
  code NVARCHAR(500),
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
  UNIQUE (code)
);