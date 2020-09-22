
use master
go

drop database Stream13

go

create database Stream13

go

use	Stream13

go



create table tbLoginWeb(
IdLoginWeb  int identity primary key,
Nome		VarChar(50),
Email		VarChar(100),
senha		VarChar(100),

)

go

Create table tbNivelAcesso(
	IdNivelAcesso	int identity primary key not null,
	NomeNivel		VarChar(20) not null,
	AbrevNivel		VarChar(3) not null,
	StatusNivel		bit not null

)
go

Create table tbFuncionario(
	IDFuncionario	int identity primary key not null,
	StatusFunc		bit not null, 
	Nome			VarChar(50) not null,
	Foto			VarChar(max),
	Sexo			int,
	DataNascimento	date not null,
	Rg				VarChar(15) not null,
	Cpf				Char(11) not null,
	TelefoneCel		Char(11),			
	E_mail			VarChar(100),
	Cep				Varchar(8) not null,
	Complemento		Varchar(50),
	IdNivelAcesso	Integer,
	--

)
go

Alter Table tbFuncionario
ADD Constraint	fk_funcniv	Foreign key (IdNivelAcesso) References tbNivelAcesso (IdNivelAcesso)
GO

create Table tbUsuario(
	IdUsuario			int identity primary key not null,
	Usuario				VarChar(50) not null,
	Email				VarChar(100)not null,
	Senha				VarChar(100) not null,	
	Sexo				VarChar(1),
	Foto				VarChar(max),
	Nacionalidade		VarChar(20),
	StatusUsu			 bit,-- ativo inativo
	IdNivelAcesso		integer

)
go

Alter Table tbUsuario
ADD Constraint	fk_usuniv	Foreign key (IdNivelAcesso) References tbNivelAcesso (IdNivelAcesso)
GO






Create Table tbGenero(

	IdGenero	int identity primary key not null,
	Nome		VarChar(20),
	StatusGen	bit
)
go


create TABLE tbGravadora(

	IdGravadora		int identity primary key not null,
	NomeFantasia	VarChar(50),
	RazãoSocial		VarChar(50),
	Cnpj			VarChar(14),
	FoneContato 	VarChar(11),
	Email			Varchar(100),
	QtdMusicasForn  int,
	QtdBanda		int,
	StatusGrava		bit,-- ativo inativo

)
go





Create Table tbArtista(
	
	IdArtista		int identity primary key not null,
	Nome		VarChar(50),--nome da banda ou do artista solo
	QtdInteg	int,--qtdIntegrantes
	StatusBanda	bit,-- ativo inativo
	Descricao	VarChar(max), 
	IdGravadora	integer
)
go


Alter Table tbArtista
ADD Constraint	fk_bangra	Foreign key (IdGravadora) References tbGravadora (IdGravadora)
GO


create Table tbMusica(

	IdMusica		int identity primary key not null,
	Nome			VarChar(50),
	Imagem			VarChar(max),
	Localizacao		VarChar(max),
	DataLancamento	Date,
	StatusMusic		bit,-- ativo inativo
	IdGenero		int,
	IdGravadora		int,-- já existe no artista
	IdArtista		int



)
GO
select*from tbmusica
go


Alter Table tbMusica
ADD Constraint	fk_musgen	Foreign key (IdGenero) References tbGenero (IdGenero)
GO	

Alter Table tbMusica
ADD Constraint	fk_musgra	Foreign key (IdGravadora) References tbGravadora (IdGravadora)
GO





Create table tbFeat(
IdFeat	int identity primary key not null,
IdMusica			integer,
IdArtista		integer,


)
go


Alter Table tbFeat
ADD Constraint	fk_musFeat	Foreign key (IdMusica) References tbMusica (IdMusica)
GO

 

Alter Table tbFeat
ADD Constraint	fk_artFeat	Foreign key (IdArtista) References tbArtista (IdArtista)
GO






Alter Table tbMusica
ADD Constraint	fk_musban	Foreign key (IdArtista) References tbArtista (IdArtista)
GO


