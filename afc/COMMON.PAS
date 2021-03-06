unit common;
{  ซฅชแฅฉ . ฎชฎข.1996.ฎแแจ๏/ฎแชข .ฅซ.:(095)391-9540. }
{  Alexey Y. Bokow.1996.Russia/Moscow.Phone:(095)391-9540. }

{ โฎโ ฌฎคใซ์ แฎคฅเฆจโ ญ จกฎซฅฅ ็ แโฎ จแฏฎซ์งใฅฌ๋ฅ ฏเฎๆฅคใเ๋.}
interface

uses u_const;

                  {  .}

{ เฎๆฅคใเ   ข เจฉญฎฃฎ ง ขฅเ่ฅญจ๏.}
procedure Abnormal(Error:byte);

{ เฎๆฅคใเ   ข เจฉญฎฃฎ ง ขฅเ่ฅญจ๏ แ ข๋ขฎคฎฌ แฎฎโขฅโแขใ๎้ฅฃฎ แฎฎก้ฅญจ๏.}
procedure AbnormalMsg(Error:byte);

{ ซ์โฅเญ โจข  Write ฏเจ ข๋ขฎคฅ ญ  ํชเ ญ.}
procedure AltWrite(OutStr:string);

{ ซ์โฅเญ โจข  WriteLn ฏเจ ข๋ขฎคฅ ญ  ํชเ ญ.}
procedure AltWriteLn(OutStr:string);

procedure CLI_PROC;

{ ฎญขฅเโจเใฅโ จง คฅแ๏โจ็ญฎฃฎ ข แโเฎชใ,แฎคฅเฆ ้ใ๎ คฅแ๏โจ็ญฎฅ ฏเฅคแโ ขซฅญจฅ ็จแซ .}
procedure ConvertDecToStr(Dec:byte;var fStr:string);

{ ฎญขฅเโจเใฅโ จง คฅแ๏โจ็ญฎฃฎ ข แโเฎชใ,แฎคฅเฆ ้ใ๎ คขฎจ็ญฎฅ ฏเฅคแโ ขซฅญจฅ
  ็จแซ .}
procedure ConvertToBin(Value:byte;var BitStr:string);

{ ฎญขฅเโจเใฅโ จง คฅแ๏โจ็ญฎฃฎ ข แโเฎชใ,แฎคฅเฆ ้ใ๎ HEX ฏเฅคแโ ขซฅญจฅ ็จแซ .}
procedure ConvertHexToStr(Dec:byte;var HexStr:String);

{ ๋ขฎค แฎฎก้ฅญจ๏ ฎก ฎ่จกชฅ จ   ข เจฉญฎฅ ง ขฅเ่ฅญจฅ ฏเฎฃเ ฌฌ๋.}
procedure ErrorMsg(ErrCode:byte;ErrStr:string);

{ เฎๆฅคใเ  ฎโชเ๋ข ฅโ ไ ฉซ,ฏเจ ํโฎฌ แฎคฅเฆจฌฎฅ ไ ฉซ  ญฅ จงฌฅญ๏ฅโแ๏.}
procedure FileOpen(var FileVar:FileType);

{ เฎๆฅคใเ  ฎโชเ๋ข ฅโ ไ ฉซ,ฏเจ ํโฎฌ ฏเฅค๋คใ้ฅฅ แฎคฅเฆจฌฎฅ ไ ฉซ  โฅเ๏ฅโแ๏.}
procedure FileReWrite(var FileVar:FileType);

{ ฎงขเ ้ ฅโ โฅชใ้จฉ ฎกเ กฎโ็จช ฏเฅเ๋ข ญจ๏.}
procedure GetVector(Int_No:byte;var Int_Handler:pointer);

{  ฏจแ์ แโเฎชจ ฏฎ ฏฅเฅค ข ฅฌฎฌใ ใช ง โฅซ๎ ญ  ญฅฅ ข ขจคฅฎ ฏ ฌ๏โ์.}
procedure MemWrite(StrSeg,StrOfs:word);

{ ฅเฅขฎคจโ ชใเแฎเ ญ  ญ ็ ซฎ แซฅคใ๎้ฅฉ แโเฎชจ.}
procedure NextScrPos;

