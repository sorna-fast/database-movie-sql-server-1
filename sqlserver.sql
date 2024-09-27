use master
---ساخت دیتا بس


create database Media
use Media
--===============================================================================================================================
----------------------------------
---ژانر ها
create table Ganre(
	id_Ganre tinyint primary key identity not null,
	Name_Ganre nvarchar(50) not null
	
)
-----------
--تایپ فیلم که از سریال یا سینمایی یا انیمه
create table [type_media](
		media_type_Id tinyint primary key identity not null ,
		media_type nvarchar(50) not null)


-----------------
--تیبیل رسانه
create table medias(
		Id_media Bigint primary key identity not null,
		Name_media nvarchar(50) not null,
		[Description] nvarchar(MAX) Sparse,
		awards nvarchar(50) null,
		publication date null,
		Score tinyint Sparse,
		Id_genre tinyint null,
		[type_id] tinyint null,
		Time_media smallint null,
		[Language] nvarchar(50) Sparse,
		Foreign Key (Id_genre) References Ganre(id_Ganre) on delete set null ,
		Foreign Key ([type_id]) References [type_media](media_type_Id) on delete set null
);

---------------
--اسم های عوامل رسانه ها
create table Agent(
	Id_Agents int primary key identity not null,
	Name_Agents nvarchar(50) not null)

------------------------------
--اون فرد چه نقشی داره بازیگره یا نویسنده 
create table Profession(
			Id_profession int primary key identity not null,
			Name_profession nvarchar(50) not null
)
-----------------------------------------
----نوع همکاری در فیلم و نقش شخص در فیلم و در چه فیملی همکاری داشته این تیبیل است
create table agents_involved_media(
		id_involved bigint primary key identity not null,
		id_media Bigint null,
		Id_Agents int null,
		id_profession int null
		Foreign Key (Id_Agents) References Agent(Id_Agents),
		Foreign Key (id_profession) References Profession(Id_profession),
		Foreign Key (id_media) References medias(Id_media)
)
------------------------------------------------------------------------------------
---جدول تعریف اشتراک های سایت
create table [Active](
		id_Active tinyint primary key identity not null,
		Name_Actives nvarchar(50) not null)


------------------------------------------------------------------------------------

--حساب کاربری
create table Users(
		UserId int primary key identity not null,
		F_Name nvarchar(50) not null,
		L_Name nvarchar(50) not null,
		Username nvarchar(50) not null,
		PhonNumber nvarchar(12) null ,
		[Password] varchar(64) null,
		Email nvarchar(100) not null ,
		[Uniqueidentifier] Uniqueidentifier not null default(newId()),
		[Description] nvarchar(MAX) Sparse,
		activeId tinyint null,
		[Timestamp] Timestamp not null
		Foreign Key (activeId) References [Active](id_Active) on delete set null,

)


-----------------------------------------------------------------------
--کامنت ها
create table Commentes(
			Commente_id BIGint primary key identity not null,
			Commente nvarchar(MAX) Sparse,
			UserId int null,
			mediaId Bigint null,
			Foreign Key (UserId) References Users(UserId) on delete cascade,
			Foreign Key (mediaId) References medias(Id_media)on delete cascade) 


----------------------------------------------
--فیلم های که دیده حساب کاربری
create table [show_media](
			id int primary key identity not null,
			UserId int not null,
			mediaId Bigint not null,
			Foreign Key (UserId) References Users(UserId)on delete cascade,
			Foreign Key (mediaId) References medias(Id_media)on delete cascade)



--=================================================================================================================================
--درج رکورد ها 
use Media

--درج ژانر ها
insert into Ganre(Name_Ganre) values (N'کمدی'),(N'هیجانی'),
								(N'جنایی'),(N'اکشن'),
								(N'ترسناک'),(N'درام')

--------------------------------------------------------------------------------
--تایپ فیلم ها
insert into [type_media](media_type) values (N'سینمایی'),(N'سریال'),
								(N'انیمه'),(N'کارتون'),
								(N'تلیر'),(N'پوستر')


--------------------------------------------------------------------------------------------
--- درج رسانه

