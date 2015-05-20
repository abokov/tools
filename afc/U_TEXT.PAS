unit U_TEXT;

{  Алексей Ю. Боков.1996.Россия/Москва.Тел.:(095)391-9540. }
{  Alexey Y. Bokow.1996.Russia/Moscow.Phone:(095)391-9540. }

{ Этот модуль содержит процедуры используемые при текстовом сравнении.}
interface

uses common,u_const;

                { ЗАГОЛОВОКИ ПРОЦЕДУР.}


{ Процедура оставляет в строке только текcтовые символы.
  Текстовыми считаются символы с ASCII кодами от 20h до EFh (включительно).}
procedure ConvertToText(Var DestString:string);

{ Процедура изменяет строку в соответствии с параметрами командной строки.
  Например убирает из строки знаки табуляции и тому подобное.}
procedure MinimizeStr(var EString:string);

procedure MinimizeProc(Str_1:string;var Str_2:string);

{ Процедура чтения строки из файла.}
procedure ReadStr(var tFile:FileOfByte;var FileStr:string);

{ Основная процедура текстового сравнения.}
procedure TextCompare;


{ Возвращает Value в значение соответствующее верхнему регистру ASCII.}
function ConvToUpCase(Value:byte):byte;

{ Возвращает True,если Value текстовый символ (в коде ASCII).}
function InRange(Value:byte):boolean;


implementation


procedure ConvertToText(var DestString:string);
var
  RetString:string;
  StrSegment,StrOffset:word;
  i,Value,StrLength:byte;
begin
   StrSegment:=Seg(DestString);
   StrOffset:=Ofs(DestString);
   RetString:='';
   StrLength:=Peek(StrSegment,StrOffset);
   i:=0;

   for i:=1 to StrLength do
     begin
        Inc(StrOffset);
        Value:=Peek(StrSegment,StrOffset);
        if (Value>=MinASCII)and(Value<=MaxASCII) then RetString:=RetString+chr(Value);
     end;

   DestString:=RetString;
end;



procedure MinimizeStr(var EString:string);
  { Процедура изменяет строку в соответствии с параметрами командной строки.
    Например убирает из строки знаки табуляции и тому подобное.}
  var
    { Segment:[Offset] - указатель на текущий символ в строке.}
    Segment,Offset:word;
    { tStr-минимизированная строка.}
    tStr:string;
    Length,i,val:byte;
begin
   Segment:=Seg(EString);
   Offset:=Ofs(EString);

   Length:=Peek(Segment,Offset);
   Inc(Offset);

   tStr:='';
   for i:=1 to Length do
     begin
        { val - текущий символ в строке.}
        val:=Peek(Segment,Offset);
        Inc(Offset);
        if InRange(val) then
          begin
             { Eсли val - текстовый символ,то он прибавляется
               к минимизируемой строке.}
              if CaseIgnore then val:=ConvToUpCase(val);
              tStr:=tStr+chr(Val);
          end;
     end;
   { Возвращаем минимизированную строку.}
   EString:=tStr;
end;



procedure MinimizeProc(Str_1:string;var Str_2:string);
begin
   Str_2:=Str_1;
   MinimizeStr(Str_2);
end;



procedure ReadStr(var tFile:FileOfByte;var FileStr:string);
{ Процедура чтения строки из файла.}
  label Find_END;

  var
    i:word;
    val,err,count,t:byte;
    tStr,tStr_00:string;
    Find_SEP:boolean;