create table tbPlaylist	(
	
 IDPlaylist		int identity primary key not null,
 nomePlay		VarChar(50),
 IdLoginWeb		integer,
 imagem		varchar(max) DEFAULT '~/Content/IMG/Logo1.png'


)
go



Alter Table tbPlaylist
ADD Constraint	fk_plausu	Foreign key (IdLoginWeb) References tbLoginWeb (IdLoginWeb)
GO






create Table tbAlbum(
 IdAlbum		int identity primary key not null,
 NomeAlbum		varchar(50),
 Imagem			varchar(max),
 DataLancamento date,
 Descricao		varchar(max),
 IdArtista		integer,
 statusAlbum	bit default 1


)
go

Alter Table tbAlbum
ADD Constraint	fk_albart	Foreign key (IdArtista) References tbArtista (IdArtista)
GO



Create table tbMusicaAlbum(
IdMusicaAlbum	int identity primary key not null,
IdAlbum			integer,
IdMusica		integer,


)
go


Alter Table tbMusicaAlbum
ADD Constraint	fk_mus	Foreign key (IdMusica) References tbMusica (IdMusica)
GO

 

Alter Table tbMusicaAlbum
ADD Constraint	fk_alb	Foreign key (IdAlbum) References tbAlbum (IdAlbum)
GO


select * from tbmusicaalbum

Create table tbMusicaPlay(
IdMusicaPlay	int identity primary key not null,
IdPlaylist			integer,
IdMusica		integer,
IdLoginWeb		integer,

)
go


Alter Table tbMusicaPlay
ADD Constraint	fk_usuplay	Foreign key (IdLoginWeb) References tbLoginWeb (IdLoginWeb)
GO


Alter Table tbMusicaPlay
ADD Constraint	fk_musplay	Foreign key (IdMusica) References tbMusica (IdMusica)
GO

 

Alter Table tbMusicaPlay
ADD Constraint	fk_albplay	Foreign key (IdPlaylist) References tbPlaylist (IdPlaylist)
GO



create table tbMusicaRejeitada(

	IdMusicaRejeitada		int identity primary key not null,
	Nome			VarChar(50),
	IdMusica		integer,	
	Usuario		VarChar(50)
)
go

create table tbFaleConosco(
IdFale	int primary key identity,
Email	varchar(50),
Assunto	varchar(50),
Mensagem	varchar(50),
dataEnvio	datetime default getdate(),
Resposta	varchar(100),
statusfal	bit,

)
go


go
INSERT INTO tbNivelAcesso (NomeNivel,AbrevNivel,StatusNivel) VALUES ('Administrador','ADM',1)
go
INSERT INTO tbNivelAcesso (NomeNivel,AbrevNivel,StatusNivel) VALUES ('Ouvinte','OUV',1)
go
INSERT INTO tbNivelAcesso (NomeNivel,AbrevNivel,StatusNivel) VALUES ('Gravadora','GRA',1)
go

INSERT INTO tbUsuario (Usuario,Email,Senha,Sexo,Foto,Nacionalidade,StatusUsu,IdNivelAcesso) VALUES ('Suntail','st@gmail.com','123456','M','/adas/asdasd','Brasileiro',1,1)
go
INSERT INTO tbUsuario (Usuario,Email,Senha,Sexo,Foto,Nacionalidade,StatusUsu,IdNivelAcesso) VALUES ('Caio27093','caio@gmail.com','123456','M','/adas/asdasd','Brasileiro',1,1)
go
INSERT INTO tbUsuario (Usuario,Email,Senha,Sexo,Foto,Nacionalidade,StatusUsu,IdNivelAcesso) VALUES ('Kuuhaku27093','kuuhaku@gmail.com','123456','F','/adas/asdasd','Brasileiro',0,1)
go

SELECT * FROM tbUsuario WHERE StatusUsu=1 ORDER BY Usuario
go
SELECT * FROM tbUsuario WHERE StatusUsu=0 ORDER BY Usuario
go

UPDATE  tbUsuario SET Usuario='Kuuhaku27093', Email='kuuhaku@gmail.com', Senha='123456',Sexo='M', Foto='C:/CAIO/123', Nacionalidade='Brasiseiro', StatusUsu=1, IdNivelAcesso=1 where IdUsuario=3
go
SELECT * FROM tbUsuario
go