INSERT INTO medias(Name_media, [Description], awards, publication, Score, Id_genre, [type_id], Time_media, [Language])
VALUES 
(N'نهگ عنبر', N'فیلمی با رضا عطاران', NULL, '2020-01-01', 7, 1, 1, 120, N'فارسی'),
(N'جنگ ستارگان', N'فیلمی بینظیرر', N'شش اسکار', '1977-05-01', 10, 4, 1, 90, N'انگلیسی'),
(N'پانیشر', NULL, NULL, '2018-07-22', 1, 3, 1, 2, N'انگلیسی'), 
(N'پاندای کونگفو کار', N'پاندای چاق', N'بهترین انیمیشن سال', '2024-07-01', 10, 1, 1, 45, N'چینی'),
(N'بتمن', N'بتمن بر میخیزد', N'دو اسکار و گلدن گلوب', '2011-09-14', 3, 4, 1, 240, N'انگلیسی'),
(N'شیر شاه', N'شیر خدا', NULL, '2020-01-02', NULL, 5, 2, 50, N'هندی'), -- اصلاح Id_genre
(N'واکینگ ها', N'مردان ماجراجوی نورٍثمن', N'بهترین سریال سال', '2012-05-04', 10, 2, 2, 45, N'فرانسوی/انگلیسی'),
(N'جوکر', NULL, NULL, '2024-02-01', NULL, 1, 2, 90, N'فارسی');

--------------------------------------------------------------------------------------------------------------------
--عوامل
insert into Agent(Name_Agents) values (N'رضا گلزار'),(N'کریستوفرنولا'),
								(N'خواکین فونیکس'),(N'تام هاردی'),
								(N'زک اسنایدر'),(N'مسعود قاسمی')

--------------------------------------------------------------------------------------------------------------------
-- نقش ها
insert into Profession(Name_profession) values (N'بازیگر'),(N'نویسنده'),
								(N'کارگردان'),(N'فیلم بردار')


--------------------------------------------------------------------------------------------------------------------
--همکاری در فیلم ها

insert into agents_involved_media(id_media,Id_Agents,id_profession) values(1,1,1),(4,1,1),(5,3,2),
																		   (8,2,4),(7,4,1),(6,3,4)

--------------------------------------------------------------------------------------------------------------------
--درج اشتراک ها

insert into Active(Name_Actives) values(N'غیرفعال'),(N'سه ماهه'),(N'شش ماهه'),(N'یک ساله'),(N'دوساله'),(N'نامحدود')