{ ๋ขฎค แฎฎก้ฅญจ๏ ฎ ฏเฎฃเ ฌฌฅ.}
procedure OutAuthorMsg;

{ ๋ขฎค โฅชใ้จๅ ญ แโเฎฅช.}
procedure OutCompareMode;

{ ๋ขฎค จญไฎเฌ ๆจจ ฎ ไ ฉซ ๅ(ฏใโ์,เ งฌฅเ จ โ.ฏ.).}
procedure OutFileInf;

{ ขฎค แฎฎก้ฅญจ๏ - ฏฎฌฎ้จ.}
procedure OutHelpMsg;

{ ๋ขฎคจโ ฎก๊ฅฌ ใฆฅ ข๋ฏฎซญฅญญฎฉ เ กฎโ๋.}
procedure OutProgress;

{ ฅเฅขฎคจโ ชใเแฎเ ญ  ฏเฅค๋คใ้ใ๎ แโเฎชใ.}
procedure PrevScrPosition;

{ จ่ฅโ Value ข mSeg:[mOfs].}
procedure Poke(mSeg,mOfs:word;Value:byte);

{ โซจ็ ฅโแ๏ ฎโ Poke โจฏฎฌ Value.}
procedure PokeW(mSeg,mOfs:word;Value:word);

{ จโ ฅโ ก ฉโ จง ไ ฉซ .}
procedure ReadByte(var FPtr:FileOfByte;var Value:byte);

{ แโ ญ ขซจข ฅโ ฎกเ กฎโ็จช ฏเฅเ๋ข ญจ๏.}
procedure SetVector(Int_No:byte;Int_Handler:pointer);

procedure STI_PROC;

{  ฏจแ์ ก ฉโ  ข ไ ฉซ.}
procedure WriteByte(var F:FileOfByte;Value:byte);

{  ฏจแ์ แโเฎชจ ข ไ ฉซ.}
procedure WriteStr(var F:FileOfByte;WrStr:string);


{ ฎงขเ ้ ฅโ แโเฎชใ แ โเฅกใฅฌฎฉ คซจญฎฉ,ฏเจ ญฅฎกๅฎคจฌฎแโจ คฎก ขซ๏๏ แซฅข  แจฌขฎซ '0'.}
function AddNul(fStr:String;tStrLen:byte):string;

{ ฎงขเ ้ ฅโ แโเฎชใ แ โเฅกใฅฌฎฉ คซจญฎฉ,ฏเจ ญฅฎกๅฎคจฌฎแโจ คฎก ขซ๏๏ แฏเ ข  ฏเฎกฅซ๋.}
function AddSpace(Count:byte;fStr:String):string;

{ ฎงขเ ้ ฅโ แโเฎชใ แ ญ งข ญจฅฌ  โเจกใโ (ญ ฏเจฌฅเ 'System') คซ๏ Attr=4.}
function AttrToStr(Attr:word):string;

{ True ฅแซจ A=B.แซจ A<>B,จ ข ชฎฌ ญคญฎฉ แโเฎชฅ จฌฅฅโแ๏ ชซ๎็ /D-โฎ ฏเฎจแๅฎคจโ
  ง ฏจแ์ เ งซจ็ ๎้จๅแ๏ ก ฉโฎข ข ไ ฉซ.}
function CompareByte(A,B:byte):boolean;

{ เฎๆฅคใเ  แเ ขญฅญจ๏ แโเฎช - ขฎงขเ ้ ฅโ True ใแซจ แโเฎชจ แ็จโ ๎โแ๏ จคฅญโจ็ญ๋ฌจ.}
function CompareString(FirstStr,SecStr:string):boolean;

{ แฏฎฌฎฃ โฅซ์ญ ๏ ฏเฎๆฅคใเ  คซ๏ ฏเฎๆฅคใเ๋ แเ ขญฅญจ๏ แโเฎช.}
function CompareStr_Asm(FirstSeg,FirstOfs,SecSeg,SecOfs:word):boolean;

{ ฎงขเ ้ ฅโ แโเฎชฎขฎฅ ฏเฅคแโ ขซฅญจฅ ็จแซ .}
function DecToStr(Dec:LongInt):string;