INSERT INTO tbGravadora (NomeFantasia,RazãoSocial,Cnpj,FoneContato,Email,QtdMusicasForn,QtdBanda,StatusGrava) VALUES ('Music','MusicStore',82950694000100,41988914,'coca@hotmail.com',1,1,1)
go
INSERT INTO tbGravadora (NomeFantasia,RazãoSocial,Cnpj,FoneContato,Email,QtdMusicasForn,QtdBanda,StatusGrava) VALUES ('Thomas Musicas','ThomasMusicasCorp',82950694000110,41988914,'coca@hotmail.com',1,1,1)
go
INSERT INTO tbGravadora (NomeFantasia,RazãoSocial,Cnpj,FoneContato,Email,QtdMusicasForn,QtdBanda,StatusGrava) VALUES ('Music Space','Music Space inc',82950694000192,41988914,'coca@hotmail.com',1,1,1)
go
select * from tbGravadora
go

INSERT INTO tbArtista (Nome,QtdInteg,StatusBanda,Descricao,IdGravadora) VALUES ('Imagine Dragons',3,1,'É uma bando norte americana formada em 2010',1)
go
INSERT INTO tbArtista (Nome,QtdInteg,StatusBanda,Descricao,IdGravadora) VALUES ('Moon Taxi',1,1,'É um artista da alemanha que começou a fazer sucesso apartir da sua musica faded',1)
go
INSERT INTO tbArtista (Nome,QtdInteg,StatusBanda,Descricao,IdGravadora) VALUES ('Lemaitre',4,1,'é uma banda norte americana formada por 4 integrantes e esta fazendo sucesso desde 2017',1)
go
INSERT INTO tbArtista (Nome,QtdInteg,StatusBanda,Descricao,IdGravadora) VALUES ('Aron Smith',4,1,'é uma banda norte americana formada por 4 integrantes e esta fazendo sucesso desde 2017',1)
go
INSERT INTO tbArtista (Nome,QtdInteg,StatusBanda,Descricao,IdGravadora) VALUES ('Ali',4,1,'é uma banda norte americana formada por 4 integrantes e esta fazendo sucesso desde 2017',1)
go
INSERT INTO tbArtista (Nome,QtdInteg,StatusBanda,Descricao,IdGravadora) VALUES ('The Score',4,1,'é uma banda norte americana formada por 4 integrantes e esta fazendo sucesso desde 2017',1)
go
INSERT INTO tbArtista (Nome,QtdInteg,StatusBanda,Descricao,IdGravadora) VALUES ('Tokyo Ghoul',4,1,'é uma banda norte americana formada por 4 integrantes e esta fazendo sucesso desde 2017',1)
go
INSERT INTO tbArtista (Nome,QtdInteg,StatusBanda,Descricao,IdGravadora) VALUES ('Two Feet',4,1,'é uma banda norte americana formada por 4 integrantes e esta fazendo sucesso desde 2017',1)
go
INSERT INTO tbArtista (Nome,QtdInteg,StatusBanda,Descricao,IdGravadora) VALUES ('Kaleo',4,1,'é uma banda norte americana formada por 4 integrantes e esta fazendo sucesso desde 2017',1)
go
INSERT INTO tbArtista (Nome,QtdInteg,StatusBanda,Descricao,IdGravadora) VALUES ('Tones And I',4,1,'é uma banda norte americana formada por 4 integrantes e esta fazendo sucesso desde 2017',1)
go


select * from tbArtista
go


INSERT INTO tbGenero (Nome,StatusGen) VALUES ('Funk',1)
go
INSERT INTO tbGenero (Nome,StatusGen) VALUES ('Rock',1)
go
INSERT INTO tbGenero (Nome,StatusGen) VALUES ('POP',1)
go
select * from tbGenero
go