--------------------------------------------------------------------------------------------------------------------
INSERT INTO Users (F_Name, L_Name, Username, PhonNumber, [Password], Email, [Description], activeId)
VALUES
(N'احمد', N'رضایی', N'ahmadrezaei', N'09121234567', N'pass123', N'ahmad.rezaei@gmail.com', N'یک فرد مثبت و همیشه آماده برای کمک به دیگران.', 3),
(N'سارا', N'حسینی', N'sarhossaini', N'09122345678', N'pass124', N'sara.hosseini@email.com', N'شخصی خلاق و با روحیه تیمی بالا، عاشق هنر و طراحی.', 5),
(N'علی', N'محمدی', N'ali.mohammadi', N'09123456789', N'pass125', N'ali.mohammadi@gmail.com', N'فردی پر انرژی و با انگیزه برای یادگیری مهارت‌های جدید.', 2),
(N'مریم', N'عباسی', N'maryam.abbasi', N'09124567890', N'pass126', N'maryam.abbasi@email.com', N'دلسوز و با انگیزه، همواره در جستجوی راه‌های جدید برای رشد.', 6),
(N'رضا', N'امیری', N'reza.amiri', N'09125678901', N'pass127', N'reza.amiri@gmail.com', N'مردی با دانش وسیع و همیشه آماده برای ارائه مشاوره.', 1),
(N'فاطمه', N'علیزاده', N'fatemeh.alizadeh', N'09126789012', N'pass128', N'fatemeh.alizadeh@email.com', N'شخصی با روحیه بالا و علاقمند به فعالیت‌های اجتماعی.', 4),
(N'محمد', N'حیدری', N'mohammad.heidari', N'09127890123', N'pass129', N'mohammad.heidari@gmail.com', N'یک فرد دقیق و متعهد با توانایی‌های تحلیلی بالا.', 6),
(N'آناهیتا', N'خوشبخت', N'anahita.khoshbakht', N'09128901234', N'pass130', N'anahita.khoshbakht@email.com', N'شخصی با انرژی مثبت و توانایی بالا در حل مشکلات.', 2),
(N'پیمان', N'کریمی', N'peyman.kerami', N'09129012345', N'pass131', N'peyman.kerami@gmail.com', N'فردی خلاق با نگرش‌های نوآورانه و مهارت‌های قوی.', 3),
(N'الهام', N'زارع', N'elham.zarei', N'09130123456', N'pass132', N'elham.zarei@email.com', N'یک فرد پویا با استعدادهای متنوع و توانایی در مدیریت.', 1),
(N'احسان', N'یوسفی', N'ehsan.yousefi', N'09131234567', N'pass133', N'ehsan.yousefi@gmail.com', N'مردی با تعهد بالا و تمرکز بر نتایج عالی.', 5),
(N'نسیم', N'رضایی', N'nasim.rezaei', N'09132345678', N'pass134', N'nasim.rezaei@email.com', N'شخصی با تجربه گسترده و انگیزه برای کمک به دیگران.', 4),
(N'کیوان', N'صادقی', N'keyvan.sadeghi', N'09133456789', N'pass135', N'keyvan.sadeghi@gmail.com', N'فردی با دقت و تمرکز، با توانایی‌های مدیریتی عالی.', 3),
(N'سمیرا', N'زارع', N'samira.zarei', N'09134567890', N'pass136', N'samira.zarei@email.com', N'شخصی با نگرش مثبت و توانایی‌های بالا در تیم.', 6),
(N'احمدرضا', N'شریفی', N'ahmadreza.sharifi', N'09135678901', N'pass137', N'ahmadreza.sharifi@gmail.com', N'مردی با هوش بالا و دیدگاه استراتژیک.', 2),
(N'الهام', N'امیرخانی', N'elham.amirkhani', N'09136789012', N'pass138', N'elham.amirkhani@email.com', N'شخصی با توانایی‌های برجسته در برقراری ارتباطات.', 4),
(N'نیما', N'موسوی', N'nima.mousavi', N'09137890123', N'pass139', N'nima.mousavi@gmail.com', N'فردی با پشتکار و توانایی در حل مسائل پیچیده.', 1),
(N'عاطفه', N'فرجی', N'atefeh.faraji', N'09138901234', N'pass140', N'atefeh.faraji@email.com', N'شخصی با روحیه کار تیمی و مهارت‌های ارتباطی قوی.', 5),
(N'حمید', N'زارعی', N'hamid.zaraii', N'09139012345', N'pass141', N'hamid.zaraii@gmail.com', N'مردی با تحلیل‌های عمیق و توجه به جزئیات.', 2),
(N'سپیده', N'خدابنده', N'sepideh.khodabandeh', N'09140123456', N'pass142', N'sepideh.khodabandeh@email.com', N'شخصی با خلاقیت بالا و استعدادهای مدیریتی.', 6),
(N'پرویز', N'فتحی', N'parviz.fathi', N'09141234567', N'pass143', N'parviz.fathi@gmail.com', N'فردی با انگیزه و توانایی‌های قوی در زمینه‌های مختلف.', 3),
(N'زینب', N'معصومی', N'zeinab.masoomi', N'09142345678', N'pass144', N'zeinab.masoomi@email.com', N'شخصی با اشتیاق برای یادگیری و رشد فردی.', 1),
(N'سینا', N'اسماعیلی', N'sina.esmaili', N'09143456789', N'pass145', N'sina.esmaili@gmail.com', N'مردی با توانایی‌های بالا در تجزیه و تحلیل داده‌ها.', 5),
(N'فریبا', N'قاسمی', N'fariba.ghasemi', N'09144567890', N'pass146', N'fariba.ghasemi@email.com', N'شخصی با توانایی‌های منحصر به فرد در حل مسائل.', 4),
(N'بهزاد', N'جلالی', N'behzad.jalali', N'09145678901', N'pass147', N'behzad.jalali@gmail.com', N'فردی با پشتکار بالا و توانایی‌های ویژه در زمینه‌های مختلف.', 6),
(N'علیسا', N'یوسفی', N'alisayousefi', N'09146789012', N'pass148', N'alisayousefi@email.com', N'شخصی با استعدادهای قوی و روحیه مثبت.', 2),
(N'سهراب', N'مرادی', N'sohrab.moradi', N'09147890123', N'pass149', N'sohrab.moradi@gmail.com', N'مردی با تفکر خلاق و توانایی‌های مدیریتی.', 3),
(N'شهرزاد', N'قلیزاده', N'shahrzad.gholizadeh', N'09148901234', N'pass150', N'shahrzad.gholizadeh@email.com', N'شخصی با روحیه تیمی و توانایی‌های برجسته.', 1),
(N'امیر', N'حسنی', N'amir.hosseini', N'09149012345', N'pass151', N'amir.hosseini@gmail.com', N'فردی با انگیزه و توانایی‌های تحلیلی قوی.', 5),
(N'علی', N'رحیمی', N'ali.rahimi', N'09150123456', N'pass152', N'ali.rahimi@email.com', N'شخصی با تعهد بالا و دقت در کار.', 4),
(N'پریسا', N'هاشمی', N'parisa.hashemi', N'09151234567', N'pass153', N'parisa.hashemi@gmail.com', N'شخصی با توانایی‌های برجسته در ارتباطات و رهبری.', 2)