{ ฎงขเ ้ ฅโ False ฅแซจ ไ ฉซ  ญฅ แใ้ฅแโขใฅโ.}
function FileExists(FileName: String): Boolean;

{ ฎงขเ ้ฅโ ข๋คฅซฅญญ๋ฅ จง Path โเจ ฏฎแซฅคญจฅ แจฌขฎซ -เ แ่จเฅญจฅ ไ ฉซ .}
function GetExt(Path:string):string;

{ ฎงขเ ้ ฅโ ฌจญจฌ ซ์ญฎฅ.}
function Min(A,B:LongInt):LongInt;

{ ฎงขเ ้ ฅโ ก ฉโ จง mSeg:[mOfs].}
function Peek(mSeg,mOfs:word):byte;

{ โซจ็ ฅโแ๏ ฎโ Peek โจฏฎฌ ขฎงขเ ้ ฅฌฎฃฎ งญ ็ฅญจ๏.}
function PeekW(mSeg,mOfs:word):word;

{ ฎงขเ ้ ฅโ ฏฎ ใฏ ชฎข ญญฎฌใ งญ ็ฅญจ๎ ขเฅฌฅญจ แโเฎชใ แฎคฅเฆ ้ใ๎ ขเฅฌ๏.}
function TimeToStr(PackTime:Longint):string;






implementation

uses dos;


procedure Abnormal(Error:byte);
  { เฎๆฅคใเ   ข เจฉญฎฃฎ ง ขฅเ่ฅญจ๏ ฏเฎฃเ ฌฌ๋.
     ญญ ๏ ฏเฎๆฅคใเ  ข๋ง๋ข ฅโแ๏ ฏเจ ฎ่จกช ๅ ขขฎค -ข๋ขฎค (งคฅแ์ ํโฎ
    ฎ่จกชจ ฎฏฅเ ๆจจ ง ฏจแจ ญ  คจแช).เฎๆฅคใเ  ง ชเ๋ข ฅโ ขแฅ ไ ฉซ๋ จ
    ง ช ญ็จข ฅโ เ กฎโใ ฏเจ ฏฎฌฎ้จ Halt. ฏฅเฅฌฅญญฎฉ ErrorLevel
    ขฎงขเ ้ ฅโ ชฎค ฎ่จกชจ.}
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
    เฎๆฅคใเ   ข เจฉญฎฃฎ ง ขฅเ่ฅญจ๏ ฏเฎฃเ ฌฌ๋.
    ฎ ฏฅเฅค ข ฅฌฎฌใ ชฎคใ ฎ่จกชจ ไฎเฌจเใฅโ แฎฎโขฅโแขใ๎้จฅ แฎฎก้ฅญจฅ จ
    ง ขฅเ่ ฅโ ฏเฎฃเ ฌฌใ ( แฌ. Abnormal ).
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
  { ฅชฎโฎเ ๏  ซ์โฅเญ โจข  (ฏเจ ข๋ขฎคฅ ญ  ํชเ ญ) Write.โซจ็ ฅโแ๏ ฏเ๏ฌฎฉ
    ง ฏจแ์๎ ข ขจคฅฎ ฏ ฌ๏โ์,จ แฎฎโขฅโแโขฅญญฎ ขแฅ (ข โฎฌ ็จแซฅ ใฏเ ขซ๏๎้จฅ)
    แจฌขฎซ๋ ข๋ขฎคจโ ช ช ญ คฎ. ฏเจฌฅเ,ญฅ ฏจ้จโ ฏเจ ข๋ขฎคฅ แจฌขฎซ  แ ชฎคฎฌ 7,
      ข๋ขฎคจโ แฎฎโขฅโแโขใ๎้จฉ แจฌขฎซ ข ASCII จ โ.ฏ.ฎฏฎซญจโฅซ์ญ ๏ จญไฎเฌ ๆจ๏
    แฎคฅเฆจโแ๏ ข ชฎฌฌฅญโ เจ๏ๅ ช ฏเฎๆฅคใเฅ MemWrite.}
var
  StrSeg,StrOfs:word;
begin
    StrSeg:=Seg(OutStr);
    StrOfs:=Ofs(OutStr);
    MemWrite(StrSeg,StrOfs);