INSERT INTO tbMusica (Nome,Imagem,Localizacao,DataLancamento,StatusMusic,IdGenero,IdGravadora,IdArtista) VALUES ('Believer','https://i1.sndcdn.com/artworks-000223677261-42lpe9-t500x500.jpg','https://audio.jukehost.co.uk/f0277d0fc1c53c0247c05623c7af3a363bb69c27/575b5afd628','06/06/2012',1,1,1,1)
go
INSERT INTO tbMusica (Nome,Imagem,Localizacao,DataLancamento,StatusMusic,IdGenero,IdGravadora,IdArtista) VALUES ('Good As Gold','https://i.pinimg.com/originals/ec/f7/e9/ecf7e95188510e5d376e9f19ee244ee1.jpg','https://audio.jukehost.co.uk/p/f0277d0fc1c53c0247c05623c7af3a363bb69c27/c852c192274','06/06/2012',1,1,1,2)
go
INSERT INTO tbMusica (Nome,Imagem,Localizacao,DataLancamento,StatusMusic,IdGenero,IdGravadora,IdArtista) VALUES ('Closer','https://img.discogs.com/50K93l7M6w5-6UQpybjQ4Z3DUfI=/fit-in/600x600/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/R-9369841-1479388108-3857.jpeg.jpg','https://audio.jukehost.co.uk/f0277d0fc1c53c0247c05623c7af3a363bb69c27/062639500e2','06/06/2013',1,1,1,3)
go
INSERT INTO tbMusica (Nome,Imagem,Localizacao,DataLancamento,StatusMusic,IdGenero,IdGravadora,IdArtista) VALUES ('Dancin','https://i.pinimg.com/564x/ea/4b/8a/ea4b8ac521f1e81d01184af098c0a965.jpg','https://audio.jukehost.co.uk/f0277d0fc1c53c0247c05623c7af3a363bb69c27/0d2345e4db2','06/06/2013',1,1,1,4)
go
INSERT INTO tbMusica (Nome,Imagem,Localizacao,DataLancamento,StatusMusic,IdGenero,IdGravadora,IdArtista) VALUES ('Wild Side','https://wallpapercave.com/wp/wp4846203.jpg','https://audio.jukehost.co.uk/f0277d0fc1c53c0247c05623c7af3a363bb69c27/e5b73eec349','06/06/2014',1,1,1,5)
go
INSERT INTO tbMusica (Nome,Imagem,Localizacao,DataLancamento,StatusMusic,IdGenero,IdGravadora,IdArtista) VALUES ('Stronger','https://studiosol-a.akamaihd.net/uploadfile/letras/albuns/a/9/8/4/704531552078350.jpg','https://audio.jukehost.co.uk/f0277d0fc1c53c0247c05623c7af3a363bb69c27/a575e6272ab','06/06/2015',1,1,1,6)
go
INSERT INTO tbMusica (Nome,Imagem,Localizacao,DataLancamento,StatusMusic,IdGenero,IdGravadora,IdArtista) VALUES ('Unravel','https://pm1.narvii.com/6382/f8d7493d6e8c399312102507257e624b32c1313f_00.jpg','https://audio.jukehost.co.uk/f0277d0fc1c53c0247c05623c7af3a363bb69c27/77714580fcb','06/06/2016',1,1,1,7)
go
INSERT INTO tbMusica (Nome,Imagem,Localizacao,DataLancamento,StatusMusic,IdGenero,IdGravadora,IdArtista) VALUES ('Go Fuck Yourself','https://studiosol-a.akamaihd.net/uploadfile/letras/albuns/4/a/b/c/633951525876036.jpg','https://audio.jukehost.co.uk/f0277d0fc1c53c0247c05623c7af3a363bb69c27/755ee985c36','06/06/2017',1,1,1,8)
go
INSERT INTO tbMusica (Nome,Imagem,Localizacao,DataLancamento,StatusMusic,IdGenero,IdGravadora,IdArtista) VALUES ('Way Down We Go','https://lastfm.freetls.fastly.net/i/u/770x0/36d3290ac0dba7dc29310993be52c199.jpg','https://audio.jukehost.co.uk/f0277d0fc1c53c0247c05623c7af3a363bb69c27/be11eff71f6','06/06/2018',1,1,1,9)
go
INSERT INTO tbMusica (Nome,Imagem,Localizacao,DataLancamento,StatusMusic,IdGenero,IdGravadora,IdArtista) VALUES ('Dance Monkey','https://lastfm.freetls.fastly.net/i/u/770x0/607de08e7519449bea56ebef37ccecbb.jpg','https://audio.jukehost.co.uk/f0277d0fc1c53c0247c05623c7af3a363bb69c27/df565980a3b','06/06/2019',1,1,1,10)
go
INSERT INTO tbMusica (Nome,Imagem,Localizacao,DataLancamento,StatusMusic,IdGenero,IdGravadora,IdArtista) VALUES ('Natural','https://i1.sndcdn.com/artworks-000399291207-fz39f6-t500x500.jpg','https://audio.jukehost.co.uk/f0277d0fc1c53c0247c05623c7af3a363bb69c27/c943af0daa7','06/06/2020',1,1,1,1)
go