-------------------------------------------------------------------------------------------------------------------------------
--کامنت ها
INSERT INTO Commentes (Commente, UserId, mediaId) VALUES
(N'فیلم فوق‌العاده‌ای بود، بازیگری عالی و داستان جذاب.', 1, 5),
(N'واقعا از تماشای این فیلم لذت بردم، کارگردانی بی‌نظیر.', 2, 3),
(N'فیلم خیلی کند بود و انتظار بیشتری داشتم.', 3, 7),
(N'یکی از بهترین فیلم‌هایی بود که تا حالا دیده‌ام، حتما توصیه می‌کنم.', 4, 1),
(N'داستان فیلم جذاب بود اما پایان آن کمی ناامیدکننده بود.', 5, 8),
(N'بازیگران بسیار حرفه‌ای بودند و فیلم به خوبی ساخته شده بود.', 6, 2),
(N'فیلم به خوبی توانسته بود احساسات را منتقل کند.', 7, 4),
(N'آهنگ‌های فیلم بسیار زیبا بودند و به داستان کمک می‌کردند.', 8, 6),
(N'تنها نکته منفی فیلم، طولانی بودن آن بود.', 9, 3),
(N'به نظرم این فیلم برای عاشقان ژانر اکشن عالی است.', 10, 5),
(N'داستان فیلم درگیرکننده بود اما برخی از شخصیت‌ها به خوبی توسعه نیافته بودند.', 11, 7),
(N'این فیلم توانسته بود ترکیب خوبی از طنز و درام ایجاد کند.', 12, 8),
(N'از فیلم لذت بردم ولی فکر می‌کنم می‌توانست بهتر باشد.', 13, 2),
(N'فیلم بسیار جذاب و دیدنی بود، پیشنهاد می‌کنم.', 14, 4),
(N'شخصیت‌پردازی‌ها در این فیلم فوق‌العاده بودند.', 15, 1),
(N'بسیار زیبا و احساسی، حتما باید ببینید.', 16, 6),
(N'این فیلم ارزش دیدن دارد، اما به شخصه از آن لذت نبردم.', 17, 3),
(N'موسیقی متن فیلم فوق‌العاده بود و به داستان فیلم کمک می‌کرد.', 18, 5),
(N'فیلم به طور کلی خوب بود، اما انتظار داشتم بیشتر از آن لذت ببرم.', 19, 8),
(N'داستان فیلم به خوبی روایت شد و بازیگران عالی بودند.', 20, 2),
(N'فیلم بسیار خسته‌کننده و بدون جذابیت بود.', 21, 4),
(N'پایان فیلم کاملاً غیرمنتظره و شگفت‌انگیز بود.', 22, 7),
(N'فیلم بسیار قوی و جذاب با داستانی عالی.', 23, 1),
(N'بازیگران در این فیلم واقعا به خوبی عمل کرده بودند.', 24, 6),
(N'فیلم طولانی بود اما ارزش دیدن داشت.', 25, 3),
(N'حس و حال فیلم بسیار خوب بود و به یاد ماندنی بود.', 26, 8),
(N'فیلم داستان جالبی داشت ولی نیاز به بیشتر کار داشت.', 27, 2),
(N'پیشنهاد می‌کنم این فیلم را ببینید، قطعاً از آن لذت خواهید برد.', 28, 4),
(N'فیلم به خوبی توانسته بود احساسات را منتقل کند و به یاد ماندنی بود.', 29, 5),
(N'داستان فیلم خوب بود اما کمی پیش‌بینی‌پذیر.', 30, 7),
(N'پایان فیلم ناامیدکننده بود و انتظار بیشتری داشتم.', 31, 8),
(N'فیلم جذاب و سرگرم‌کننده‌ای بود، بازیگران عالی.', 1, 2),
(N'فیلم بسیار احساسی و تأثیرگذار بود، توصیه می‌کنم.', 2, 6),
(N'بازیگران فوق‌العاده بودند و فیلم به خوبی ساخته شده بود.', 3, 3),
(N'فیلم با اینکه طولانی بود، اما ارزش دیدن داشت.', 4, 5),
(N'یک فیلم متوسط با داستانی نه‌چندان جذاب.', 5, 8),
(N'فیلم جذاب و دیدنی با کارگردانی خوب.', 6, 2),
(N'داستان فیلم خیلی خوب بود و از تماشای آن لذت بردم.', 7, 4),
(N'شخصیت‌پردازی‌ها خوب بودند اما انتظار بیشتری داشتم.', 8, 7),
(N'فیلم بسیار خسته‌کننده و تکراری بود.', 9, 3),
(N'پیشنهاد می‌کنم این فیلم را ببینید، مطمئناً از آن لذت خواهید برد.', 10, 5),
(N'فیلم بسیار خوب با داستانی قوی و بازیگری عالی.', 11, 8),
(N'از فیلم لذت بردم، اما برخی از بخش‌های آن می‌توانست بهتر باشد.', 12, 2),
(N'فیلم با کیفیت و حرفه‌ای که توانسته بود احساسات را منتقل کند.', 13, 4),
(N'پایان فیلم قابل پیش‌بینی بود و از آن لذت نبردم.', 14, 1),
(N'فیلم با داستان جذاب و کارگردانی خوب، ارزش دیدن دارد.', 15, 6),
(N'یکی از فیلم‌های خوب سال، پیشنهاد می‌کنم.', 16, 3),
(N'فیلم خوب بود، اما داستان می‌توانست جذاب‌تر باشد.', 17, 5),
(N'داستان فیلم بسیار خوب و بازیگران عالی بودند.', 18, 8),
(N'این فیلم را با دقت تماشا کنید، داستان آن بسیار جذاب است.', 19, 2),
(N'فیلم بسیار زیبا و سرگرم‌کننده، پیشنهاد می‌کنم.', 20, 4),
(N'فیلم با اینکه قوی بود، اما برخی از نقاط ضعف داشت.', 21, 1),
(N'بازیگران بسیار خوب بودند و داستان فیلم جذاب بود.', 22, 6),
(N'پیشنهاد می‌کنم این فیلم را ببینید، برای شما جالب خواهد بود.', 23, 3),
(N'فیلم خوب بود اما می‌توانست بهتر باشد.', 24, 5),
(N'فیلم به خوبی احساسات را منتقل کرد و جذاب بود.', 25, 8),
(N'داستان فیلم متوسط بود و از آن لذت نبردم.', 26, 2),
(N'فیلم خوب با داستانی قابل توجه و جذاب.', 27, 4),
(N'پایان فیلم کاملاً غیرمنتظره و جالب بود.', 28, 7),
(N'فیلم بسیار خوب و تماشایی با بازیگری فوق‌العاده.', 29, 1),
(N'فیلم بسیار زیبا و تاثیرگذار با داستانی جالب.', 30, 6),
(N'بازیگران خوب بودند اما داستان فیلم کمی ضعیف بود.', 31, 3),
(N'فیلم با اینکه طولانی بود، اما بسیار جذاب و سرگرم‌کننده بود.', 1, 5),
(N'داستان فیلم به خوبی روایت شد و بازیگران عالی بودند.', 2, 8),
(N'فیلم با داستانی جذاب و سرگرم‌کننده، پیشنهاد می‌کنم.', 3, 2),
(N'این فیلم از نظر من خیلی خوب بود و پیشنهاد می‌کنم.', 4, 4),
(N'پایان فیلم بسیار جالب و غیرمنتظره بود.', 5, 7),
(N'فیلم خوب بود، اما انتظار بیشتری داشتم.', 6, 3),
(N'داستان فیلم جذاب و سرگرم‌کننده بود.', 7, 5),
(N'فیلم به طور کلی خوب بود، اما برخی بخش‌ها نیاز به بهبود داشتند.', 8, 8),
(N'شخصیت‌پردازی‌ها عالی و داستان بسیار خوب بود.', 9, 2),
(N'فیلم با داستان جذاب و بازیگری خوب، ارزش دیدن دارد.', 10, 4),
(N'فیلم خوب بود ولی کمی طولانی و خسته‌کننده بود.', 11, 6),
(N'داستان فیلم بسیار قوی و تأثیرگذار بود.', 12, 1),
(N'پیشنهاد می‌کنم این فیلم را ببینید، برای شما جالب خواهد بود.', 13, 7),
(N'فیلم با اینکه طولانی بود، اما به خوبی ساخته شده بود.', 14, 3),
(N'داستان فیلم خوب بود، اما می‌توانست قوی‌تر باشد.', 15, 5),
(N'فیلم بسیار جذاب و دیدنی با کارگردانی خوب.', 16, 8),
(N'بازیگران عالی بودند و داستان بسیار خوب روایت شده بود.', 17, 2),
(N'پایان فیلم غیرمنتظره بود و از آن لذت بردم.', 18, 4),
(N'فیلم خوب بود اما به نظرم می‌توانست جذاب‌تر باشد.', 19, 6),
(N'فیلم جذاب و دیدنی با داستانی سرگرم‌کننده.', 20, 1);
----------------------------------------------------------------------------------------------------------------------
----فیلم هایی که یوزر ها دیدن
INSERT INTO [show_media] (UserId, mediaId) VALUES
(1, 3),(2, 5),(4, 1),(5, 6),(7, 4),(8, 7),(9, 1),(10, 3),(11, 5),(14, 6),(15, 4),
(16, 7),(17, 1),(18, 3),(19, 5),(22, 6),(23, 4),(24, 7),(25, 1),(26, 3),(27, 5),
(30, 6),(31, 4),(1, 7),(3, 1),(4, 5),(6, 6),(7, 3),(9, 4),(10, 7),(12, 5),
(14, 1),(15, 6),(16, 3),(17, 4),(18, 7),(19, 5),(22, 6),(23, 1),(24, 3),(25, 7),
(28, 4),(29, 5),(31, 1);






