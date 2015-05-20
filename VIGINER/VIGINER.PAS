uses strings;
const CryptArray:array[0..31] of byte=(
 ord('А'),ord('Б'),ord('В'),ord('Г'),  ord('Д'),ord('Е'),ord('Ж'),ord('З'),
{200}
 ord('И'),ord('Й'),ord('К'),ord('Л'),  ord('М'),ord('Н'),ord('О'),ord('П'),
{208}
 ord('Р'),ord('С'),ord('Т'),ord('У'),  ord('Ф'),ord('Х'),ord('Ц'),ord('Ч'),
{216}
 ord('Ш'),ord('Щ'),ord('Ъ'),ord('Ы'),  ord('Ь'),ord('Э'),ord('Ю'),ord('Я')
{ ord('Ш'),ord('Щ'),234, 235,  236,ord('Э'),ord('Ю'),ord('Я')}
);

function ConvToUpCase(Value:byte):byte;forward;

function crypt(c:byte;key:byte):char;
var b,a:word;
begin
  b:=c-ord('А');
  a:=key-ord('А');
  b:=a+b;
  crypt:=char(CryptArray[b mod 32]);
end;

procedure CryptString(var src:string;var out:string;var key:string);
var i:byte; i2:byte;
begin
  i2:=1; out:='';
  for i:=1 to length(src) do begin
    src[i]:=char(ConvToUpCase(ord(src[i])));
    if (src[i] in ['А'..'Я']) then begin
       out:=out+crypt(ord(src[i]),ConvToUpCase(ord(key[i2])));
       if (i2>=length(key)) then i2:=1
       else i2:=i2+1;
    end else out:=out+src[i];
  end;
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


var
 Src,Out,Key:Text;
 str_src,str_out,str_key:string;
begin
 if (ParamCount<3) then begin
    WriteLn('Usage : VIGINER source output key');
    exit;
 end;
 Assign(Src,ParamStr(1)); Reset(src);
 Assign(Out,ParamStr(2)); ReWrite(Out);
 Assign(Key,ParamStr(3)); Reset(Key);
 ReadLn(Key,str_key);
 close(key);

 while Not(Eof(src)) do begin
     ReadLn(Src,str_src);
     CryptString(str_src,str_out,str_key);
     WriteLn(Out,str_out);
 end;

 Close(src); Close(out);
 WriteLn('Bye...');
end.