INSERT INTO tbAlbum (NomeAlbum,DataLancamento,Descricao,IdArtista) VALUES ('Castelos e Ruinas','08/09/2016','É um rap',1)
go
INSERT INTO tbAlbum (NomeAlbum,DataLancamento,Descricao,IdArtista) VALUES ('Tat','08/09/2016','É um rap',1)
go
INSERT INTO tbAlbum (NomeAlbum,DataLancamento,Descricao,IdArtista) VALUES ('Omenino que queria ser Deus','08/09/2016','É um rap',1)
go







create view vw_album
as
select tbAlbum.IdAlbum, tbAlbum.NomeAlbum, tbAlbum.DataLancamento, tbAlbum.Descricao, tbArtista.Nome AS Nome_Artista,tbAlbum.statusAlbum
from tbArtista inner join tbAlbum
on tbAlbum.IdArtista = tbArtista.IdArtista 
go  

  --Tela Funcionário
CREATE view vw_funcionario
as
select tbUsuario.IdUsuario, tbUsuario.Usuario, tbUsuario.Email, tbUsuario.Senha, tbUsuario.Sexo, tbUsuario.Foto, tbUsuario.Nacionalidade,
tbUsuario.StatusUsu, tbNivelAcesso.NomeNivel
from tbNivelAcesso inner join tbUsuario
on tbUsuario.IdNivelAcesso = tbNivelAcesso.IdNivelAcesso 
go
  --Tela de Artista
create view vw_artista
as
select tbArtista.IdArtista, tbArtista.Nome,	
tbArtista.QtdInteg, tbArtista.StatusBanda, tbArtista.Descricao, tbGravadora.NomeFantasia AS NomeFantasiaGravadora
from tbGravadora inner join tbArtista
on tbArtista.IdGravadora= tbGravadora.IdGravadora 
go
select * from vw_artista
select * from tbArtista
go
--Tela de Música 
create view vw_musica
as
select tbMusica.IdMusica, tbMusica.Nome AS NomeMusica,	
tbMusica.Imagem, tbMusica.Localizacao, tbMusica.DataLancamento, tbMusica.StatusMusic, tbGenero.Nome AS NomeGenero, tbGravadora.NomeFantasia AS NomeFantasiaGravadora, tbArtista.Nome AS NomeArtista
from tbGenero inner join tbMusica
on tbMusica.IdGenero= tbGenero.IdGenero  
inner join tbGravadora on tbGravadora.IdGravadora = tbMusica.IdGravadora 
inner join tbArtista on tbArtista.IdArtista = tbMusica.IdArtista 
go  
select * from vw_musica
select * from tbMusica
select * from tbAlbum

go
--Tabela Playlist


--Tabela Tocadas Recentemente



-- Tabela Artista Favorito
select * from tbmusica
select * from tbartista

select * from tbmusica

INSERT INTO tbUsuario (Usuario,Email,Senha,Sexo,Foto,Nacionalidade,StatusUsu,IdNivelAcesso) VALUES ('Caio Lima de Almeida','Admin','BB2C64E7C778C69C087544452FD61E2C','M','C:\Users\CAIO\Desktop\Streaming De Música\Users\536890.png','Brazil',1,1)
select * from tbUsuario


select * from tbmusica