--================================================================================================================================
-------------------------------------------------------------------------------------------------------------------
--فیلم های که هیچ کس ندیده
--فیلتر کردن بر اساس سریال
select Name_media,[Id_media] 
from medias t1 inner join (
							select [Id_media] 'فیلمی که هیچ کس ندیده'
							from medias
							Except
							select mediaId
							from Show_media
							)t2
on t1.Id_media=t2.[فیلمی که هیچ کس ندیده] inner join type_media 
on t1.[type_id]=type_media.media_type_Id
where type_media.media_type=N'سریال'
--فیلتر بر اساس سینمایی
select Name_media,[Id_media] 
from medias t1 inner join (
							select [Id_media] 'فیلمی که هیچ کس ندیده'
							from medias
							Except
							select mediaId
							from Show_media
							)t2
on t1.Id_media=t2.[فیلمی که هیچ کس ندیده] inner join type_media 
on t1.[type_id]=type_media.media_type_Id
where type_media.media_type=N'سینمایی'



--=====================================================================================
-----------------------------------------------------------------------------
--فیلم هایی که بیش از دوبار دیده شدن



select [mediaId],count(UserId) 'تعداد بینندگان'
from Show_media
group by [mediaId] 
having Count(UserId)>=2
----
select Name_media,Id_media
from medias t1 inner join (
					select [mediaId]
					from Show_media
					group by [mediaId] 
					having Count(UserId)>=2
					)t2
