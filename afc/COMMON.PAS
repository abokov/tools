unit common;
{  Алексей Ю. Боков.1996.Россия/Москва.Тел.:(095)391-9540. }
{  Alexey Y. Bokow.1996.Russia/Moscow.Phone:(095)391-9540. }

{ Этот модуль содержит наиболее часто используемые процедуры.}
interface

uses u_const;

                  { ЗАГОЛОВКИ ПРОЦЕДУР.}

{ Процедура аварийного завершения.}
procedure Abnormal(Error:byte);

{ Процедура аварийного завершения с выводом соответсвующего сообщения.}
procedure AbnormalMsg(Error:byte);

{ Альтернатива Write при выводе на экран.}
procedure AltWrite(OutStr:string);

{ Альтернатива WriteLn при выводе на экран.}
procedure AltWriteLn(OutStr:string);

procedure CLI_PROC;

{ Конвертирует из десятичного в строку,содержащую десятичное представление числа.}
procedure ConvertDecToStr(Dec:byte;var fStr:string);

{ Конвертирует из десятичного в строку,содержащую двоичное представление
  числа.}
procedure ConvertToBin(Value:byte;var BitStr:string);

{ Конвертирует из десятичного в строку,содержащую HEX представление числа.}
procedure ConvertHexToStr(Dec:byte;var HexStr:String);

{ Вывод сообщения об ошибке и  аварийное завершение программы.}
procedure ErrorMsg(ErrCode:byte;ErrStr:string);

{ Процедура открывает файл,при этом содержимое файла не изменяется.}
procedure FileOpen(var FileVar:FileType);

{ Процедура открывает файл,при этом предыдущее содержимое файла теряется.}
procedure FileReWrite(var FileVar:FileType);

{ Возвращает текущий обработчик прерывания.}
procedure GetVector(Int_No:byte;var Int_Handler:pointer);

{ Запись строки по передаваемому указателю на нее в видео память.}
procedure MemWrite(StrSeg,StrOfs:word);

{ Переводит курсор на начало следующей строки.}
procedure NextScrPos;

{ Вывод сообщения о программе.}
procedure OutAuthorMsg;

{ Вывод текущих настроек.}
procedure OutCompareMode;

{ Вывод информации о файлах(путь,размер и т.п.).}
procedure OutFileInf;

{ Ввод сообщения - помощи.}
procedure OutHelpMsg;

{ Выводит объем уже выполненной работы.}
procedure OutProgress;

{ Переводит курсор на предыдущую строку.}
procedure PrevScrPosition;

{ Пишет Value в mSeg:[mOfs].}
procedure Poke(mSeg,mOfs:word;Value:byte);

{ Отличается от Poke типом Value.}
procedure PokeW(mSeg,mOfs:word;Value:word);

{ Читает байт из файла.}
procedure ReadByte(var FPtr:FileOfByte;var Value:byte);

{ Устанавливает обработчик прерывания.}
procedure SetVector(Int_No:byte;Int_Handler:pointer);

procedure STI_PROC;

{ Запись байта в файл.}
procedure WriteByte(var F:FileOfByte;Value:byte);

{ Запись строки в файл.}
procedure WriteStr(var F:FileOfByte;WrStr:string);


{ Возвращает строку с требуемой длиной,при необходимости добавляя слева символ '0'.}
function AddNul(fStr:String;tStrLen:byte):string;

{ Возвращает строку с требуемой длиной,при необходимости добавляя справа пробелы.}
function AddSpace(Count:byte;fStr:String):string;

{ Возвращает строку с названием атрибута(например 'System') для Attr=4.}
function AttrToStr(Attr:word):string;

{ True если A=B.Если A<>B,и в командной строке имеется ключ /D-то происходит
  запись различающихся байтов в файл.}
function CompareByte(A,B:byte):boolean;

{ Процедура сравнения строк - возвращает True усли строки считаются идентичными.}
function CompareString(FirstStr,SecStr:string):boolean;

{ Вспомогательная процедура для процедуры сравнения строк.}
function CompareStr_Asm(FirstSeg,FirstOfs,SecSeg,SecOfs:word):boolean;

{ Возвращает строковое представление числа.}
function DecToStr(Dec:LongInt):string;

{ Возвращает False если файла не существует.}
function FileExists(FileName: String): Boolean;

{ Возвращет выделенные из Path три последние символа-расширение файла.}
function GetExt(Path:string):string;

{ Возвращает минимальное.}
function Min(A,B:LongInt):LongInt;

{ Возвращает байт из mSeg:[mOfs].}
function Peek(mSeg,mOfs:word):byte;

{ Отличается от Peek типом возвращаемого значения.}
function PeekW(mSeg,mOfs:word):word;

{ Возвращает по упакованному значению времени строку содержащую время.}
function TimeToStr(PackTime:Longint):string;






implementation

uses dos;


procedure Abnormal(Error:byte);
  { Процедура аварийного завершения программы.
    Данная процедура вызывается при ошибках ввода-вывода(здесь это
    ошибки операции записи на диск).Процедура закрывает все файлы и
    заканчивает работу при помощи Halt.В переменной ErrorLevel
    возвращает код ошибки.}
begin
   if FirstFile.Open then Close(FirstFile.Ptr);
   if SecondFile.Open then Close(SecondFile.Ptr);
   if OutFile.Open then Close(OutFile.Ptr);
   if DiffFile.Open then Close(DiffFile.Ptr);

   SetVector(CtrlBreak_Int_No,Ctrl_Break_Handler);

   Halt(Error);
end;



procedure AbnormalMsg(Error:byte);
{
    Процедура аварийного завершения программы.
    По передаваемому коду ошибки формирует соответсвующие сообщение и
    завершает программу ( см. Abnormal ).
}
  var
    ErrMsg:string;