begin
   tStr:='';
   tStr_00:='';
   i:=0;

   while Not(Eof(tFile)) do
      begin
        { Длина строки превышает максимально допустимую.}
         if i>=255 then goto Find_End;
         Find_SEP:=false;

         ReadByte(tFile,val);

         if (CmpModel=Simple)and(val=CR) then
           begin
              { Найден символ - возврат каретки.}
              if Not(Eof(tFile)) then
              ReadByte(tFile,val) else goto Find_End;
              if (val=LF) then { Найден символ - перевод строки.}
                   goto Find_END;
           end;
         t:=0;

         Find_SEP:=( Val=ORD(Sep_1) )or( Val=ORD(Sep_2) );

         if ( Find_SEP )and( Not(CmpModel=Simple) ) then
            begin
   { Найден символ соответствующий концу утверждения.}
               tStr:=tStr+chr(val);
               goto Find_END;
            end;

         tStr:=tStr+chr(Val);
         Inc(i);
      end;

Find_END:
   { Возвращаем прочитанную строку.}
   FileStr:=tStr;
end;




procedure TextCompare;
label The_End;
{ Основная процедура текстового сравнения.}
  var
    Equ:boolean;
    MinLength,tPos:LongInt;
    ErrCode:byte;
    FirstStr,SecondStr,tFirstStr,tSecondStr:string;

begin
   if CmpModel=Clever then
     begin
        AltWriteLn(' Sorry...The CLEVER compare model is non ready to using.');
        goto The_End;
     end;

   MinLength:=Min(FirstFile.Size,SecondFile.Size);
   Equ:=True;
   tPos:=1;

   DiffCount:=0;

   while (tPos<=MinLength)and(Not(Eof(FirstFile.Ptr))) do
       begin
          with FirstFile do ReadStr(Ptr,FirstStr);
          with SecondFile do ReadStr(Ptr,SecondStr);
          OutProgress;

          { Минимизация строк для поcледующего сравнения.}
          MinimizeProc(FirstStr,tFirstStr);
          MinimizeProc(SecondStr,tSecondStr);

          if (CleanIgnore) then
             while (Length(tFirstStr)=0)and(Not(Eof(FirstFile.Ptr))) do
                begin
                   with FirstFile do ReadStr(Ptr,FirstStr);
                   MinimizeProc(FirstStr,tFirstStr);
                end;

          if (CleanIgnore) then
             while (Length(tSecondStr)=0)and(Not(Eof(SecondFile.Ptr))) do
                begin
                   with SecondFile do ReadStr(Ptr,SecondStr);
                   MinimizeProc(SecondStr,tSecondStr);
                end;


          if Not(CompareString(tFirstStr,tSecondStr)) then
             { Строки считаются различными.}
              begin
                 ConvertToText(FirstStr);
                 ConvertToText(SecondStr);

                 AltWriteLn('                                   ');
                 AltWriteLn(' Found DIFFERENCES STRING:');
                 AltWriteLn(' File '+FirstFile.Path+' contans:');
                 AltWriteLn(FirstStr);

                 { Вывод минимизированной строки-исключительно для отладки.}
                 if NowDebug then
                   begin
                      AltWriteLn('DEBUG INFO: 1st file string after Minimize:');
                      AltWriteLn(tFirstStr);
                      AltWriteLn(' ');
                   end;



                 AltWriteLn(' File '+SecondFile.Path+' contans:');
                 AltWriteLn(SecondStr);

                 { Вывод минимизированной строки-исключительно для отладки.}
                 if NowDebug then
                   begin
                      AltWriteLn('DEBUG INFO: 2nd file string after Minimize:');
                      AltWriteLn(tSecondStr);
                   end;

                 if Equ then Equ:=false;
              end;
          tPos:=tPos+Length(FirstStr)+2;
       end;

   with FirstFile do
   if  Size>MinLength then
     begin
         AltWriteLn(' First '+Path+' file contans:');
         while Not(Eof(Ptr)) do
          begin
             ReadStr(Ptr,FirstStr);
             MinimizeProc(FirstStr,FirstStr);
             AltWriteLn(FirstStr);
             if WriteDiff then WriteStr(DiffFile.Ptr,FirstStr);
            { Вывод минимизированной строки-исключительно для отладки.}
             if NowDebug then
                   begin
                      AltWriteLn('DEBUG INFO: 1st file string after Minimize:');
                      AltWriteLn(tFirstStr);
                   end;
           end;
     end;



   with SecondFile do
   if Size>MinLength then
     begin
         AltWriteLn(' Second '+Path+' file contans:');
         while Not(Eof(Ptr)) do
           begin
             ReadStr(Ptr,SecondStr);
             MinimizeProc(SecondStr,tSecondStr);
             AltWriteLn(SecondStr);
             if WriteDiff then WriteStr(DiffFile.Ptr,SecondStr);
            { Вывод минимизированной строки-исключительно для отладки.}
             if NowDebug then
                   begin
                      AltWriteLn('DEBUG INFO: 2nd file string after Minimize:');
                      AltWriteLn(tSecondStr);
                   end;
           end;
     end;



   if Equ then AltWriteLn(' No differences encountered.')

          else AltWriteLn(' Found '+DecToStr(DiffCount)+' differences string.');