on t1.Id_media=t2.[mediaId] 

----
select Name_media,Id_media
from medias t1 inner join (
					select [mediaId]
					from Show_media
					group by [mediaId] 
					having Count(UserId)>=2
					)t2
on t1.Id_media=t2.[mediaId] inner join type_media 
on t1.[type_id]=type_media.media_type_Id
where type_media.media_type=N'سینمایی'

---
select Name_media,Id_media
from medias t1 inner join (
					select [mediaId]
					from Show_media
					group by [mediaId] 
					having Count(UserId)>=2
					)t2
on t1.Id_media=t2.[mediaId] inner join type_media 
on t1.[type_id]=type_media.media_type_Id
where type_media.media_type=N'سریال'
--=====================================================================================
-----------------------------------------------------------------------------------------------------------------
--کویری بنویسید که نام سه فیلم برتر از نظر مشاهده کابران را نشان دهد

select [mediaId],count(UserId) 'تعداد بینندگان'
from Show_media
group by [mediaId] 
order By count(UserId) desc
OFFSET 0 rows
FETCH NEXT 3 ROWS ONLY;
--
select Name_media
from medias t1 inner join (
			select [mediaId],count(UserId) 'تعداد بینندگان'
			from Show_media
			group by [mediaId] 
			order By count(UserId) desc
			OFFSET 0 rows
			FETCH NEXT 3 ROWS ONLY
			) t2
