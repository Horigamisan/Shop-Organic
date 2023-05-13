DROP DATABASE IF EXISTS FinalProject_NET
GO

CREATE DATABASE FinalProject_NET
GO
USE FinalProject_NET
GO

DROP TABLE IF EXISTS __MigrationHistory, AspNetUsers, AspNetRoles, AspNetUserRoles, AspNetUserClaims, AspNetUserLogins, Banner, BlogCategories,
ListCategories, Blogs, Products, Carts, Orders, OrderProduct, menu, PersonalInfo, UsefulLinks

CREATE TABLE [dbo].[__MigrationHistory] (
    [MigrationId]    NVARCHAR (150)  NOT NULL,
    [ContextKey]     NVARCHAR (300)  NOT NULL,
    [Model]          VARBINARY (MAX) NOT NULL,
    [ProductVersion] NVARCHAR (32)   NOT NULL,
    CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED ([MigrationId] ASC, [ContextKey] ASC)
);

CREATE TABLE [dbo].[AspNetUsers] (
    [Id]                   NVARCHAR (128) NOT NULL,
    [Email]                NVARCHAR (256) NULL,
    [EmailConfirmed]       BIT            NOT NULL,
    [PasswordHash]         NVARCHAR (MAX) NULL,
    [SecurityStamp]        NVARCHAR (MAX) NULL,
    [PhoneNumber]          NVARCHAR (MAX) NULL,
    [PhoneNumberConfirmed] BIT            NOT NULL,
    [TwoFactorEnabled]     BIT            NOT NULL,
    [LockoutEndDateUtc]    DATETIME       NULL,
    [LockoutEnabled]       BIT            NOT NULL,
    [AccessFailedCount]    INT            NOT NULL,
    [UserName]             NVARCHAR (256) NOT NULL,
    CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex]
    ON [dbo].[AspNetUsers]([UserName] ASC);


CREATE TABLE [dbo].[AspNetRoles] (
    [Id]            NVARCHAR (128) NOT NULL,
    [Name]          NVARCHAR (256) NOT NULL,
    [Discriminator] NVARCHAR (128) NOT NULL,
    CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex]
    ON [dbo].[AspNetRoles]([Name] ASC);