begin
   case Error of
         1:ErrMsg:='First file not found';
         2:ErrMsg:='Second file not found';
         3:ErrMsg:='Output file not found at parameters string';
         4:ErrMsg:='File of differences not at parameters string';
         5:ErrMsg:='Bad parametrs';
      else
            ErrMsg:='Error is non recognize';
   end;
   ErrorMsg(Error,ErrMsg);
end;



procedure AltWrite(OutStr:string);
  { Некоторая альтернатива (при выводе на экран) Write.Отличается прямой
    записью в видео память,и соответственно все (в том числе управляющие)
    символы выводит как надо.Например,не пищит при выводе символа с кодом 7,
    а выводит соответствующий символ в ASCII и т.п.Дополнительная информация
    содержится в комментариях к процедуре MemWrite.}
var
  StrSeg,StrOfs:word;
begin
    StrSeg:=Seg(OutStr);
    StrOfs:=Ofs(OutStr);
    MemWrite(StrSeg,StrOfs);
end;



procedure AltWriteLn(OutStr:string);
  { Альтернатива WriteLn при выводе на экран.}
begin
   case WhereWrite of

           ToScreen: begin
                        AltWrite(OutStr);
                        NextScrPos;
                     end;

           ToFile:   with OutFile do WriteStr(Ptr,OutStr);

           ToScr_and_File:begin
                             AltWrite(OutStr);
                             NextScrPos;
                             { Дублирование выводимой информации в файле.}
                             with OutFile do WriteStr(Ptr,OutStr);
                          end;
   end;
end;



procedure CLI_PROC;
begin
  inline($FA);
end;



procedure ConvertDecToStr(Dec:byte;var fStr:string);
  { Конвертирует из десятичного в строку...}
  var
    tStr:string[MaxDecLen];
begin
   Str(Dec,tStr);
   tStr:=AddNul(tStr,MaxDecLen);
   fStr:=tStr;
end;



procedure  ConvertHexToStr(Dec:byte;var HexStr:String);
  { Конвертирует из десятичного в строку.Строка содержит шестнадцатиричное
    представление числа.}
   var
     i:byte;
     T:byte;
     M:byte;
     tPower:word;
     tStr:string;
begin
   HexStr:='$';
   T:=Dec;

   for i:=MaxHexLen-1 downto 0 do
      begin
         tPower:=(1) SHL (4*i);{ tPower:=16^i }

         M:=(T)SHR(4*i);{ M:=T div (16^i) }

{ Эта часть процедуры не будет корректно работать с кодировкой EBCDIC.}
         if M<10 then  tStr:=chr(M+48) else tStr:=chr(M+55);

         HexStr:=HexStr+tStr;
         T:=T-(M*tPower);
      end;
end;



procedure ConvertToBin(Value:byte;var BitStr:string);
  { Конвертирует из десятичного в строку.Строка содержит двоичное
    представление числа.}
  var
    i:byte;
    M:byte;
    tPower:byte;
begin

   BitStr:='';
   for i:=MaxBinLen downto 0 do
      begin
         tPower:=(1) SHL (i);    { tPower:=2^i.}

         M:=(Value) AND (tPower);

         M:=(M) SHR (i);{ М равно 0 либо 1.}

         BitStr:=BitStr+chr(M+48);
      end;
end;



procedure ErrorMsg(ErrCode:byte;ErrStr:string);
  var
    tWhereWrite:OutType;
begin
   tWhereWrite:=WhereWrite;

   if (WhereWrite=ToFile) then WhereWrite:=ToScr_and_File;
   if (ErrCode=255) then WhereWrite:=ToScreen;

   AltWriteLn(' AFC MESSAGE                       ');
   AltWriteLn(' ATTENTION! RUN-TIME ERROR!');
   AltWriteLn(' Error description: '+ErrStr+' .');

   WhereWrite:=tWhereWrite;
   Abnormal(ErrCode);
end;



procedure FileOpen(var FileVar:FileType);
  { Процедура открывает файл.
   В случае ошибки ввода-вывода программа аварийно завершается.}
  var
    Error:byte;
begin
   {$I-}
   with FileVar do
     begin
        Assign(Ptr,Path);

        Error:=IOResult;
        if Error<>0 then ErrorMsg(Error,fAccessErr+Path);

        GetFAttr(Ptr,Attr);

        Error:=IOResult;
        if Error<>0 then ErrorMsg(Error,fAccessErr+Path);

        Reset(Ptr);
        Open:=True;

        Error:=IOResult;
        if Error<>0 then ErrorMsg(Error,fOpenErr+Path);

        Size:=FileSize(Ptr);

        Error:=IOResult;
        if Error<>0 then ErrorMsg(Error,fOpenErr+Path);
     end;
end;



procedure FileReWrite(var FileVar:FileType);
 { Процедура открывает файл.
   Если файл уже существует,то он его прежнее содержимое теряется.
   В случае ошибки ввода-вывода программа аварийно завершает свою работу.}
  var
    Error:byte;
begin
{$I-}
   with FileVar do
     begin
        Assign(Ptr,Path);

        Error:=IOResult;
        if Error<>0 then ErrorMsg(Error,fAccessErr+Path);

        ReWrite(Ptr);
        Open:=True;

        Error:=IOResult;
        if Error<>0 then ErrorMsg(Error,fAccessErr+Path);

        Size:=FileSize(Ptr);

        Error:=IOResult;
        if Error<>0 then ErrorMsg(Error,fAccessErr+Path);
     end;
end;


procedure GetVector(Int_No:byte;var Int_Handler:pointer);
var
  pSeg,pOfs:word;