The_End:

end;





function ConvToUpCase(Value:byte):byte;assembler;
{
  Модифицированная (для работы с кириллицей) процедура преобразования букв.
  Оригинальная процедура преобразования букв приведена в книге
  Ленни Дао,"Программирование микропроцессора 8088."- М.Мир;1988.стр.277.
  Процедура преобразования строчной буквы в регистре AL в прописную.
  Для английских букв процедура работает с кодировкой ASCII,
  для кириллицы-с альтернативной кодировкой ГОСТа,либо альтернативной
  модифицированной кодировкой ГОСТа.
}
label Upper_Eng_Done,Upper_Done,Cmp_2nd_Half,Inv;
asm
  MOV AL,VALUE

  CMP AL,$61        { ПРОВЕРКА,ЯВЛЯЕТСЯ ЛИ БУКВА АНГЛИЙСКОЙ СТРОЧНОЙ.}
  JB  UPPER_ENG_DONE

  CMP AL,$7A
  JA  UPPER_ENG_DONE

  AND AL,01011111b  { ДЛЯ АНГЛИЙСКИХ БУКВ - ОБРАЩЕНИЕ ПЯТОГО БИТА В НУЛЬ.}

  JMP UPPER_DONE

UPPER_ENG_DONE:     { БУКВА НЕ ЯВЛЯЕТСЯ АНГЛИЙСКОЙ СТРОЧНОЙ.}

  CMP AL,$A0        { ПРОВЕРКА,ЯВЛЯЕТСЯ ЛИ БУКВА РУССКОЙ СТРОЧНОЙ.}
  JB  UPPER_DONE

  CMP AL,$AF
  JA  CMP_2ND_HALF  { РУССКИЕ СТРОЧНЫЕ БУКВЫ РАСПОЛОЖЕНЫ В ASCII НЕ ПОДРЯД.}

  AND AL,11001111b  { ОБРАЩЕНИЕ ПЯТОГО БИТА В НУЛЬ.}

  JMP UPPER_DONE

CMP_2ND_HALF:

  CMP AL,$E0         { ПРОВЕРКА,ЯВЛЯЕТСЯ ЛИ БУКВА РУССКОЙ СТРОЧНОЙ.}
  JB  UPPER_DONE

  CMP AL,$EF
  JA  UPPER_DONE

  AND AL,10001111b  { ОБРАЩЕНИЕ ШЕСТОЙ И ПЯТОЙ ПОЗИЦИИ В НУЛЬ.}
  OR  AL,00010000b  { ОБРАЩЕНИЕ ЧЕТВЕРТОГО БИТА В ЕДИНИЦУ.}

UPPER_DONE:

end;





function InRange(Value:byte):boolean;
  { Возвращает True,если Chr(Value) является текстовым символом ASCII.}
  var
    Bool:boolean;
begin
   Bool:=(Value>=MinASCII)and(Value<=MaxASCII);
   if (SpaceIgnore)and(Value=Space) then Bool:=False;
   InRange:=Bool;
end;

end.