end;



procedure AltWriteLn(OutStr:string);
  { ซ์โฅเญ โจข  WriteLn ฏเจ ข๋ขฎคฅ ญ  ํชเ ญ.}
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
                             { ใกซจเฎข ญจฅ ข๋ขฎคจฌฎฉ จญไฎเฌ ๆจจ ข ไ ฉซฅ.}
                             with OutFile do WriteStr(Ptr,OutStr);
                          end;
   end;
end;



procedure CLI_PROC;
begin
  inline($FA);
end;



procedure ConvertDecToStr(Dec:byte;var fStr:string);
  { ฎญขฅเโจเใฅโ จง คฅแ๏โจ็ญฎฃฎ ข แโเฎชใ...}
  var
    tStr:string[MaxDecLen];
begin
   Str(Dec,tStr);
   tStr:=AddNul(tStr,MaxDecLen);
   fStr:=tStr;
end;



procedure  ConvertHexToStr(Dec:byte;var HexStr:String);
  { ฎญขฅเโจเใฅโ จง คฅแ๏โจ็ญฎฃฎ ข แโเฎชใ.โเฎช  แฎคฅเฆจโ ่ฅแโญ คๆ โจเจ็ญฎฅ
    ฏเฅคแโ ขซฅญจฅ ็จแซ .}
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

{ โ  ็ แโ์ ฏเฎๆฅคใเ๋ ญฅ กใคฅโ ชฎเเฅชโญฎ เ กฎโ โ์ แ ชฎคจเฎขชฎฉ EBCDIC.}
         if M<10 then  tStr:=chr(M+48) else tStr:=chr(M+55);

         HexStr:=HexStr+tStr;
         T:=T-(M*tPower);
      end;
end;



procedure ConvertToBin(Value:byte;var BitStr:string);
  { ฎญขฅเโจเใฅโ จง คฅแ๏โจ็ญฎฃฎ ข แโเฎชใ.โเฎช  แฎคฅเฆจโ คขฎจ็ญฎฅ
    ฏเฅคแโ ขซฅญจฅ ็จแซ .}
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

         M:=(M) SHR (i);{  เ ขญฎ 0 ซจกฎ 1.}

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
  { เฎๆฅคใเ  ฎโชเ๋ข ฅโ ไ ฉซ.
    แซใ็ ฅ ฎ่จกชจ ขขฎค -ข๋ขฎค  ฏเฎฃเ ฌฌ   ข เจฉญฎ ง ขฅเ่ ฅโแ๏.}
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
 { เฎๆฅคใเ  ฎโชเ๋ข ฅโ ไ ฉซ.
   แซจ ไ ฉซ ใฆฅ แใ้ฅแโขใฅโ,โฎ ฎญ ฅฃฎ ฏเฅฆญฅฅ แฎคฅเฆจฌฎฅ โฅเ๏ฅโแ๏.
    แซใ็ ฅ ฎ่จกชจ ขขฎค -ข๋ขฎค  ฏเฎฃเ ฌฌ   ข เจฉญฎ ง ขฅเ่ ฅโ แขฎ๎ เ กฎโใ.}
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
            
   .   TURBO-PASCAL:ASCII  
     .
        , 
   - 7 (        ).
     WRITE ,   
    (     
   ASCII ).   .
      10%   WRITE.
          EGA/VGA - 
  .

  :
    . .1996./..:(095)391-9540.
     -  / 1-01.

 PROCEDURE ELABORATION:
   ALEXEY Y. BOKOW.1996.RUSSIA/MOSCOW.PHONE:(095)391-9540.
   MOSCOW INSTITUTE OF ENGINEERING PHYSICS/GROUP B1-01.
}

label OVER_X,OVER_Y,COORD_OK,DEC_LOOP,ADD_SI,
          SCROLL_LOOP,FILL_LOOP,WRITE_LOOP,THE_END;
  asm
{  .}
        PUSH ES
        PUSH DI
        PUSH DS
        PUSH SI

{   .}
        MOV  AX,BIOSDATASEG
        MOV  ES,AX
        MOV  DI,$0062
       {   BH    ES:[DI](   ).}
        MOV  BH,BYTE PTR ES:[DI]

