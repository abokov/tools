uses strings;
const CryptArray:array[0..31] of byte=(
 ord(''),ord(''),ord(''),ord(''),  ord(''),ord(''),ord(''),ord(''),
{200}
 ord(''),ord(''),ord(''),ord(''),  ord(''),ord(''),ord(''),ord(''),
{208}
 ord(''),ord(''),ord(''),ord(''),  ord(''),ord(''),ord(''),ord(''),
{216}
 ord(''),ord(''),ord(''),ord(''),  ord(''),ord(''),ord(''),ord('')
{ ord(''),ord(''),234, 235,  236,ord(''),ord(''),ord('')}
);

function ConvToUpCase(Value:byte):byte;forward;

function crypt(c:byte;key:byte):char;
var b,a:word;
begin
  b:=c-ord('');
  a:=key-ord('');
  b:=a+b;
  crypt:=char(CryptArray[b mod 32]);
end;

procedure CryptString(var src:string;var out:string;var key:string);
var i:byte; i2:byte;
begin
  i2:=1; out:='';
  for i:=1 to length(src) do begin
    src[i]:=char(ConvToUpCase(ord(src[i])));
    if (src[i] in [''..'']) then begin
       out:=out+crypt(ord(src[i]),ConvToUpCase(ord(key[i2])));
       if (i2>=length(key)) then i2:=1
       else i2:=i2+1;
    end else out:=out+src[i];
  end;
end;


function ConvToUpCase(Value:byte):byte;assembler;
{
  ฎคจไจๆจเฎข ญญ ๏ (คซ๏ เ กฎโ๋ แ ชจเจซซจๆฅฉ) ฏเฎๆฅคใเ  ฏเฅฎกเ งฎข ญจ๏ กใชข.
  เจฃจญ ซ์ญ ๏ ฏเฎๆฅคใเ  ฏเฅฎกเ งฎข ญจ๏ กใชข ฏเจขฅคฅญ  ข ชญจฃฅ
  ฅญญจ  ฎ,"เฎฃเ ฌฌจเฎข ญจฅ ฌจชเฎฏเฎๆฅแแฎเ  8088."- .จเ;1988.แโเ.277.
  เฎๆฅคใเ  ฏเฅฎกเ งฎข ญจ๏ แโเฎ็ญฎฉ กใชข๋ ข เฅฃจแโเฅ AL ข ฏเฎฏจแญใ๎.
  ซ๏  ญฃซจฉแชจๅ กใชข ฏเฎๆฅคใเ  เ กฎโ ฅโ แ ชฎคจเฎขชฎฉ ASCII,
  คซ๏ ชจเจซซจๆ๋-แ  ซ์โฅเญ โจขญฎฉ ชฎคจเฎขชฎฉ  ,ซจกฎ  ซ์โฅเญ โจขญฎฉ
  ฌฎคจไจๆจเฎข ญญฎฉ ชฎคจเฎขชฎฉ  .
}
label Upper_Eng_Done,Upper_Done,Cmp_2nd_Half,Inv;
asm
  MOV AL,VALUE

  CMP AL,$61        { ,    .}
  JB  UPPER_ENG_DONE

  CMP AL,$7A
  JA  UPPER_ENG_DONE

  AND AL,01011111b  {    -     .}

  JMP UPPER_DONE

UPPER_ENG_DONE:     {     .}

  CMP AL,$A0        { ,    .}
  JB  UPPER_DONE

  CMP AL,$AF
  JA  CMP_2ND_HALF  {      ASCII  .}

  AND AL,11001111b  {     .}

  JMP UPPER_DONE

CMP_2ND_HALF:

  CMP AL,$E0         { ,    .}
  JB  UPPER_DONE

  CMP AL,$EF
  JA  UPPER_DONE

  AND AL,10001111b  {       .}
  OR  AL,00010000b  {     .}

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