SELECT * FROM vw_musica WHERE StatusMusic=0 
SELECT TOP 2 * FROM tbMusica WHERE StatusMusic=0

go
create view vw_musica_tocada
as
select row_number() OVER(ORDER BY IdMusica) AS identificador, * from tbMusica where statusmusic = 0
go
select * from vw_musica_tocada where identificador = 3

go

select * from tbUsuario
go
create view vw_musica_tocada1
as
select row_number() OVER(ORDER BY IdMusica) AS identificador, * from vw_musica where statusmusic = 0
go
select * from vw_musica_tocada1 where identificador = 3
go
select count(IdMusica) qtdmusica from vw_musica_tocada1
select * from tbmusica
select * from tbMusicaRejeitada

go


select * from tbAlbum






select COUNT(idMusica) AS Mus2001 from tbMusica where  DataLancamento > '01/01/2001'  AND DataLancamento < '01/01/2002' --2001
select COUNT(idMusica) AS Mus2002 from tbMusica where  DataLancamento > '01/01/2002'  AND DataLancamento < '01/01/2003' --2002
select COUNT(idMusica) AS Mus2003 from tbMusica where  DataLancamento > '01/01/2003'  AND DataLancamento < '01/01/2004' --2003
select COUNT(idMusica) AS Mus2004 from tbMusica where  DataLancamento > '01/01/2004'  AND DataLancamento < '01/01/2005' --2004
select COUNT(idMusica) AS Mus2005 from tbMusica where  DataLancamento > '01/01/2005'  AND DataLancamento < '01/01/2006' --2005
select COUNT(idMusica) AS Mus2006 from tbMusica where  DataLancamento > '01/01/2006'  AND DataLancamento < '01/01/2007' --2006
select COUNT(idMusica) AS Mus2007 from tbMusica where  DataLancamento > '01/01/2007'  AND DataLancamento < '01/01/2008' --2007
select COUNT(idMusica) AS Mus2008 from tbMusica where  DataLancamento > '01/01/2008'  AND DataLancamento < '01/01/2009' --2008
select COUNT(idMusica) AS Mus2009 from tbMusica where  DataLancamento > '01/01/2009'  AND DataLancamento < '01/01/2010' --2009
select COUNT(idMusica) AS Mus2010 from tbMusica where  DataLancamento > '01/01/2010'  AND DataLancamento < '01/01/2011' --2010
select COUNT(idMusica) AS Mus2011 from tbMusica where  DataLancamento > '01/01/2011'  AND DataLancamento < '01/01/2012' --2011
select COUNT(idMusica) AS Mus2012 from tbMusica where  DataLancamento > '01/01/2012'  AND DataLancamento < '01/01/2013' --2012
select COUNT(idMusica) AS Mus2013 from tbMusica where  DataLancamento > '01/01/2013'  AND DataLancamento < '01/01/2014' --2013
select COUNT(idMusica) AS Mus2014 from tbMusica where  DataLancamento > '01/01/2014'  AND DataLancamento < '01/01/2015' --2014
select COUNT(idMusica) AS Mus2015 from tbMusica where  DataLancamento > '01/01/2015'  AND DataLancamento < '01/01/2016' --2015
select COUNT(idMusica) AS Mus2016 from tbMusica where  DataLancamento > '01/01/2016'  AND DataLancamento < '01/01/2017' --2016
select COUNT(idMusica) AS Mus2017 from tbMusica where  DataLancamento > '01/01/2017'  AND DataLancamento < '01/01/2018' --2017

select COUNT(idMusica) AS Mus2018 from tbMusica where  DataLancamento > '01/01/2018'  AND DataLancamento < '01/01/2019' --2018


select COUNT(idMusica) AS Mus2019 from tbMusica where  DataLancamento > '01/01/2019'  AND DataLancamento < '01/01/2020' --2019





-- coisas para adicionar no web quando for segunda-feira
-- Adicionar no desk a imagem do Album




go

create view vw_AlbumWeb
as
select tbAlbum.IdAlbum, tbAlbum.NomeAlbum, tbAlbum.DataLancamento,tbAlbum.descricao,tbArtista.Nome as NomeArtista,tbAlbum.Imagem
from tbAlbum inner join tbArtista
on tbArtista.idArtista= tbAlbum.IdArtista  