{   .}
        XOR  AX,AX
        MOV  AH,03
        INT  $10
       { INT 10h :
          DL -  X - ,
          DH -  Y - .}
       {     .}
        PUSH DX

{     .}

       {   .}
        MOV  AX,BIOSDATASEG
        MOV  ES,AX
        MOV  DI,$004A
        MOV  BX,WORD PTR ES:[DI] {     AX.}
        MOV  AX,BX

       {   Y -    .}
        IMUL  DH

       {      X - .}
        XOR  DH,DH
        ADD  AX,DX

       {   2,      2   .}
        SHL  AX,1

{       .}

       {    .}
        MOV  DI,$004E
        MOV  DX,WORD PTR ES:[DI]  {      DX.}

        ADD  AX,DX

        POP  DX

{      DS:[SI].}
        MOV  CX,STRSEG
        MOV  DS,CX
        MOV  SI,STROFS

{  .}

        XOR  CX,CX
        MOV  CL,BYTE PTR DS:[SI]
        {    .}
        CMP  CL,0
        JE   THE_END
        INC  SI

{   BIOS.}
        ADD  DL,CL


        {       .}
        PUSH DS
        PUSH SI
        PUSH CX
        PUSH AX

        {   X -    .}
        CMP  DL,BL

        JAE  OVER_X  { X -    .}

        MOV  DI,$0084
        MOV  AL,BYTE PTR ES:[DI]   {       AL.}

        {     Y - .}
        CMP  DH,AL

        JAE  OVER_Y { Y -      .}

        JMP  COORD_OK {   , .}

OVER_X:
        XOR  AX,AX
        {  DX   .}
        MOV  AL,DL
        {   BL   .}
        DIV  BL
        {   DH -     Y - ;
                  B DL - .}
        MOV  DL,AH
        ADD  DH,AL

        {   .}
        MOV  DI,$0084
        MOV  AL,BYTE PTR ES:[DI]   {       AL.}
{        DEC  AL}

        {  Y -    .}
        CMP  DH,AL
        JAE  OVER_Y { Y -      .}
        JMP  COORD_OK {   , .}

OVER_Y:
{  Y -          .}
        XOR  CX,CX

   DEC_LOOP:
        INC  CX      {     CX.}
        DEC  DH
        CMP  DH,AL   {     Y - .}
        JAE  DEC_LOOP

        PUSH DX
        PUSH CX

{   BIOS.}
        MOV  DI,$0062
        MOV  BH,BYTE PTR ES:[DI] {   BH
                       ES:[DI]( ).}
        XOR  AX,AX
        MOV  AH,02
        INT  $10

        POP  CX

{     ,   X.}

        {   .}
        MOV  DI,$004E
        MOV  DX,WORD PTR ES:[DI] {    
                                             DX.}

        {   .}
        MOV  DI,$004A
        MOV  BX,WORD PTR ES:[DI] {     BX.}
        SHL  BX,1 {     2 .}

        {   SI      CX
            .}
        XOR  SI,SI

ADD_SI: ADD  SI,BX
        LOOP ADD_SI

        PUSH SI

        {   .}
        MOV  DI,$004C
        MOV  CX,WORD PTR ES:[DI] {      CX.}
        {       .}
        SUB  CX,SI
        {   .}
        SHR  CX,1

        {  :
            ES:[DI] -  ,
            DS:[SI] -     CX.}

        MOV  DI,$004E
        MOV  DI,WORD PTR ES:[DI] { C  
                                         DI.}
        ADD  SI,DI

        MOV  AX,VIDEOSEG
        MOV  ES,AX
        MOV  DS,AX

        {   .}
        CLD

SCROLL_LOOP:

        MOVSW
        LOOP SCROLL_LOOP

        {      ASCII -  20h.}

        POP  CX
        PUSH CX

        MOV  AX,$0720

FILL_LOOP:
        MOV  WORD PTR ES:[DI],AX
        ADD  DI,2
        LOOP FILL_LOOP

        POP  CX
        POP  DX
        {  ,     
             ,    
                 .}
        POP  AX
        { ""  .}
        SUB  AX,CX
        PUSH AX