begin
  CLI_PROC;
  pOfs:=PeekW(0,Int_No shl 2);
  pSeg:=PeekW(0,(Int_No shl 2)+2);
  Int_Handler:=Ptr(pSeg,pOfs);
  STI_PROC;
end;



procedure MemWrite(StrSeg,StrOfs:word);assembler;
{
    ПРОЦЕДУРА ВЫВОДА НА ЭКРАН СТРОКИ ПО ПЕРЕДАВАЕМЫМ СЕГМЕНТУ И
  СМЕЩЕНИЮ СТРОКИ.СТРОКА В ФОРМАТЕ TURBO-PASCAL:ASCII КОД ПЕРВОГО
  СИМВОЛА СООТВЕТСТВУЕТ ДЛИНЕ СТРОКИ.
    СТРОКА ЗАПИСЫВАЕТСЯ НА ТЕКУЩУЮ ВИДЕОСТРАНИЦУ,АТРИБУТ ВЫВОДИМЫХ
  СИМВОЛОВ - 7 ( НЕ ЯРКИЙ БЕЛЫЙ СИМВОЛ НА ЧЕРНОМ ФОНЕ ).ОТЛИЧАЕТСЯ
  ОТ СТАНДАРТНОЙ ПРОЦЕДУРЫ WRITE ТЕМ,ЧТО НЕ РЕАГИРУЕТ НА
  СПЕЦИАЛЬНЫЕ СИМВОЛЫ ( ВСЕ СИМВОЛЫ ВЫВОДЯТСЯ КАК СООТВЕТСТВУЮЩИЕ
  СИМВОЛЫ ASCII ).ПРИ НЕОБХОДИМОСТИ ПРОИЗВОДИТСЯ СКРОЛЛИНГ.СКОРОСТЬ
  РАБОТЫ ПРОЦЕДУРЫ ПРИМЕРНО НА 10% МЕНЕЕ СТАНДАРТНОЙ WRITE.
    ПРОЦЕДУРА РАБОТАЕТ В ТЕКСТОВОМ РЕЖИМЕ С EGA/VGA - СОВМЕСТИМЫМИ
  АДАПТЕРАМИ.

 РАЗРАБОТКА ПРОЦЕДУРЫ:
   АЛЕКСЕЙ Ю. БОКОВ.1996.РОССИЯ/МОСКВА.ТЕЛ.:(095)391-9540.
   МОСКОВСКИЙ ИНЖЕНЕРНО - ФИЗИЧЕСКИЙ ИНСТИТУТ/ГРУППА Б1-01.

 PROCEDURE ELABORATION:
   ALEXEY Y. BOKOW.1996.RUSSIA/MOSCOW.PHONE:(095)391-9540.
   MOSCOW INSTITUTE OF ENGINEERING PHYSICS/GROUP B1-01.
}

label OVER_X,OVER_Y,COORD_OK,DEC_LOOP,ADD_SI,
          SCROLL_LOOP,FILL_LOOP,WRITE_LOOP,THE_END;
  asm
{ СОХРАНЯЕМ РЕГИСТРЫ.}
        PUSH ES
        PUSH DI
        PUSH DS
        PUSH SI

{ ПОЛУЧАЕМ АКТИВНУЮ СТРАНИЦУ.}
        MOV  AX,BIOSDATASEG
        MOV  ES,AX
        MOV  DI,$0062
       { ЗАНОСИМ В BH ЗНАЧЕНИЕ ИЗ АДРЕСА ES:[DI]( АКТИВНАЯ СТРАНИЦА ).}
        MOV  BH,BYTE PTR ES:[DI]

{ ПОЛУЧАЕМ ТЕКУЩИЕ КООРДИНАТЫ.}
        XOR  AX,AX
        MOV  AH,03
        INT  $10
       { INT 10h ВОЗВРАЩАЕТ:
          DL - ТЕКУЩАЯ X - КООРДИНАТА,
          DH - ТЕКУЩАЯ Y - КООРДИНАТА.}
       { СОХРАНЯЕМ ТЕКУЩИЕ КООРДИНАТЫ В СТЕКЕ.}
        PUSH DX

{ ВЫЧИСЛЯЕМ СМЕЩЕНИЕ ОТНОСИТЕЛЬНО НАЧАЛА СТРАНИЦЫ.}

       { ПОЛУЧАЕМ ЧИСЛО СТОЛБЦОВ.}
        MOV  AX,BIOSDATASEG
        MOV  ES,AX
        MOV  DI,$004A
        MOV  BX,WORD PTR ES:[DI] { ЗАНОСИМ ЧИСЛО СТОЛБЦОВ В AX.}
        MOV  AX,BX

       { УМНОЖАЕМ ТЕКУЩУЮ Y - КООРДИНАТУ НА ЧИСЛО СТОЛБЦОВ.}
        IMUL  DH

       { СКЛАДЫВАЕМ ПОЛУЧЕННОЕ ЗНАЧЕНИЕ С ТЕКУЩЕЙ X - КООРДИНАТОЙ.}
        XOR  DH,DH
        ADD  AX,DX

       { УМНОЖАЕМ НА 2,ТАК КАК НА ОДИН СИМВОЛ ОТВОДИТСЯ 2 БАЙТА ВИДЕО ПАМЯТИ.}
        SHL  AX,1

{ СКЛАДЫВАЕМ ВЫЧИСЛЕННОЕ СМЕЩЕНИЕ С СМЕЩЕНИЕМ АКТИВНОЙ СТРАНИЦЫ.}

       { ПОЛУЧАЕМ СМЕЩЕНИЕ АКТИВНОЙ СТРАНИЦЫ.}
        MOV  DI,$004E
        MOV  DX,WORD PTR ES:[DI]  { ЗАНОСИМ СМЕЩЕНИЕ АКТИВНОЙ СТРАНИЦЫ В DX.}

        ADD  AX,DX

        POP  DX

