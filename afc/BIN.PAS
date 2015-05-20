unit BIN;

{  Алексей Ю. Боков.1996.Россия/Москва.Тел.:(095)391-9540. }
{  Alexey Y. Bokow.1996.Russia/Moscow.Phone:(095)391-9540. }

{ Этот модуль содержит процедуры используемые при двоичном сравнении файлов.}
interface

uses common,u_const;

          { ЗАГОЛОВКИ ПРОЦЕДУР.}

{ Основная процедура двоичного сравнения.}
procedure BinCompare;

{ Процедура формирования выводимой строки.Строка содержит информацию о
  различающихся байтах сравниваемых файлов.}
procedure FormString(Offset:LongInt;Value_1,Value_2:byte;var OutStr:String);

procedure FormHalfString(Offset:LongInt;Value_1:byte;var OutStr:string);

{ Процедура вывода строки по задаваемому байту.}
procedure OutHalfBin(Offset:Longint;Value:byte);

{ Процедура вывода строки по задаваемым байтам.}
procedure OutPutBin(Offset:LongInt;Value_1,Value_2:byte);

{ Процедура двоичного сравнения.}
procedure Cmp;



implementation

procedure BinCompare;
  { Процедура двоичного сравнения файлов.}
begin
   Cmp;
end;



procedure FormString(Offset:LongInt;Value_1,Value_2:byte;var OutStr:String);
  { Формирует выводимую строку.Строка содержит:
    смещение от начала файла,десятичное,двоичное,шестнадцатиричное и
    ASCII представления различающихся байтов двух файлов.}

        procedure LittleProc(Value:byte;var fStr:String);
          { Эта процедура выполняет некоторое формирование элементов строки.
            Она выполняется для каждой строки два раза:
            для содержимого первого и второго файлов..}
          var
            tStr:String;
        begin
           fStr:=AddSpace(Ofs_Dec,fStr);
           { Формирует десятичное представление...}
           ConvertDecToStr(Value,tStr);
           fStr:=fStr+tStr;

           fStr:=AddSpace(Dec_Hex,fStr);
           { Формирует шестнадцатиричное представление...}
           ConvertHexToStr(Value,tStr);
           fStr:=fStr+tStr;

           fStr:=AddSpace(Hex_ASCII,fStr);
           { Формирует ASCII представление.}
           fStr:=fStr+Chr(Value);

           fStr:=AddSpace(ASCII_Bin,fStr);
           { Формирует двоичное представление...}
           ConvertToBin(Value,tStr);

           fStr:=fStr+tStr;
        end;

  var
    tOutStr:String;
begin
   Str(Offset,tOutStr);
   tOutStr:=AddNul(tOutStr,Size_Len);

   tOutStr:=' '+tOutStr;

   LittleProc(Value_1,tOutStr);
   LittleProc(Value_2,tOutStr);

{   tOutStr:=AddSpace(StrLen,tOutStr);}

   OutStr:=tOutStr;
end;


procedure FormHalfString(Offset:LongInt;Value_1:byte;var OutStr:string);
  { Формирует выводимую строку.Строка содержит:
    смещение от начала файла,десятичное,двоичное,шестнадцатиричное и
    ASCII представления различающихся байтов двух файлов.}

        procedure LittleProc(Value:byte;var fStr:String);
          { Эта процедура выполняет некоторое формирование элементов строки.
            Она выполняется для каждой строки два раза:
            для содержимого первого и второго файлов..}
          var
            tStr:String;
        begin
           fStr:=AddSpace(Ofs_Dec,fStr);
           { Формирует десятичное представление...}
           ConvertDecToStr(Value,tStr);
           fStr:=fStr+tStr;

           fStr:=AddSpace(Dec_Hex,fStr);
           { Формирует шестнадцатиричное представление...}
           ConvertHexToStr(Value,tStr);
           fStr:=fStr+tStr;

           fStr:=AddSpace(Hex_ASCII,fStr);
           { Формирует ASCII представление.}
           fStr:=fStr+Chr(Value);

           fStr:=AddSpace(ASCII_Bin,fStr);
           { Формирует двоичное представление...}
           ConvertToBin(Value,tStr);

           fStr:=fStr+tStr;
        end;

  var
    tOutStr:String;
begin
   Str(Offset,tOutStr);
   tOutStr:=AddNul(tOutStr,Size_Len);

   tOutStr:=' '+tOutStr;

   LittleProc(Value_1,tOutStr);

   OutStr:=tOutStr;

end;



procedure OutHalfBin(Offset:Longint;Value:byte);
{ Процедура вывола строки по задаваемому байту.}
  var
    Out:String;
begin
   FormHalfString(Offset,Value,Out);
   AltWriteLn(Out);
end;




procedure OutPutBin(Offset:LongInt;Value_1,Value_2:byte);
  { Процедура вывода строки содержащей информацию о различающихся байтах.}
  var
    Out:String;
begin
   FormString(Offset,Value_1,Value_2,Out);
   AltWriteLn(Out);
end;