COORD_OK:
        POP  AX
        POP  CX
        POP  SI
        POP  DS

        PUSH AX

{   BIOS.}
        MOV  BX,BIOSDATASEG
        MOV  ES,BX
        MOV  DI,$0062
        MOV  BH,BYTE PTR ES:[DI] {   BH
                      ES:[DI]( ).}
        XOR  AX,AX

        MOV  AH,02
        INT  $10

        POP  AX

        MOV  BX,VIDEOSEG
        MOV  ES,BX
{   DI  (ES:[DI] -       ,
      ).}

        MOV  DI,AX

{   .}
        MOV  AL,7

        CLD

WRITE_LOOP:
        MOVSB           { DS:[SI]->ES:[DI]-  .}
        MOV  ES:[DI],AL {   ES:[DI] .}
        INC  DI         {  .}
        LOOP WRITE_LOOP
THE_END:
{    .}
        POP  SI
        POP  DS
        POP  DI
        POP  ES

end;



procedure NextScrPos;assembler;
{ ฅเฅขฎคจโ ชใเแฎเ ญ  ญ ็ ซฎ แซฅคใ๎้ฅฉ แโเฎชจ.}
asm
       PUSH ES
       PUSH DI

       MOV  AX,BIOSDATASEG
       MOV  ES,AX
       MOV  DI,$0062
       MOV  BH,BYTE PTR ES:[DI]{ BH=ES:[DI] -  .}

       PUSH BX    {    INT 10   BX.}

       XOR  AX,AX

       MOV  AH,03
       INT  $10

       POP  BX

       MOV  AH,02
       INC  DH   { Y_COORD:=Y_COORD+1.}
       MOV  DL,0
       INT  $10  {   BIOS     .}

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
  { ๋ขฎค โฅชใ้จๅ ญ แโเฎฅช ฏเฎฃเ ฌฌ๋.}
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

  { ๋ขฎค จญไฎเฌ ๆจจ ฎ ไ ฉซ ๅ.}
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

   AltWriteLn(' Inform tion about SECOND file.');
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
{ ฅเฅขฎคจโ ชใเแฎเ ญ  ญ ็ ซฎ ฏเฅค๋คใ้ฅฉ แโเฎชจ.}
asm
       PUSH ES
       PUSH DI

       MOV  AX,BIOSDATASEG
       MOV  ES,AX
       MOV  DI,$0062
       MOV  BH,BYTE PTR ES:[DI]{ BH=ES:[DI] -  .}

       PUSH BX    {    INT 10   BX.}

       XOR  AX,AX

       MOV  AH,03
       INT  $10

       POP  BX

       MOV  AH,02
       DEC  DH   { Y_COORD:=Y_COORD-1.}
       MOV  DL,0
       INT  $10  {   BIOS     .}

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
  { เฎๆฅคใเ  ง ฏจแจ ข ไ ฉซ ก ฉโ .}
  var
    Err:byte;
begin
   {$I-}
   Write(F,Value);
   Err:=IOResult;
   if Err<>0 then ErrorMsg(Err,fWriteErr+fUnknown);
end;



procedure WriteStr(var F:FileOfByte;WrStr:string);
  { เฎๆฅคใเ  ง ฏจแจ แโเฎชจ ข ไ ฉซ.}
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
{ ฅเฅขฎค แโเฎชจ.}
  Value:=CR;
  WriteByte(F,Value);

  Value:=LF;
  WriteByte(F,Value);
end;









function AddNul(fStr:String;tStrLen:byte):string;
  { ขฅซจ็จข ฅโ คซจญใ แโเฎชจ คฎ โเฅกใฅฌฎฉ คฎก ขซ๏๏ แซฅข  แจฌขฎซ ญใซ๏.}
  var
    i:byte;
    hStr:string;
begin
   hStr:='';
   for i:=1 to tStrLen-Length(fStr) do hStr:='0'+hStr;
   AddNul:=hStr+fStr;
end;



function AddSpace(Count:byte;fStr:String):string;
  { ขฅซจ็จข ฅโ คซจญใ แโเฎชจ คฎ โเฅกใฅฌฎฉ คฎก ขซ๏๏ แฏเ ข  ฏเฎกฅซ๋.}
  var
    i:byte;
    hStr:string;