on t1.Id_media=t2.[mediaId]

------
select Name_media
from medias t1 inner join (
			select [mediaId],count(UserId) 'تعداد بینندگان'
			from Show_media
			group by [mediaId] 
			order By count(UserId) desc
			OFFSET 0 rows
			FETCH NEXT 3 ROWS ONLY
			) t2
on t1.Id_media=t2.[mediaId] inner join type_media 
on t1.[type_id]=type_media.media_type_Id
where type_media.media_type=N'سریال'
------
select Name_media
from medias t1 inner join (
			select [mediaId],count(UserId) 'تعداد بینندگان'
			from Show_media
			group by [mediaId] 
			order By count(UserId) desc
			OFFSET 0 rows
			FETCH NEXT 3 ROWS ONLY
			) t2
on t1.Id_media=t2.[mediaId] inner join type_media 
on t1.[type_id]=type_media.media_type_Id
where type_media.media_type=N'سینمایی'

--حالا  هر دو باهم

select Name_media[اسم فیلم],Name_Ganre[نام ژانر],media_type[نوع مدیا]
from medias t1 inner join (
			select [mediaId],count(UserId) 'تعداد بینندگان'
			from Show_media
			group by [mediaId] 
			order By count(UserId) desc
			OFFSET 0 rows
			FETCH NEXT 3 ROWS ONLY
			) t2
on t1.Id_media=t2.[mediaId] inner join type_media 
on t1.[type_id]=type_media.media_type_Id inner join Ganre
on t1.Id_genre=Ganre.id_Ganre 


--=====================================================================================
--پر بازدید ترین ژانر فیلم و سریال ها
select Name_media[اسم فیلم],Name_Ganre[نام ژانر],media_type[نوع مدیا]
from medias t1 inner join (
			select [mediaId],count(UserId) 'تعداد بینندگان'
			from Show_media 
			group by [mediaId]
			order By count(UserId) desc
			OFFSET 0 rows
			FETCH NEXT 1 ROWS ONLY
			) t2
on t1.Id_media=t2.[mediaId] inner join type_media 
on t1.[type_id]=type_media.media_type_Id inner join Ganre
on t1.Id_genre=Ganre.id_Ganre

----

--=====================================================================================

----------------------------------------------------------------------------------------------------
--حذف تمامی فیلم و سریال هایی در ژانر کمدی 

delete medias
from medias inner join Ganre
on medias.Id_genre=Ganre.id_Ganre
where Ganre.Name_Ganre=N'کمدی'
--------
delete medias
from medias inner join Ganre
on medias.Id_genre=Ganre.id_Ganre inner join type_media 
on medias.[type_id]=type_media.media_type_Id
where type_media.media_type=N'سینمایی' AND Ganre.Name_Ganre=N'کمدی'
------

delete medias
from medias inner join Ganre
on medias.Id_genre=Ganre.id_Ganre inner join type_media 
on medias.[type_id]=type_media.media_type_Id
where type_media.media_type=N'سریال' AND Ganre.Name_Ganre=N'کمدی'

 ---------------------------------------------------------------------------
 --فعال کردن اشتراک کاربران غیرفعال 

select *
from [Users]

update [Users]
set activeId=1
from [Users] U inner join Active A
on U.activeId=A.Id_active
where A.Name_Actives=N'غیرفعال'


----------------------------