procedure Cmp;
{ Сравнение байтов имеющих одинаковое смещение от начала файла.}
  var
    { Размер наименьшего файла и текущая позиция.}
    MinLength,tPos:longInt;
    { Переменная равна True если предыдущие значения прочитанных байтов оказались равными.}
    PrevEqu:boolean;
    { Переменная равна True если не найдено различающихся байтов.}
    Equ:boolean;
    { Значения байтов прочитанных из файлов.}
    PrevFirstValue,PrevSecondValue,ErrCode,FirstValue,SecondValue:byte;

begin
   MinLength:=Min(FirstFile.Size,SecondFile.Size);
   { Если файлы имеют различную длину,то файлы считаются различными.}
   Equ:=( FirstFile.Size=SecondFile.Size );
   tPos:=0;

   { DiffCount - счетчик различий.}
   DiffCount:=0;
   PrevEqu:=True;

   AltWriteLn(ScaleStr);
   Case MinimOutput of

     False:
             while tPos<MinLength do
                begin
     { Режим полного вывода - выводятся все различающиеся байты.}
                   ReadByte(FirstFile.Ptr,FirstValue);
                   ReadByte(SecondFile.Ptr,SecondValue);
                   if Not(CompareByte(FirstValue,SecondValue)) then
                   begin
                       OutPutBin(tPos,FirstValue,SecondValue);
                       if Equ then Equ:=false;
                   end;
                   Inc(tPos);
                end;
      True:


        begin

            { Режим сокращенного вывода:
            выводятся первый и последний различающиеся байты.}
            ReadByte(FirstFile.Ptr,FirstValue);
            ReadByte(SecondFile.Ptr,SecondValue);

            if Not( CompareByte(FirstValue,SecondValue) ) then
                  begin
            { Файлы начинаются с различающихся байтов.}
                       AltWriteLn(' FOUND FIRST DIFFERENCES AT POSITION:'+DecToStr(tPos)+'.');
                       OutPutBin(tPos,PrevFirstValue,PrevSecondValue);
                       OutPutBin(tPos+1,FirstValue,SecondValue);
                       PrevEqu:=false;
                       Equ:=false;
                    end;

             while (tPos+1<MinLength) do

                begin
                   ReadByte(FirstFile.Ptr,FirstValue);
                   ReadByte(SecondFile.Ptr,SecondValue);
                   case CompareByte(FirstValue,SecondValue) of
                     False:
                          begin
                          { Найдены первые различающиеся байты;предыдущие байты
                           были одинаковыми.}
                             if PrevEqu then
                                begin
                                   AltWriteLn(' FOUND FIRST DIFFERENCES AT POSITION:'+DecToStr(tPos+1)+'.');
                                   OutPutBin(tPos,PrevFirstValue,PrevSecondValue);
                                   OutPutBin(tPos+1,FirstValue,SecondValue);
                                   PrevEqu:=false;
                                   if Equ then Equ:=false;
                                end;
                          end;
                     True:
                          begin
                              if (PrevFirstValue<>PrevSecondValue)and
                                  (Not(PrevEqu)) then
                                begin
    { Найдены первые одинаковые байты;предыдущие байты были различающимися.}
                                   AltWriteLn(' THE LAST DIFFERENCES BYTE AT POSITION:'+DecToStr(tPos)+'.');
                                   OutPutBin(tPos,PrevFirstValue,PrevSecondValue);
                                   OutPutBin(tPos+1,FirstValue,SecondValue);
                                   PrevEqu:=true;
                                   if Equ then Equ:=false;
                                 end;
                          end;
                end;
                Inc(tPos);
                PrevFirstValue:=FirstValue;
                PrevSecondValue:=SecondValue;
                OutProgress;
             end;

        end;
   end;

   with FirstFile do
   if FirstFile.Size>MinLength then
     begin
         AltWriteLn(' First file is more big second file ->');
         AltWriteLn(HalfScaleStr);
         with FirstFile do
          while Not(Eof(Ptr)) do
              begin
{ Сравниваемые файлы имеют различные размеры...}
                 ReadByte(Ptr,FirstValue);
                 if WriteDiff then WriteByte(DiffFile.Ptr,FirstValue);
                 OutHalfBin(tPos,FirstValue);
                 Inc(tPos);
              end;
     end;



   with SecondFile do
   if Size>MinLength then
     begin
         AltWriteLn(' Second file is more big first file ->');
         AltWriteLn(HalfScaleStr);
         while Not(Eof(Ptr)) do
              begin
{ Сравниваемые файлы имеют различные размеры...}
                 ReadByte(Ptr,SecondValue);
                 if WriteDiff then  WriteByte(DiffFile.Ptr,SecondValue);
                 OutHalfBin(tPos,SecondValue);
                 Inc(tPos);
              end;
     end;


{ К подсчитанному числу различающихся байтов добавляется разница в размере.}
   DiffCount:=DiffCount+abs(FirstFile.Size-SecondFile.Size);

   if Equ then AltWriteLn('   NO differences encountered.') else
      AltWriteln(' Found '+DecToStr(DiffCount)+' differences bytes.');

end;

end.