go

select * from vw_AlbumWeb

go

create view vw_Musicas_doAlbum
as
select tbMusicaAlbum.IdMusicaAlbum,tbAlbum.idAlbum,tbAlbum.NomeAlbum,tbMusica.Nome as Nomemusica,tbMusica.Imagem,tbMusica.Localizacao
from tbMusicaAlbum inner join tbMusica
on tbMusica.IdMusica = tbMusicaAlbum.idMusica
inner join tbAlbum
on tbAlbum.IdAlbum = tbMusicaAlbum.IdAlbum

go

select * from vw_Musicas_doAlbum



--					AAAA	AAAA
--					AAAA	AAAA
--				AAAA	AAAA
--				AAAA	AAAA
--			AAAA	AAAA					VULGO COMENTARIO
--			AAAA	AAAA
--		AAAA	AAAA
--		AAAA	AAAA
--	AAAA	AAAA
--	AAAA	AAAA



go



create view vw_Musicas_dasPlaylists
as
select tbMusicaPlay.IdMusicaPlay,tbPlaylist.nomePlay,tbMusica.Nome as Nomemusica,tbMusica.Imagem,tbMusica.Localizacao,tbLoginWeb.IdLoginWeb,tbplaylist.IdPlaylist
from tbMusicaPlay 
inner join tbPlaylist
on tbPlaylist.IDPlaylist= tbMusicaPlay.IdPlaylist
inner join tbMusica
on tbMusica.IdMusica = tbMusicaPlay.IdMusica  
inner join tbLoginWeb
on tbLoginWeb.IdLoginWeb = tbMusicaPlay.IdLoginWeb  


go

select * from tbMusicaPlay

select * from vw_Musicas_dasPlaylists
go

-- NAO PRECISA DE INNER JOIN PARA PEGAR AS INFORMAÇOES DA TABELA DE PLAYLIST -- edit 2 agr precisa o porra

go
create view vw_Playweb
as
select tbPlaylist.IDPlaylist,tbPlaylist.nomePlay,tbloginweb.Nome,tbPlaylist.imagem
from tbPlaylist 
inner join tbloginweb
on tbloginweb.IdLoginWeb= tbPlaylist.IdLoginWeb  


go

select * from vw_Playweb
go

select * from tbPlaylist



go


select * from tbAlbum
go
select * from tbArtista
go


create view vw_musicaweb
as
select mu.Idmusica, mu.nome as nomemusica,mu.imagem,mu.localizacao,a.nome as nomeartista,a.descricao
from tbmusica mu inner join tbartista a on mu.IdArtista = a.idartista
go


select * from vw_musicaweb

insert into tbLoginWeb values('kuuhaku27093','adm','123')
select * from tbloginweb

delete tbalbum
select * from vw_Musicas_dasPlaylists
select * from tbPlaylist
insert into tbPlaylist values('Teste',1,'~/Content/IMG/Logo3.jpg')



select * from tbMusicaPlay
insert into tbMusicaPlay values(1,1,1)

select * from tbloginweb

sp_help

select * from tbUsuario


delete from tbAlbum where IdAlbum = 1
select * from tbAlbum
select * from tbFuncionario
insert into tbFuncionario VALUES(1,'Caio','c:/',1,'08/09/2001','391415682','43309052800','11','caio.lima337hotmail.com','06412140','a',1)
select * from tbFaleConosco where statusfal =0
insert into tbFaleConosco values('caio.lima337@hotmail.com','quero me matar','okay',08/09/2001,null,1)
UPDATE  tbFaleConosco SET Email='caio.lima337@hotmail.com',Assunto='quero me matar',Mensagem='okay',dataEnvio=08/09/2001, Resposta='hola',statusfal=0 where IdFale=4

select * from tbMusica
select * from tbLoginWeb
select * from tbGravadora
select * from tbalbum
select * from vw_AlbumWeb
select * from vw_Playweb
select @@CONNECTIONS
select * from tbMusicaAlbum
select * from tbAlbum
select * from tbLoginWeb