{ ЗАГРУЖАЕМ УКАЗАТЕЛЬ НА СТРОКУ В DS:[SI].}
        MOV  CX,STRSEG
        MOV  DS,CX
        MOV  SI,STROFS

{ ПОЛУЧАЕМ ДЛИНУ.}

        XOR  CX,CX
        MOV  CL,BYTE PTR DS:[SI]
        { ПУСТУЮ СТРОКУ НЕ ВЫВОДИМ.}
        CMP  CL,0
        JE   THE_END
        INC  SI

{ ПЕРЕВОДИМ КУРСОР BIOS.}
        ADD  DL,CL


        { СОХРАНЯЕМ СМЕЩЕНИЕ И ДЛИНУ СТРОКИ В СТЕКЕ.}
        PUSH DS
        PUSH SI
        PUSH CX
        PUSH AX

        { СРАВНИВАЕМ ТЕКУЩУЮ X - КООРДИНАТУ С ЧИСЛОМ СТОЛБЦОВ.}
        CMP  DL,BL

        JAE  OVER_X  { X - КООРДИНАТА ПРЕВЫШАЕТ ЧИСЛО СТОЛБЦОВ.}

        MOV  DI,$0084
        MOV  AL,BYTE PTR ES:[DI]   { ЗАНОСИМ ЧИСЛО СТРОК НА ЭКРАНЕ В AL.}

        { СРАВНИВАЕМ ЧИСЛО СТРОК С Y - КООРДИНАТОЙ.}
        CMP  DH,AL

        JAE  OVER_Y { Y - КООРДИНАТА ПРЕВЫШАЕТ ЧИСЛО СТРОК НА ЭКРАНЕ.}

        JMP  COORD_OK { КОРДИНАТЫ В ПОРЯДКЕ,ПРОДОЛЖАЕМ ДАЛЬШЕ.}

OVER_X:
        XOR  AX,AX
        { РЕГИСТР DX СОДЕРЖИТ ТЕКУЩИЕ КООРДИНАТЫ.}
        MOV  AL,DL
        { СЕЙЧАС В BL НАХОДИТСЯ ЧИСЛО СТОЛБЦОВ.}
        DIV  BL
        { ЗАНОСИМ В DH - ЦЕЛУЮ ЧАСТЬ ПЛЮС ПРЕДЫДУЩАЯ Y - КООРДИНАТА;
                  B DL - ОСТАТОК.}
        MOV  DL,AH
        ADD  DH,AL

        { ПОЛУЧАЕМ ЧИСЛО СТРОК.}
        MOV  DI,$0084
        MOV  AL,BYTE PTR ES:[DI]   { ЗАНОСИМ ЧИСЛО СТРОК НА ЭКРАНЕ В AL.}
{        DEC  AL}

        { СРАВНИВАЕМ Y - КООРДИНАТУ С ЧИСЛОМ СТРОК.}
        CMP  DH,AL
        JAE  OVER_Y { Y - КООРДИНАТА ПРЕВЫШАЕТ ЧИСЛО СТРОК НА ЭКРАНЕ.}
        JMP  COORD_OK { КООРДИНАТЫ В ПОРЯДКЕ,ПРОДОЛЖАЕМ ДАЛЬШЕ.}

OVER_Y:
{ УМЕНЬШАЕМ Y - КООРДИНАТУ ДО ТЕХ ПОР ПОКА ОНА НЕ ПРИМЕТ ДОПУСТИМЫХ ЗНАЧАНИЙ.}
        XOR  CX,CX

   DEC_LOOP:
        INC  CX      { КОЛИЧЕСТВО ВЫЧИТАНИЙ ЗАНОСИМ В CX.}
        DEC  DH
        CMP  DH,AL   { СРАВНИВАЕМ ЧИСЛО СТРОК С Y - КООРДИНАТОЙ.}
        JAE  DEC_LOOP

        PUSH DX
        PUSH CX

{ УСТАНАВЛИВАЕМ КУРСОР BIOS.}
        MOV  DI,$0062
        MOV  BH,BYTE PTR ES:[DI] { ЗАНОСИМ В BH
                     ЗНАЧЕНИЕ ИЗ ES:[DI](АКТИВНАЯ СТРАНИЦА).}
        XOR  AX,AX
        MOV  AH,02
        INT  $10

        POP  CX

{ ДЕЛАЕМ СКРОЛЛИНГ НА ЧИСЛО СТРОК,РАВНОЕ СОДЕРЖИМОМУ РЕГИСТРА СX.}

        { ПОЛУЧАЕМ СМЕЩЕНИЕ СТРАНИЦЫ.}
        MOV  DI,$004E
        MOV  DX,WORD PTR ES:[DI] { ЗАГРУЖАЕМ СМЕЩЕНИЕ АКТИВНОЙ СТРАНИЦЫ
                                        В ВИДЕО СЕГМЕНТЕ ЗАНОСИМ В DX.}

        { ПОЛУЧАЕМ ЧИСЛО СТОЛБЦОВ.}
        MOV  DI,$004A
        MOV  BX,WORD PTR ES:[DI] { ЗАНОСИМ ЧИСЛО СТОЛБЦОВ В BX.}
        SHL  BX,1 { НА ОДИН СИМВОЛ ОТВОДИТСЯ 2 БАЙТА.}

        { ЗАНОСИМ В SI СМЕЩЕНИЕ НАЧАЛА СТРОКИ С НОМЕРОМ CX
          ОТНОСИТЕЛЬНО НАЧАЛА СТРАНИЦЫ.}
        XOR  SI,SI