begin
   hStr:=fStr;
   for i:=1 to Count do hStr:=hStr+' ';
   AddSpace:=hStr;
end;



function AttrToStr(Attr:word):string;
  { ฎงขเ ้ ฅโ แโเฎชใ แ ญ งข ญจฅฌ  โเจกใโ (ญ ฏเจฌฅเ 'System') คซ๏ Attr=4.}
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
{ True ฅแซจ A=B.แซจ A<>B,จ ข ชฎฌ ญคญฎฉ แโเฎชฅ จฌฅฅโแ๏ ชซ๎็ /D-โฎ ฏเฎจแๅฎคจโ
  ง ฏจแ์ เ งซจ็ ๎้จๅแ๏ ก ฉโฎข ข ไ ฉซ.}
  var
    Bool:boolean;
    ErrorC:byte;
begin
   Bool:=(A)=(B);
   with DiffFile do
   if (Not(Bool))and(WriteDiff) then
   { โซจ็ ๎้จฅแ๏ ก ฉโ๋ ง ฏจแ๋ข ๎โแ๏ ข ไ ฉซ( ชซ๎็ /D ).}
          with DiffFile do WriteByte(Ptr,B);

   if Not(Bool) then Inc(DiffCount);

   CompareByte:=Bool;
end;



function CompareString(FirstStr,SecStr:string):boolean;
{ ฅแโ๋ ฏฎช ง๋ข ๎โ ชฎเเฅชโญใ๎ เ กฎโใ ค ญญฎฉ ฏเฎๆฅคใเ๋.}
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
   { โซจ็ ๎้จฅแ๏ แโเฎชจ ง ฏจแ๋ข ๎โแ๏ ข ไ ฉซ( ชซ๎็ /D ). }
          with DiffFile do WriteStr(Ptr,SecStr);

   if Not(Bool) then Inc(DiffCount);

   CompareString:=Bool;
end;



function CompareStr_Asm(FirstSeg,FirstOfs,SecSeg,SecOfs:word):boolean;assembler;
{
    0    , 1  
   .
       .
}
label The_END,LEN_DIFF,CMP_LOOP;
asm
{  .}
       PUSH ES
       PUSH DI
       PUSH DS
       PUSH SI

     { ES:[DI] -    ;CL -  .}
     { DS:[SI] -    .}

       MOV  AX,FIRSTSEG
       MOV  ES,AX
       MOV  DI,FIRSTOFS

       MOV  AX,SECSEG
       MOV  DS,AX
       MOV  SI,SECOFS

       XOR  CX,CX
{ AL -  0   , 1   .}
       MOV  AL,0

{ BL -   ;BH -   .}
       MOV  BL,BYTE PTR ES:[DI]
       MOV  BH,BYTE PTR DS:[SI]

{      .}
       CMP  BL,BH
       JNE  THE_END

{    CL.}
       MOV  CL,BL
       MOV  AX,$0001
       CMP  CL,AH
{     .}
       JE   THE_END

       INC  SI
       INC  DI

CMP_LOOP:
{    .}
       MOV  BL,BYTE PTR ES:[DI]
       MOV  BH,BYTE PTR DS:[SI]

       CMP  BL,BH
{ ,   .}
       JNE  LEN_DIFF

       INC  SI
       INC  DI

       LOOP CMP_LOOP
{   .}
       MOV  AL,1
       JMP  THE_END

LEN_DIFF:
{   .}
       MOV  AL,0

THE_END:
{    .}
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
  { ใญชๆจ๏ ขง๏โ  จง Sample Prฎgram Turbo Pascal 7.0 Help.}
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
  { ง Path ข๋คฅซ๏ฅโ โเจ ฏฎแซฅคญจฅ แจฌขฎซ -เ แ่จเฅญจฅ ไ ฉซ .}
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
  { ฎงขเ ้ ฅโ ฌจญจฌ ซ์ญฎฅ.}
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
  { ฎงขเ ้ ฅโ ข แโเฎชฅ ขเฅฌ๏.}
  var
     DT:DateTime;
     tStr:string;

          procedure LittleProc(Ch:string;V:byte);
          { Ch- เ งคฅซจโฅซ์.}
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