CREATE TABLE [dbo].[AspNetUserRoles] (
    [UserId] NVARCHAR (128) NOT NULL,
    [RoleId] NVARCHAR (128) NOT NULL,
    CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED ([UserId] ASC, [RoleId] ASC),
    CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[AspNetRoles] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IX_UserId]
    ON [dbo].[AspNetUserRoles]([UserId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_RoleId]
    ON [dbo].[AspNetUserRoles]([RoleId] ASC);



CREATE TABLE [dbo].[AspNetUserClaims] (
    [Id]         INT            IDENTITY (1, 1) NOT NULL,
    [UserId]     NVARCHAR (128) NOT NULL,
    [ClaimType]  NVARCHAR (MAX) NULL,
    [ClaimValue] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IX_UserId]
    ON [dbo].[AspNetUserClaims]([UserId] ASC);


CREATE TABLE [dbo].[AspNetUserLogins] (
    [LoginProvider] NVARCHAR (128) NOT NULL,
    [ProviderKey]   NVARCHAR (128) NOT NULL,
    [UserId]        NVARCHAR (128) NOT NULL,
    CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED ([LoginProvider] ASC, [ProviderKey] ASC, [UserId] ASC),
    CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IX_UserId]
    ON [dbo].[AspNetUserLogins]([UserId] ASC);


CREATE TABLE [dbo].[Banner] (
    [id]               INT            NOT NULL,
    [name]             NVARCHAR (50)  NULL,
    [img]              NVARCHAR (50)  NULL,
    [description]      NVARCHAR (MAX) NULL,
    [main_description] NVARCHAR (MAX) NULL,
    [detail]           NTEXT          NULL,
    [meta]             NVARCHAR (MAX) NULL,
    [hide]             BIT            NULL,
    [order]            INT            NULL,
    [datebegin]        SMALLDATETIME  NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

CREATE TABLE [dbo].[BlogCategories] (
    [id]        INT            NOT NULL,
    [name]      NVARCHAR (50)  NULL,
    [link]      NVARCHAR (MAX) NULL,
    [meta]      NVARCHAR (50)  NULL,
    [hide]      BIT            NULL,
    [order]     INT            NULL,
    [datebegin] SMALLDATETIME  NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

CREATE TABLE [dbo].[ListCategories] (
    [id]        INT            NOT NULL,
    [name]      NVARCHAR (50)  NULL,
    [img]       NVARCHAR (50)  NULL,
    [link]      NVARCHAR (MAX) NULL,
    [meta]      NVARCHAR (50)  NULL,
    [hide]      BIT            NULL,
    [order]     INT            NULL,
    [datebegin] SMALLDATETIME  NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

CREATE TABLE [dbo].[Blogs] (
    [id]          INT            NOT NULL,
    [name]        NVARCHAR (50)  NULL,
    [detail]      NVARCHAR (MAX) NULL,
    [description] NVARCHAR (MAX) NULL,
    [comments]    INT            NULL,
    [dateupload]  NVARCHAR (50)  NULL,
    [meta]        NVARCHAR (50)  NULL,
    [hide]        BIT            NULL,
    [order]       INT            NULL,
    [datebegin]   SMALLDATETIME  NULL,
    [img]         NVARCHAR (50)  NULL,
    [categoryid]  INT            NULL,
    [author]      NVARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

CREATE TABLE [dbo].[Products] (
    [id]                 INT            IDENTITY (1, 1) NOT NULL,
    [name]               NVARCHAR (50)  NULL,
    [price]              FLOAT (53)     NULL,
    [img]                NVARCHAR (50)  NULL,
    [description]        NTEXT          NULL,
    [meta]               NVARCHAR (MAX) NULL,
    [hide]               BIT            NULL,
    [order]              INT            NULL,
    [datebegin]          SMALLDATETIME  NULL,
    [categoryid]         INT            NULL,
    [reviews_number]     INT            NULL,
    [availability]       NVARCHAR (50)  DEFAULT (N'Còn hàng') NULL,
    [shipping_day]       NVARCHAR (30)  NULL,
    [weight]             NVARCHAR (30)  NULL,
    [detail_description] NVARCHAR (MAX) NULL,
    [review_comment]     NVARCHAR (MAX) NULL,
    [latest_product]     BIT            NULL,
    [top_product]        BIT            NULL,
    [review_product]     BIT            NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

CREATE TABLE [dbo].[Carts] (
    [CartID]    INT            IDENTITY (1, 1) NOT NULL,
    [UserID]    NVARCHAR (128) NULL,
    [ProductID] INT            NULL,
    [Quantity]  INT            NULL,
    [Price]     FLOAT (53)     NULL,
    [Status]    NVARCHAR (30)  NULL,
    PRIMARY KEY CLUSTERED ([CartID] ASC),
    FOREIGN KEY ([UserID]) REFERENCES [dbo].[AspNetUsers] ([Id]),
    FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Products] ([id])
);

CREATE TABLE [dbo].[Orders] (
    [OrderID]         INT            IDENTITY (1, 1) NOT NULL,
    [OrderDate]       DATETIME       NULL,
    [UserID]          NVARCHAR (128) NULL,
    [NameCustomer]    NVARCHAR (MAX) NULL,
    [ShippingAddress] NVARCHAR (MAX) NULL,
    [PhoneNumber]     NVARCHAR (MAX) NULL,
    [NoteOrder]       NVARCHAR (MAX) NULL,
    [TotalAmount]     FLOAT (53)     NULL,
    [PaymentStatus]   NVARCHAR (128) NULL,
    PRIMARY KEY CLUSTERED ([OrderID] ASC),
    FOREIGN KEY ([UserID]) REFERENCES [dbo].[AspNetUsers] ([Id])
);

CREATE TABLE [dbo].[OrderProduct] (
    [OrderProductID] INT        IDENTITY (1, 1) NOT NULL,
    [OrderID]        INT        NULL,
    [ProductID]      INT        NULL,
    [Quantity]       INT        NULL,
    [Price]          FLOAT (53) NULL,
    PRIMARY KEY CLUSTERED ([OrderProductID] ASC),
    FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Products] ([id]),
    FOREIGN KEY ([OrderID]) REFERENCES [dbo].[Orders] ([OrderID])
);



CREATE TABLE menu (
  id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  name NVARCHAR(50),
  link NVARCHAR(MAX),
  meta NVARCHAR(50),
  hide BIT DEFAULT 0,
  [order] INT DEFAULT 0,
  datebegin SMAllDATETIME
);

CREATE TABLE [dbo].[PersonalInfo] (
    [id]        INT           IDENTITY (1, 1) NOT NULL,
    [phone]     NVARCHAR (11) NULL,
    [address]   NVARCHAR (50) NULL,
    [opentime]  NVARCHAR (50) NULL,
    [email]     NVARCHAR (50) NULL,
    [meta]      NVARCHAR (50) NULL,
    [hide]      BIT           DEFAULT ((0)) NULL,
    [order]     INT           DEFAULT ((0)) NULL,
    [datebegin] SMALLDATETIME NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

CREATE TABLE UsefulLinks(
	id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  name NVARCHAR(50),
  link NVARCHAR(MAX),
  meta NVARCHAR(50),
  hide BIT DEFAULT 0,
  [order] INT DEFAULT 0,
  datebegin SMAllDATETIME
)
--add to list categories
INSERT INTO [dbo].[ListCategories] ([id], [name], [img], [link], [meta], [hide], [order], [datebegin])
VALUES
(1, N'Trái cây tươi', 'cat-1.jpg', NULL, 'trai-cay-tuoi', 0, NULL, NULL),
(2, N'Trái cây sấy', 'cat-2.jpg', NULL, 'trai-cay-say', 0, NULL, NULL),
(3, N'Rau củ', 'cat-3.jpg', NULL, 'rau-cu', 0, NULL, NULL),
(4, N'Nước ép', 'cat-4.jpg', NULL, 'nuoc-ep', 0, NULL, NULL),
(5, N'Thịt tươi', 'cat-5.jpg', NULL, 'thit-tuoi', 0, NULL, NULL)

--add to blog categories
INSERT INTO [dbo].[BlogCategories] ([id], [name], [link], [meta], [hide], [order], [datebegin])
VALUES
    (1, N'Làm đẹp', NULL, 'lam-dep', 0, NULL, NULL),
    (2, N'Đồ ăn', NULL, 'do-an', 0, NULL, NULL),
    (3, N'Đời sống', NULL, 'doi-song', 0, NULL, NULL),
    (4, N'Du lịch', NULL, 'du-lich', 0, NULL, NULL);

--add to UsefulLinks
INSERT INTO UsefulLinks (name, link, meta, hide,[order],datebegin)
VALUES (N'Về chúng tôi', '/about-us', 've-chung-toi', 0, 1, '2023-02-22');
INSERT INTO UsefulLinks (name, link, meta, hide,[order],datebegin)
VALUES (N'Về cửa hàng chúng tôi', '/about-our-shop', 'cua-hang-chung-toi', 0, 1, '2023-02-22');
INSERT INTO UsefulLinks (name, link, meta, hide,[order],datebegin)
VALUES (N'Mua sắm an toàn', '/secure-shopping', 'mua-sam-an-toan', 0, 1, '2023-02-22');
INSERT INTO UsefulLinks (name, link, meta, hide,[order],datebegin)
VALUES (N'Thông tin vận chuyển', '/delivery-info', 'thong-tin-van-chuyen', 0, 1, '2023-02-22');
INSERT INTO UsefulLinks (name, link, meta, hide,[order],datebegin)
VALUES (N'Chính sách quyền riêng tư', '/privacy-policy', 'chinh-sach-quyen-rieng-tu', 0, 1, '2023-02-22');
INSERT INTO UsefulLinks (name, link, meta, hide,[order],datebegin)
VALUES (N'Các liên kết khác', '/our-sitemap', 'cac-lien-ket-khac', 0, 1, '2023-02-22');
INSERT INTO UsefulLinks (name, link, meta, hide,[order],datebegin)
VALUES (N'Chúng tôi là ai', '/who-we-are', 'chung-toi-la-ai', 0, 1, '2023-02-22');
INSERT INTO UsefulLinks (name, link, meta, hide,[order],datebegin)
VALUES (N'Dịch vụ', '/our-service', 'dich-vu-cua-chung-toi', 0, 1, '2023-02-22');
INSERT INTO UsefulLinks (name, link, meta, hide,[order],datebegin)
VALUES (N'Các dự án', '/projects', 'cac-du-an', 0, 1, '2023-02-22');
INSERT INTO UsefulLinks (name, link, meta, hide,[order],datebegin)
VALUES (N'Liên hệ', '/contact', 'lien-he', 0, 1, '2023-02-22');
INSERT INTO UsefulLinks (name, link, meta, hide,[order],datebegin)
VALUES (N'Sự đổi mới', '/innovation', 'su-doi-moi', 0, 1, '2023-02-22');
INSERT INTO UsefulLinks (name, link, meta, hide,[order],datebegin)
VALUES (N'Lời chứng thực', '/testimonials', 'loi-chung-thuc', 0, 1, '2023-02-22');

--add to Products
Insert into Products Values (N'Nho',12000,N'product-4.jpg',NULL,N'trai-cay-tuoi',0,4,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0);
Insert into Products Values (N'Thịt heo tươi', 40000, N'product-1.jpg', N'Thịt heo tươi từ lò', N'thit-heo-tuoi', 0, 2, NULL, 5, 20, N'Hết hàng', N'12 tiếng giao hàng', N'0.5 kg', N'Đây là thông tin chi tiết của thịt heo tươii', N'Đây là phần comment của thịt heo tươi', 0, 0, 0);
INSERT INTO Products (Name, Price, img, description, meta, hide, [order], datebegin, categoryid, reviews_number, availability,[shipping_day]
      ,[weight]
      ,[detail_description]
      ,[review_comment]
      ,[latest_product]
      ,[top_product]
      ,[review_product])
VALUES
(N'Ổi', 15000, N'product-3.jpg', NULL, N'trai-cay-tuoi', 0, 3, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 1),
(N'Nho', 12000, N'product-4.jpg', NULL, N'trai-cay-tuoi', 0, 4, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0),
(N'Hamburger', 45000, N'product-5.jpg', NULL, N'hamburger', 0, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 1),
(N'Xoài', 12000, N'product-6.jpg', NULL, N'trai-cay-tuoi', 0, 6, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0),
(N'Dưa hấu', 30000, N'product-7.jpg', NULL, N'trai-cay-tuoi', 0, 7, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 1),
(N'Táo', 10000, N'product-8.jpg', NULL, N'trai-cay-tuoi', 0, 8, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0),
(N'Nước ép nho', 35000, N'product-9.jpg', NULL, N'nuoc-ep', 0, 9, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 1),
(N'Nước ép cam', 30000, N'product-11.jpg', NULL, N'nuoc-ep', 0, 10, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0),
(N'Chuối', 20000, N'10-04-23-12-00-25-product-2.jpg', N'Đây là chuối', N'chuoi', 0, 7, '2023-04-10 00:00:00',1,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0)


--add to Banner
INSERT INTO Banner ([id], [name], [img], [description], [main_description], [detail], [meta], [hide], [order], [datebegin])
VALUES (1, N'TRÁI CÂY TƯƠI', N'banner.jpg', N'Thực phẩm 100% thực vật', N'Miễn phí vận chuyển', NULL, NULL, 0, 1, '2023-03-01 00:00:00');

--add to PersonalInfo
INSERT INTO PersonalInfo ([phone], [address], [opentime], [email], [meta], [hide], [order], [datebegin])
VALUES (N'093123131', N'Đại Học Tôn Đức Thắng', N'9:00 sáng tới 6:00 chiều', N'whoami@gmail.com', NULL, 0, 0, NULL);

--add to menu
INSERT INTO [dbo].[menu] ([name], [link], [meta], [hide], [order], [datebegin])
VALUES (N'Trang chủ', '/trang-chu', 'trang-chu', 0, 1, '2023-02-22 00:00:00');

INSERT INTO [dbo].[menu] ([name], [link], [meta], [hide], [order], [datebegin])
VALUES (N'Cửa hàng', '/cua-hang', 'cua-hang', 0, 2, '2023-02-22 00:00:00');

INSERT INTO [dbo].[menu] ([name], [link], [meta], [hide], [order], [datebegin])
VALUES (N'Blog', '/blog', 'blog', 0, 3, '2023-02-22 00:00:00');

INSERT INTO [dbo].[menu] ([name], [link], [meta], [hide], [order], [datebegin])
VALUES (N'Liên hệ', '/lien-he', 'lien-he', 0, 4, '2023-02-22 00:00:00');



--add to blog
INSERT INTO [dbo].[Blogs] ([id],[name], [detail], [description], [comments], [dateupload], [meta], [hide], [order], [datebegin], [img], [categoryid], [author])
VALUES (1, N'6 cách để nấu bữa sáng', N'
	<h5>6 c&aacute;ch để nấu bữa s&aacute;ng</h5>

<p>Nếu bạn đang t&igrave;m kiếm những &yacute; tưởng cho bữa s&aacute;ng ngon miệng v&agrave; bổ dưỡng, dưới đ&acirc;y l&agrave; 6 c&aacute;ch để nấu bữa s&aacute;ng đ&aacute;ng thử.</p>

<ol>
	<li>
	<h2>Rau củ v&agrave; trứng rang</h2>

	<p>Kết hợp c&aacute;c loại rau củ tươi ngon như c&agrave; rốt, cải b&oacute; x&ocirc;i, củ cải với trứng rang l&agrave; một c&aacute;ch tuyệt vời để bắt đầu ng&agrave;y mới. Rau củ cung cấp chất xơ v&agrave; dinh dưỡng, trong khi trứng chứa nhiều protein.</p>
	</li>
	<li>
	<h2>B&aacute;nh m&igrave; sandwich thịt chảy</h2>

	<p>Chuẩn bị một ổ b&aacute;nh m&igrave; tươi, th&ecirc;m v&agrave;o một lớp thịt chảy như thịt nguội, ph&ocirc; mai, x&uacute;c x&iacute;ch, v&agrave; nướng l&ecirc;n cho đến khi ph&ocirc; mai chảy ra. B&aacute;nh m&igrave; sandwich thịt chảy l&agrave; một m&oacute;n ăn ngon v&agrave; nhanh ch&oacute;ng cho buổi s&aacute;ng.</p>
	</li>
	<li>
	<h2>Ch&aacute;o yến mạch</h2>

	<p>Ch&aacute;o yến mạch l&agrave; một m&oacute;n ăn bổ dưỡng v&agrave; dễ l&agrave;m. H&ograve;a quyện yến mạch, sữa, một ch&uacute;t mật ong v&agrave; c&aacute;c loại hạt, bạn c&oacute; thể tạo ra một b&aacute;t ch&aacute;o thơm ngon v&agrave; gi&agrave;u dinh dưỡng.</p>
	</li>
	<li>
	<h2>B&aacute;nh mỳ nướng trứng</h2>

	<p>Lấy một ổ b&aacute;nh mỳ, cắt ra một ổ nửa v&agrave; đặt trứng v&agrave;o. Nướng trong l&ograve; cho đến khi trứng ch&iacute;n v&agrave; b&aacute;nh mỳ v&agrave;ng rụm. B&aacute;nh mỳ nướng trứng l&agrave; một lựa chọn đơn giản nhưng ngon miệng.</p>
	</li>
	<li>
	<h2>Smoothie tr&aacute;i c&acirc;y</h2>

	<p>Chuẩn bị một số tr&aacute;i c&acirc;y tươi ngon như chuối, dứa, d&acirc;u t&acirc;y, v&agrave; cam, sau đ&oacute; xay nhuyễn ch&uacute;ng với sữa, , đ&aacute; v&agrave; một &iacute;t mật ong. Bạn sẽ c&oacute; một cốc smoothie tr&aacute;i c&acirc;y tươi m&aacute;t, gi&agrave;u vitamin v&agrave; chất xơ.</p>
	</li>
	<li>
	<h2>B&aacute;nh mỳ nướng với mứt</h2>

	<p>Nếu bạn muốn c&oacute; một bữa s&aacute;ng ngọt ng&agrave;o, h&atilde;y thử b&aacute;nh mỳ nướng kết hợp với mứt y&ecirc;u th&iacute;ch của bạn. Chỉ cần lấy một ổ b&aacute;nh mỳ, thoa một lớp mứt l&ecirc;n v&agrave; nướng cho đến khi mứt tan chảy v&agrave; b&aacute;nh mỳ v&agrave;ng rụm.</p>
	</li>
</ol>

', N'Có nhiều cách để nấu ăn...', 7, N'March 2, 2023', N'6-cach-de-nau-bua-sang', 0, NULL, NULL,N'blog-2.jpg', 2, N'Phuc Nguyen');

INSERT INTO [dbo].[Blogs] ([id],[name], [detail], [description], [comments], [dateupload], [meta], [hide], [order], [datebegin], [img], [categoryid], [author])
VALUES (2, N'Tham quan trang trại tại Việt Nam', N'
	 <h1>Tham quan trang trại tại Việt Nam: Khám phá nền nông nghiệp đa dạng và bền vững</h1>
    <p>
        Việt Nam, với sự đa dạng về địa hình và khí hậu, là một quốc gia giàu có tiềm năng trong lĩnh vực nông nghiệp.
        Tham quan trang trại tại Việt Nam là một trải nghiệm tuyệt vời để khám phá cách mà đất nước này nuôi trồng và
        sản xuất các loại nông sản đa dạng.
    </p>
    <p>
        Khi tham quan trang trại tại Việt Nam, bạn sẽ có cơ hội tương tác trực tiếp với các nông dân địa phương và được hướng dẫn
        bởi những chuyên gia nông nghiệp địa phương. Bạn sẽ được tìm hiểu về quy trình trồng trọt, chăm sóc cây trồng và nuôi thú cưng,
        cũng như những phương pháp và công nghệ mới nhất trong lĩnh vực nông nghiệp.
    </p>
    <p>
        Trang trại tại Việt Nam đa dạng với các mô hình khác nhau, từ trang trại hữu cơ, trang trại thủy canh, trang trại chăn nuôi đến trang trại trồng rau sạch.
        Bạn có thể khám phá những cánh đồng mênh mông, những vườn trái cây bạt ngàn hay những trang trại chăn nuôi đặc biệt.
        Thông qua việc tham quan, bạn có thể hiểu rõ hơn về quá trình sản xuất nông sản và tầm quan trọng của nông nghiệp đối với đời sống và kinh tế của Việt Nam.
    </p>
    <p>
        Bên cạnh việc học hỏi và tìm hiểu, tham quan trang trại cũng mang lại những trải nghiệm đáng nhớ. Bạn có thể tham gia vào các hoạt động như hái rau, thu hoạch trái cây,
        tham gia trò chơi trang trại hoặc thậm chí trải nghiệm cuộc sống nông thôn qua việc ở lại homestay tại một số trang trại.
    </p>
', N'Có nhiều cách để chúng ta...', 8, N'March 2, 2023', N'tham-quan-trang-trai-tai-viet-nam', 0, NULL, NULL,N'blog-3.jpg', 2, N'Phuc Nguyen');

INSERT INTO [dbo].[Blogs] ([id],[name], [detail], [description], [comments], [dateupload], [meta], [hide], [order], [datebegin], [img], [categoryid], [author])
VALUES (3, N'Những mẹo giúp bạn nấu ăn dễ dàng hơn', N'Những mẹo giúp bạn nấu ăn dễ dàng hơn', N'Có nhiều cách để nấu ăn...', 6, N'March 2, 2023', N'nhung-meo-giup-ban-nau-an-de-dang-hon', 0, NULL, NULL,N'blog-1.jpg', 1, N'Phuc Nguyen');