ADD_SI: ADD  SI,BX
        LOOP ADD_SI

        PUSH SI

        { ПОЛУЧАЕМ РАЗМЕР СТРАНИЦЫ.}
        MOV  DI,$004C
        MOV  CX,WORD PTR ES:[DI] { ЗАНОСИМ РАЗМЕР ТЕКУЩЕЙ ВИДЕОСТРАНИЦЫ В CX.}
        { ВЫЧИТАЕМ ИЗ РАЗМЕРА СТРАНИЦЫ РАЗМЕР НЕПОДНИМАЕМЫХ СТРОК.}
        SUB  CX,SI
        { РАЗМЕР В СЛОВАХ.}
        SHR  CX,1

        { УСТАНАВЛИВАЕМ УКАЗАТЕЛИ:
            ES:[DI] - НАЧАЛО СТРАНИЦЫ,
            DS:[SI] - НАЧАЛО СТРОКИ С НОМЕНОМ CX.}

        MOV  DI,$004E
        MOV  DI,WORD PTR ES:[DI] { CМЕЩЕНИЕ АКТИВНОЙ СТРАНИЦЫ
                                    В ВИДЕО СЕГМЕНТЕ ЗАНОСИМ В DI.}
        ADD  SI,DI

        MOV  AX,VIDEOSEG
        MOV  ES,AX
        MOV  DS,AX

        { ПОДНИМАЕМ ЭКРАН ВВЕРХ.}
        CLD

SCROLL_LOOP:

        MOVSW
        LOOP SCROLL_LOOP

        { ЗАПОЛНЯЕМ СТРОКИ БЕЛЫМИ СИМВОЛАМИ С ASCII - КОДОМ 20h.}

        POP  CX
        PUSH CX

        MOV  AX,$0720

FILL_LOOP:
        MOV  WORD PTR ES:[DI],AX
        ADD  DI,2
        LOOP FILL_LOOP

        POP  CX
        POP  DX
        { ИЗМЕНЯЕМ СМЕЩЕНИЕ,СООТВЕТСТВУЮЩИЕ НАЧАЛУ УЧАСТКА ВИДЕО ПАМЯТИ В
          КОТОРЫЙ БУДЕТ ВЫВОДИТСЯ СТРОКА,ТАК КАК ЭТО СМЕЩЕНИЕ ВЫЧИСЛЯЛОСЬ
          ПО КООРДИНАТАМ ДО ТОГО КАК БЫЛ ПРОИЗВЕДЕН СКОЛИННГ.}
        POP  AX
        { "ПОДНИМАЕМ" ВЫВОДИМУЮ СТРОКУ.}
        SUB  AX,CX
        PUSH AX

COORD_OK:
        POP  AX
        POP  CX
        POP  SI
        POP  DS

        PUSH AX

{ УСТАНАВЛИВАЕМ КООРДИНАТЫ BIOS.}
        MOV  BX,BIOSDATASEG
        MOV  ES,BX
        MOV  DI,$0062
        MOV  BH,BYTE PTR ES:[DI] { ЗАНОСИМ В BH
                    ЗНАЧЕНИЕ ИЗ ES:[DI](АКТИВНАЯ СТРАНИЦА).}
        XOR  AX,AX

        MOV  AH,02
        INT  $10

        POP  AX

        MOV  BX,VIDEOSEG
        MOV  ES,BX
{ ЗАНОСИМ В DI СМЕЩЕНИЕ (ES:[DI] -  УКАЗЫВАЕТ НА НАЧАЛО УЧАСТКА ВИДЕО ПАМЯТИ,
  В КОТОРЫЙ БУДЕТ ЗАПИСЫВАТЬСЯ СТРОКА).}

        MOV  DI,AX

{ ПИШЕМ В ПАМЯТЬ.}
        MOV  AL,7

        CLD

WRITE_LOOP:
        MOVSB           { DS:[SI]->ES:[DI]-ПЕРЕСЫЛАЕТСЯ ОДИН БАЙТ.}
        MOV  ES:[DI],AL { ЗАПИСЫВАЕМ В ES:[DI] АТРИБУТ.}
        INC  DI         { УВЕЛИЧИВАЕМ СМЕЩЕНИЕ.}
        LOOP WRITE_LOOP
THE_END:
{ ЗАГРУЖАЕМ СОХРАНЕННЫЕ РЕГИСТРЫ ОБРАТНО.}
        POP  SI
        POP  DS
        POP  DI
        POP  ES

end;



procedure NextScrPos;assembler;
{ Переводит курсор на начало следующей строки.}
asm
       PUSH ES
       PUSH DI

       MOV  AX,BIOSDATASEG
       MOV  ES,AX
       MOV  DI,$0062
       MOV  BH,BYTE PTR ES:[DI]{ BH=ES:[DI] - АКТИВНАЯ СТРАНИЦА.}

       PUSH BX    { СОХРАНЯЕМ ТАК КАК INT 10 МОЖЕТ ИЗМЕНИТЬ BX.}

       XOR  AX,AX

       MOV  AH,03
       INT  $10

       POP  BX

       MOV  AH,02
       INC  DH   { Y_COORD:=Y_COORD+1.}
       MOV  DL,0
       INT  $10  { ПЕРЕМЕЩАЕМ КУРСОР BIOS В ПЕРВУЮ ПОЗИЦИЮ СЛЕДУЮЩЕЙ СТРОКИ.}

       POP  DI
       POP  ES
end;



procedure OutAuthorMsg;
  var
    tWhereWrite:OutType;
begin
   tWhereWrite:=WhereWrite;

   if (WhereWrite=ToFile)and(quiet_mode=false) then
     WhereWrite:=ToScr_and_File;

   AltWriteLn(ProgramInfo);
   AltWriteLn(ProgramVerInfo);
   AltWriteLn(AuthorInfo);
   AltWriteLn(InstituteInfo);

   WhereWrite:=tWhereWrite;
end;



procedure OutCompareMode;
  { Вывод текущих настроек программы.}
  var
    tStr,tStr_1:string;
    tWhereWrite:OutType;
begin

   tWhereWrite:=WhereWrite;
   if (WhereWrite=ToFile)and(quiet_mode=false) then WhereWrite:=ToScr_and_File;

   case Cmp of

     TextCmp: tStr:='TEXT';

     BinaryCmp: tStr:='BINARY';

   end;

   case CmpModel of

          Simple: tStr_1:='SIMPLE';

          Smart: tStr_1:='SMART';

          Clever: tStr_1:='CLEVER';

   end;

   AltWriteLn(' Compare mode:'+tStr+'.'+' Compare model:'+tStr_1+'.');

   if WriteDiff then AltWriteLn(' Save differences in file '+DiffFile.Path+'.');


   case tWhereWrite of

     ToScreen: tStr:='ONLY TO SCREEN';

     ToFile: tStr:='ONLY TO FILE';

     ToScr_and_File: tStr:='TO SCREEN AND FILE';

   end;

   if CmpModel=Simple then
     begin
       if MinimOutput then tStr_1:='MINIMAL' else tStr_1:='FULL';
       AltWriteLn(' Output performed:'+tStr+'.'+' Output mode:'+tStr_1+'.');
     end
   else
       AltWriteLn(' Output performed:'+tStr+'.');
  if CleanIgnore then AltWriteLn(' IGNORE clean string.');
  if CaseIgnore then AltWriteLn(' IGNORE case of letter.');
  if NowDebug then AltWriteln(' DEBUG mode is ON.');

  WhereWrite:=tWhereWrite;
end;



procedure OutFileInf;

     procedure OutInf(var tFile:FileType);
       var
         tStr:string;
         Val:LongInt;
     begin
        with tFile do
           begin
              AltWriteLn('   Name:'+Path+'.');

              GetFTime(Ptr,Val);
              tStr:=TimeToStr(Val);

              AltWriteLn('   Size : '+DecToStr(Size)+'.'+' Attribut: '+AttrToStr(Attr)+'.');
              AltWriteLn('   Creations DATE(Year/Month/Day) and TIME:'+tStr+'.');
           end;
     end;

  { Вывод информации о файлах.}
var
  tWhereWrite:OutType;
begin

   tWhereWrite:=WhereWrite;
   if (WhereWrite=ToFile)and(quiet_mode=false) then WhereWrite:=ToScr_and_File;
{   if WhereWrite=ToFile then WhereWrite:=ToScr_and_File;}

   AltWriteLn('');

   AltWriteLn(' Information about FIRST file.');
   OutInf(FirstFile);

   AltWriteLn(' ');

   AltWriteLn(' Informаtion about SECOND file.');
   OutInf(SecondFile);

   WhereWrite:=tWhereWrite;
end;



procedure OutHelpMsg;
  var
    tWhereWrite:OutType;
begin
   tWhereWrite:=WhereWrite;
   if WhereWrite=ToFile then WhereWrite:=ToScr_and_File;

   AltWriteLn(ProgramInfo);
   AltWriteLn(ProgramVerInfo);
   AltWriteLn(AuthorInfo);
   AltWriteLn(InstituteInfo);

   AltWriteLn(' AFC help.');
   AltWriteLn('  /B - set BINARY mode of compare.');
   AltWriteLn('  /C - ignore CASE of character.');
   AltWriteLn('  /Dfilename - write differences byte to file.');
   AltWriteLn('  /H or /? - help.');
   AltWriteLn('  /M - MINIMAL output: show only differences bytes or strings.');
   AltWriteLn('  /Pfilename - write report only to file.');
   AltWriteLn('  /Rfilename - write report to screen and file.');
   AltWriteLn('  /S - space ignore.');
   AltWriteLn('  /T - set TEXT mode of compare.');
   AltWriteLn('  /Z or /z - ignore clean string.');
   AltWriteLn('  Use "/SMART" switch to run smart compare model.');

   WhereWrite:=tWhereWrite;
end;



procedure OutProgress;
var
   NowPos:LongInt;
   ProgValue:byte;
   tWhereWrite:OutType;
begin
   tWhereWrite:=WhereWrite;
   WhereWrite:=ToScreen;

   with FirstFile do NowPos:=FilePos(Ptr);
   with FirstFile do ProgValue:=(NowPos*100) div Size;
   AltWriteLn(' PROGRESS:'+DecToStr(ProgValue)+'% .');
   PrevScrPosition;

   WhereWrite:=tWhereWrite;
end;



procedure Poke(mSeg,mOfs:word;Value:byte);assembler;
asm
    PUSH ES
    PUSH DI

    MOV  CL,VALUE
    MOV  ES,mSEG
    MOV  DI,mOFS
    MOV  BYTE PTR ES:[DI],CL

    POP  DI
    POP  ES

end;



procedure PokeW(mSeg,mOfs:word;Value:word);assembler;
asm
     PUSH ES
     PUSH DI

     MOV  CX,VALUE
     MOV  ES,mSEG
     MOV  DI,mOFS
     MOV  WORD PTR ES:[DI],CX

     POP  DI
     POP  ES
end;



procedure PrevScrPosition;assembler;
{ Переводит курсор на начало предыдущей строки.}
asm
       PUSH ES
       PUSH DI

       MOV  AX,BIOSDATASEG
       MOV  ES,AX
       MOV  DI,$0062
       MOV  BH,BYTE PTR ES:[DI]{ BH=ES:[DI] - АКТИВНАЯ СТРАНИЦА.}

       PUSH BX    { СОХРАНЯЕМ ТАК КАК INT 10 МОЖЕТ ИЗМЕНИТЬ BX.}

       XOR  AX,AX

       MOV  AH,03
       INT  $10

       POP  BX

       MOV  AH,02
       DEC  DH   { Y_COORD:=Y_COORD-1.}
       MOV  DL,0
       INT  $10  { ПЕРЕМЕЩАЕМ КУРСОР BIOS В ПЕРВУЮ ПОЗИЦИЮ СЛЕДУЮЩЕЙ СТРОКИ.}

       POP  DI
       POP  ES
end;



procedure ReadByte(var FPtr:FileOfByte;var Value:byte);
  var
    ErrCode:byte;
begin
   {$I-}
   Read(FPtr,Value);
   ErrCode:=IOResult;
   if ErrCode<>0 then ErrorMsg(ErrCode,fReadErr+fUnknown);
end;



procedure SetVector(Int_No:byte;Int_Handler:pointer);
begin
   CLI_PROC;
   PokeW(0,Int_No*4,Ofs(Int_Handler^) );
   PokeW(0,(Int_No*4)+ 2,Seg(Int_Handler^) );
   STI_PROC;
end;



procedure STI_PROC;
begin
   inline($FB);
end;



procedure WriteByte(var F:FileOfByte;Value:byte);
  { Процедура записи в файл байта.}
  var
    Err:byte;
begin
   {$I-}
   Write(F,Value);
   Err:=IOResult;
   if Err<>0 then ErrorMsg(Err,fWriteErr+fUnknown);
end;



procedure WriteStr(var F:FileOfByte;WrStr:string);
  { Процедура записи строки в файл.}
  var
    StrSeg,StrOfs:word;
    Len,i:byte;
    Value:byte;
    Error:byte;
begin
{ $I-}
   StrSeg:=Seg(WrStr);
   StrOfs:=Ofs(WrStr);
   Len:=Peek(StrSeg,StrOfs);
   for i:=1 to Len do
      begin
         Inc(StrOfs);
         Value:=Peek(StrSeg,StrOfs);
         Write(F,Value);
         Error:=IOResult;
         if Error<>0 then ErrorMsg(Error,fWriteErr+fUnknown);
      end;
{ Перевод строки.}
  Value:=CR;
  WriteByte(F,Value);

  Value:=LF;
  WriteByte(F,Value);
end;









function AddNul(fStr:String;tStrLen:byte):string;
  { Увеличивает длину строки до требуемой добавляя слева символ нуля.}
  var
    i:byte;
    hStr:string;
begin
   hStr:='';
   for i:=1 to tStrLen-Length(fStr) do hStr:='0'+hStr;
   AddNul:=hStr+fStr;
end;



function AddSpace(Count:byte;fStr:String):string;
  { Увеличивает длину строки до требуемой добавляя справа пробелы.}
  var
    i:byte;
    hStr:string;
begin
   hStr:=fStr;
   for i:=1 to Count do hStr:=hStr+' ';
   AddSpace:=hStr;
end;



function AttrToStr(Attr:word):string;
  { Возвращает строку с названием атрибута(например 'System') для Attr=4.}
  var
    tStr:string;
    i:byte;
begin
   tStr:='';
   for i:=0 to 5 do
   case (Attr)and(1 shl i) of
       $01:tStr:=tStr+'READ ONLY ';
       $02:tStr:=tStr+'HIDDEN ';
       $04:tStr:=tStr+'SYSTEM ';
       $20:tStr:=tStr+'ARCHIVE ';
       $3F:tStr:='ANY FILE';
   end;
   AttrToStr:=tStr;
end;



function CompareByte(A,B:byte):boolean;
{ True если A=B.Если A<>B,и в командной строке имеется ключ /D-то происходит
  запись различающихся байтов в файл.}
  var
    Bool:boolean;
    ErrorC:byte;
begin
   Bool:=(A)=(B);
   with DiffFile do
   if (Not(Bool))and(WriteDiff) then
   { Отличающиеся байты записываются в файл( ключ /D ).}
          with DiffFile do WriteByte(Ptr,B);

   if Not(Bool) then Inc(DiffCount);

   CompareByte:=Bool;
end;



function CompareString(FirstStr,SecStr:string):boolean;
{ Тесты показывают корректную работу данной процедуры.}
  var
    FirstSeg,FirstOfs,SecSeg,SecOfs:word;
    Bool:boolean;
begin
   FirstSeg:=Seg(FirstStr);
   FirstOfs:=Ofs(FirstStr);

   SecSeg:=Seg(SecStr);
   SecOfs:=Ofs(SecStr);

   Bool:=CompareStr_Asm(FirstSeg,FirstOfs,SecSeg,SecOfs);

   if (Not(Bool))and(WriteDiff) then
   { Отличающиеся строки записываются в файл( ключ /D ). }
          with DiffFile do WriteStr(Ptr,SecStr);

   if Not(Bool) then Inc(DiffCount);

   CompareString:=Bool;
end;



function CompareStr_Asm(FirstSeg,FirstOfs,SecSeg,SecOfs:word):boolean;assembler;
{
  ФУНКЦИЯ ВОЗВРАЩАЕТ 0 ЕСЛИ СТРОКИ СЧИТАЮСЯ РАЗЛИЧНЫМИ,ЛИБО 1 ЕСЛИ СТРОКИ
  СЧИТАЮТСЯ ИДЕНТИЧНЫМИ.
  ТЕСТЫ ПОКАЗЫВАЮТ НЕКОРРЕКТНУЮ РАБОТУ ДАННОЙ ПРОЦЕДУРЫ.
}
label The_END,LEN_DIFF,CMP_LOOP;
asm
{ СОХРАНЯЕМ РЕГИСТРЫ.}
       PUSH ES
       PUSH DI
       PUSH DS
       PUSH SI

     { ES:[DI] - УКАЗАТЕЛЬ НА ПЕРВУЮ СТРОКУ;CL - ТЕКУЩАЯ ДЛИНА.}
     { DS:[SI] - УКАЗАТЕЛЬ НА ВТОРУЮ СТРОКУ.}

       MOV  AX,FIRSTSEG
       MOV  ES,AX
       MOV  DI,FIRSTOFS

       MOV  AX,SECSEG
       MOV  DS,AX
       MOV  SI,SECOFS

       XOR  CX,CX
{ AL - РАВЕН 0 ЕСЛИ СТРОКИ РАЗЛИЧНЫ,ЛИБО 1 ЕСЛИ СТРОКИ ИДЕНТИЧНЫ.}
       MOV  AL,0

{ BL - ДЛИНА ПЕРВОЙ СТРОКИ;BH - ДЛИНА ВТОРОЙ СТРОКИ.}
       MOV  BL,BYTE PTR ES:[DI]
       MOV  BH,BYTE PTR DS:[SI]

{ СТРОКИ ИМЕЮЩИЕ РАЗЛИЧНУЮ ДЛИНУ СЧИТАЮТСЯ РАЗЛИЧНЫМИ.}
       CMP  BL,BH
       JNE  THE_END

{ ДЛИНУ ЗАНОСИМ В CL.}
       MOV  CL,BL
       MOV  AX,$0001
       CMP  CL,AH
{ СТРОКИ НУЛЕВОЙ ДЛИНЫ СЧИТАЮТСЯ РАВНЫМИ.}
       JE   THE_END

       INC  SI
       INC  DI

CMP_LOOP:
{ ЦИКЛ ПОСИМВОЛЬНОГО СРАВНЕНИЯ СТРОК.}
       MOV  BL,BYTE PTR ES:[DI]
       MOV  BH,BYTE PTR DS:[SI]

       CMP  BL,BH
{ ПЕРЕХОД,ЕСЛИ НАЙДЕНЫ НЕИДЕНТЧНЫЕ БАЙТЫ.}
       JNE  LEN_DIFF

       INC  SI
       INC  DI

       LOOP CMP_LOOP
{ СТРОКИ СЧИТАЮТСЯ ИДЕНТИЧНЫМИ.}
       MOV  AL,1
       JMP  THE_END

LEN_DIFF:
{ СТРОКИ СЧИТАЮТСЯ РАЗЛИЧНЫМИ.}
       MOV  AL,0

THE_END:
{ ЗАГРУЖАЕМ РЕГИСТРЫ ИЗ СТЕКА.}
       POP  SI
       POP  DS
       POP  DI
       POP  ES
end;



function DecToStr(Dec:LongInt):string;
  var
    tStr:string;
begin
   Str(Dec,tStr);
   DecToStr:=tStr;
end;



function FileExists(FileName: String): Boolean;
  { Функция взята из Sample Prоgram Turbo Pascal 7.0 Help.}
  { Boolean function that returns True if the file exists;otherwise,
  it returns False. Closes the file if it exists. }
  var
    Bool:boolean;
    F: file;
begin
  {$I-}
   Assign(F, FileName);
   FileMode := 0;  { Set file access to read only }
   Reset(F);
   Close(F);
   FileExists := (IOResult = 0) and (FileName <> '');
end;  { FileExists }



function GetExt(Path:string):string;
  { Из Path выделяет три последние символа-расширение файла.}
  var
    Segment,Offset:word;
    tStr:string;
    Length,i:byte;
begin
   Segment:=Seg(Path);
   Offset:=Ofs(Path);
   tStr:='';

   Length:=Peek(Segment,Offset);
   Inc(Offset);
   Offset:=(Offset+Length)-3;

   for i:=0 to 2 do tStr:=tStr+Chr(Peek(Segment,Offset+i));
   GetExt:=tStr;
end;



function Min(A,B:LongInt):LongInt;
  { Возвращает минимальное.}
  var
    tMin:longInt;
begin
   if A<=B then tMin:=A else tMin:=B;
   Min:=tMin;
end;



function Peek(mSeg,mOfs:word):byte;assembler;
asm
     PUSH ES
     PUSH DI

     MOV  ES,mSEG
     MOV  DI,mOFS
     MOV  AL,BYTE PTR ES:[DI]

     POP  DI
     POP  ES

end;



function PeekW(mSeg,mOfs:word):word;assembler;
asm
     PUSH ES
     PUSH DI

     MOV  BX,MSEG
     MOV  ES,BX
     MOV  DI,MOFS
     MOV  AX,WORD PTR ES:[DI]

     POP  DI
     POP  ES
end;



function TimeToStr(PackTime:Longint):string;
  { Возвращает в строке время.}
  var
     DT:DateTime;
     tStr:string;

          procedure LittleProc(Ch:string;V:byte);
          { Ch- разделитель.}
          begin
             tStr:=tStr+CH+AddNul(DecToStr(V),2);
          end;

begin
   UnpackTime(PackTime,DT);
   tStr:=DecToStr(DT.Year);
   LittleProc('/',DT.Month);
   LittleProc('/',DT.Day);
   tStr:=tStr+'  ';
   LittleProc('',DT.Hour);
   LittleProc(':',DT.Min);
   LittleProc(':',DT.Sec);
   TimeToStr:=tStr;
end;



end.