unit common;
{  ����ᥩ �. �����.1996.�����/��᪢�.���.:(095)391-9540. }
{  Alexey Y. Bokow.1996.Russia/Moscow.Phone:(095)391-9540. }

{ ��� ����� ᮤ�ন� �������� ��� �ᯮ��㥬� ��楤���.}
interface

uses u_const;

                  { ��������� ��������.}

{ ��楤�� ���਩���� �����襭��.}
procedure Abnormal(Error:byte);

{ ��楤�� ���਩���� �����襭�� � �뢮��� ᮮ⢥����饣� ᮮ�饭��.}
procedure AbnormalMsg(Error:byte);

{ ����ୠ⨢� Write �� �뢮�� �� ��࠭.}
procedure AltWrite(OutStr:string);

{ ����ୠ⨢� WriteLn �� �뢮�� �� ��࠭.}
procedure AltWriteLn(OutStr:string);

procedure CLI_PROC;

{ ���������� �� �����筮�� � ��ப�,ᮤ�ঠ��� �����筮� �।�⠢����� �᫠.}
procedure ConvertDecToStr(Dec:byte;var fStr:string);

{ ���������� �� �����筮�� � ��ப�,ᮤ�ঠ��� ����筮� �।�⠢�����
  �᫠.}
procedure ConvertToBin(Value:byte;var BitStr:string);

{ ���������� �� �����筮�� � ��ப�,ᮤ�ঠ��� HEX �।�⠢����� �᫠.}
procedure ConvertHexToStr(Dec:byte;var HexStr:String);

{ �뢮� ᮮ�饭�� �� �訡�� �  ���਩��� �����襭�� �ணࠬ��.}
procedure ErrorMsg(ErrCode:byte;ErrStr:string);

{ ��楤�� ���뢠�� 䠩�,�� �⮬ ᮤ�ন��� 䠩�� �� ���������.}
procedure FileOpen(var FileVar:FileType);

{ ��楤�� ���뢠�� 䠩�,�� �⮬ �।��饥 ᮤ�ন��� 䠩�� ������.}
procedure FileReWrite(var FileVar:FileType);

{ �����頥� ⥪�騩 ��ࠡ��稪 ���뢠���.}
procedure GetVector(Int_No:byte;var Int_Handler:pointer);

{ ������ ��ப� �� ��।�������� 㪠��⥫� �� ��� � ����� ������.}
procedure MemWrite(StrSeg,StrOfs:word);

{ ��ॢ���� ����� �� ��砫� ᫥���饩 ��ப�.}
procedure NextScrPos;

{ �뢮� ᮮ�饭�� � �ணࠬ��.}
procedure OutAuthorMsg;

{ �뢮� ⥪��� ����஥�.}
procedure OutCompareMode;

{ �뢮� ���ଠ樨 � 䠩���(����,ࠧ��� � �.�.).}
procedure OutFileInf;

{ ���� ᮮ�饭�� - �����.}
procedure OutHelpMsg;

{ �뢮��� ��ꥬ 㦥 �믮������� ࠡ���.}
procedure OutProgress;

{ ��ॢ���� ����� �� �।����� ��ப�.}
procedure PrevScrPosition;

{ ���� Value � mSeg:[mOfs].}
procedure Poke(mSeg,mOfs:word;Value:byte);

{ �⫨砥��� �� Poke ⨯�� Value.}
procedure PokeW(mSeg,mOfs:word;Value:word);

{ ��⠥� ���� �� 䠩��.}
procedure ReadByte(var FPtr:FileOfByte;var Value:byte);

{ ��⠭�������� ��ࠡ��稪 ���뢠���.}
procedure SetVector(Int_No:byte;Int_Handler:pointer);

procedure STI_PROC;

{ ������ ���� � 䠩�.}
procedure WriteByte(var F:FileOfByte;Value:byte);

{ ������ ��ப� � 䠩�.}
procedure WriteStr(var F:FileOfByte;WrStr:string);


{ �����頥� ��ப� � �ॡ㥬�� ������,�� ����室����� �������� ᫥�� ᨬ��� '0'.}
function AddNul(fStr:String;tStrLen:byte):string;

{ �����頥� ��ப� � �ॡ㥬�� ������,�� ����室����� �������� �ࠢ� �஡���.}
function AddSpace(Count:byte;fStr:String):string;

{ �����頥� ��ப� � ��������� ��ਡ��(���ਬ�� 'System') ��� Attr=4.}
function AttrToStr(Attr:word):string;

{ True �᫨ A=B.�᫨ A<>B,� � ��������� ��ப� ������� ���� /D-� �ந�室��
  ������ ࠧ�������� ���⮢ � 䠩�.}
function CompareByte(A,B:byte):boolean;

{ ��楤�� �ࠢ����� ��ப - �����頥� True �᫨ ��ப� ������� ������묨.}
function CompareString(FirstStr,SecStr:string):boolean;

{ �ᯮ����⥫쭠� ��楤�� ��� ��楤��� �ࠢ����� ��ப.}
function CompareStr_Asm(FirstSeg,FirstOfs,SecSeg,SecOfs:word):boolean;

{ �����頥� ��ப���� �।�⠢����� �᫠.}
function DecToStr(Dec:LongInt):string;

{ �����頥� False �᫨ 䠩�� �� �������.}
function FileExists(FileName: String): Boolean;

{ ������� �뤥����� �� Path �� ��᫥���� ᨬ����-���७�� 䠩��.}
function GetExt(Path:string):string;

{ �����頥� �������쭮�.}
function Min(A,B:LongInt):LongInt;

{ �����頥� ���� �� mSeg:[mOfs].}
function Peek(mSeg,mOfs:word):byte;

{ �⫨砥��� �� Peek ⨯�� �����頥���� ���祭��.}
function PeekW(mSeg,mOfs:word):word;

{ �����頥� �� 㯠��������� ���祭�� �६��� ��ப� ᮤ�ঠ��� �६�.}
function TimeToStr(PackTime:Longint):string;






implementation

uses dos;


procedure Abnormal(Error:byte);
  { ��楤�� ���਩���� �����襭�� �ணࠬ��.
    ������ ��楤�� ��뢠���� �� �訡��� �����-�뢮��(����� ��
    �訡�� ����樨 ����� �� ���).��楤�� ����뢠�� �� 䠩�� �
    �����稢��� ࠡ��� �� ����� Halt.� ��६����� ErrorLevel
    �����頥� ��� �訡��.}
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
    ��楤�� ���਩���� �����襭�� �ணࠬ��.
    �� ��।�������� ���� �訡�� �ନ��� ᮮ⢥����騥 ᮮ�饭�� �
    �����蠥� �ணࠬ�� ( �. Abnormal ).
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
  { ������� ����ୠ⨢� (�� �뢮�� �� ��࠭) Write.�⫨砥��� ��אַ�
    ������� � ����� ������,� ᮮ⢥��⢥��� �� (� ⮬ �᫥ �ࠢ���騥)
    ᨬ���� �뢮��� ��� ����.���ਬ��,�� ���� �� �뢮�� ᨬ���� � ����� 7,
    � �뢮��� ᮮ⢥�����騩 ᨬ��� � ASCII � �.�.�������⥫쭠� ���ଠ��
    ᮤ�ন��� � ���������� � ��楤�� MemWrite.}
var
  StrSeg,StrOfs:word;
begin
    StrSeg:=Seg(OutStr);
    StrOfs:=Ofs(OutStr);
    MemWrite(StrSeg,StrOfs);
end;



procedure AltWriteLn(OutStr:string);
  { ����ୠ⨢� WriteLn �� �뢮�� �� ��࠭.}
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
                             { �㡫�஢���� �뢮����� ���ଠ樨 � 䠩��.}
                             with OutFile do WriteStr(Ptr,OutStr);
                          end;
   end;
end;



procedure CLI_PROC;
begin
  inline($FA);
end;



procedure ConvertDecToStr(Dec:byte;var fStr:string);
  { ���������� �� �����筮�� � ��ப�...}
  var
    tStr:string[MaxDecLen];
begin
   Str(Dec,tStr);
   tStr:=AddNul(tStr,MaxDecLen);
   fStr:=tStr;
end;



procedure  ConvertHexToStr(Dec:byte;var HexStr:String);
  { ���������� �� �����筮�� � ��ப�.��ப� ᮤ�ন� ��⭠����筮�
    �।�⠢����� �᫠.}
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

{ �� ���� ��楤��� �� �㤥� ���४⭮ ࠡ���� � ����஢��� EBCDIC.}
         if M<10 then  tStr:=chr(M+48) else tStr:=chr(M+55);

         HexStr:=HexStr+tStr;
         T:=T-(M*tPower);
      end;
end;



procedure ConvertToBin(Value:byte;var BitStr:string);
  { ���������� �� �����筮�� � ��ப�.��ப� ᮤ�ন� ����筮�
    �।�⠢����� �᫠.}
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

         M:=(M) SHR (i);{ � ࠢ�� 0 ���� 1.}

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
  { ��楤�� ���뢠�� 䠩�.
   � ��砥 �訡�� �����-�뢮�� �ணࠬ�� ���਩�� �����蠥���.}
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
 { ��楤�� ���뢠�� 䠩�.
   �᫨ 䠩� 㦥 �������,� �� ��� �०��� ᮤ�ন��� ������.
   � ��砥 �訡�� �����-�뢮�� �ணࠬ�� ���਩�� �����蠥� ᢮� ࠡ���.}
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
    ��������� ������ �� ����� ������ �� ������������ �������� �
  �������� ������.������ � ������� TURBO-PASCAL:ASCII ��� �������
  ������� ������������� ����� ������.
    ������ ������������ �� ������� �������������,������� ���������
  �������� - 7 ( �� ����� ����� ������ �� ������ ���� ).����������
  �� ����������� ��������� WRITE ���,��� �� ��������� ��
  ����������� ������� ( ��� ������� ��������� ��� ���������������
  ������� ASCII ).��� ������������� ������������ ���������.��������
  ������ ��������� �������� �� 10% ����� ����������� WRITE.
    ��������� �������� � ��������� ������ � EGA/VGA - ������������
  ����������.

 ���������� ���������:
   ������� �. �����.1996.������/������.���.:(095)391-9540.
   ���������� ��������� - ���������� ��������/������ �1-01.

 PROCEDURE ELABORATION:
   ALEXEY Y. BOKOW.1996.RUSSIA/MOSCOW.PHONE:(095)391-9540.
   MOSCOW INSTITUTE OF ENGINEERING PHYSICS/GROUP B1-01.
}

label OVER_X,OVER_Y,COORD_OK,DEC_LOOP,ADD_SI,
          SCROLL_LOOP,FILL_LOOP,WRITE_LOOP,THE_END;
  asm
{ ��������� ��������.}
        PUSH ES
        PUSH DI
        PUSH DS
        PUSH SI

{ �������� �������� ��������.}
        MOV  AX,BIOSDATASEG
        MOV  ES,AX
        MOV  DI,$0062
       { ������� � BH �������� �� ������ ES:[DI]( �������� �������� ).}
        MOV  BH,BYTE PTR ES:[DI]

{ �������� ������� ����������.}
        XOR  AX,AX
        MOV  AH,03
        INT  $10
       { INT 10h ����������:
          DL - ������� X - ����������,
          DH - ������� Y - ����������.}
       { ��������� ������� ���������� � �����.}
        PUSH DX

{ ��������� �������� ������������ ������ ��������.}

       { �������� ����� ��������.}
        MOV  AX,BIOSDATASEG
        MOV  ES,AX
        MOV  DI,$004A
        MOV  BX,WORD PTR ES:[DI] { ������� ����� �������� � AX.}
        MOV  AX,BX

       { �������� ������� Y - ���������� �� ����� ��������.}
        IMUL  DH

       { ���������� ���������� �������� � ������� X - �����������.}
        XOR  DH,DH
        ADD  AX,DX

       { �������� �� 2,��� ��� �� ���� ������ ��������� 2 ����� ����� ������.}
        SHL  AX,1

{ ���������� ����������� �������� � ��������� �������� ��������.}

       { �������� �������� �������� ��������.}
        MOV  DI,$004E
        MOV  DX,WORD PTR ES:[DI]  { ������� �������� �������� �������� � DX.}

        ADD  AX,DX

        POP  DX

{ ��������� ��������� �� ������ � DS:[SI].}
        MOV  CX,STRSEG
        MOV  DS,CX
        MOV  SI,STROFS

{ �������� �����.}

        XOR  CX,CX
        MOV  CL,BYTE PTR DS:[SI]
        { ������ ������ �� �������.}
        CMP  CL,0
        JE   THE_END
        INC  SI

{ ��������� ������ BIOS.}
        ADD  DL,CL


        { ��������� �������� � ����� ������ � �����.}
        PUSH DS
        PUSH SI
        PUSH CX
        PUSH AX

        { ���������� ������� X - ���������� � ������ ��������.}
        CMP  DL,BL

        JAE  OVER_X  { X - ���������� ��������� ����� ��������.}

        MOV  DI,$0084
        MOV  AL,BYTE PTR ES:[DI]   { ������� ����� ����� �� ������ � AL.}

        { ���������� ����� ����� � Y - �����������.}
        CMP  DH,AL

        JAE  OVER_Y { Y - ���������� ��������� ����� ����� �� ������.}

        JMP  COORD_OK { ��������� � �������,���������� ������.}

OVER_X:
        XOR  AX,AX
        { ������� DX �������� ������� ����������.}
        MOV  AL,DL
        { ������ � BL ��������� ����� ��������.}
        DIV  BL
        { ������� � DH - ����� ����� ���� ���������� Y - ����������;
                  B DL - �������.}
        MOV  DL,AH
        ADD  DH,AL

        { �������� ����� �����.}
        MOV  DI,$0084
        MOV  AL,BYTE PTR ES:[DI]   { ������� ����� ����� �� ������ � AL.}
{        DEC  AL}

        { ���������� Y - ���������� � ������ �����.}
        CMP  DH,AL
        JAE  OVER_Y { Y - ���������� ��������� ����� ����� �� ������.}
        JMP  COORD_OK { ���������� � �������,���������� ������.}

OVER_Y:
{ ��������� Y - ���������� �� ��� ��� ���� ��� �� ������ ���������� ��������.}
        XOR  CX,CX

   DEC_LOOP:
        INC  CX      { ���������� ��������� ������� � CX.}
        DEC  DH
        CMP  DH,AL   { ���������� ����� ����� � Y - �����������.}
        JAE  DEC_LOOP

        PUSH DX
        PUSH CX

{ ������������� ������ BIOS.}
        MOV  DI,$0062
        MOV  BH,BYTE PTR ES:[DI] { ������� � BH
                     �������� �� ES:[DI](�������� ��������).}
        XOR  AX,AX
        MOV  AH,02
        INT  $10

        POP  CX

{ ������ ��������� �� ����� �����,������ ����������� �������� �X.}

        { �������� �������� ��������.}
        MOV  DI,$004E
        MOV  DX,WORD PTR ES:[DI] { ��������� �������� �������� ��������
                                        � ����� �������� ������� � DX.}

        { �������� ����� ��������.}
        MOV  DI,$004A
        MOV  BX,WORD PTR ES:[DI] { ������� ����� �������� � BX.}
        SHL  BX,1 { �� ���� ������ ��������� 2 �����.}

        { ������� � SI �������� ������ ������ � ������� CX
          ������������ ������ ��������.}
        XOR  SI,SI

ADD_SI: ADD  SI,BX
        LOOP ADD_SI

        PUSH SI

        { �������� ������ ��������.}
        MOV  DI,$004C
        MOV  CX,WORD PTR ES:[DI] { ������� ������ ������� ������������� � CX.}
        { �������� �� ������� �������� ������ ������������� �����.}
        SUB  CX,SI
        { ������ � ������.}
        SHR  CX,1

        { ������������� ���������:
            ES:[DI] - ������ ��������,
            DS:[SI] - ������ ������ � ������� CX.}

        MOV  DI,$004E
        MOV  DI,WORD PTR ES:[DI] { C������� �������� ��������
                                    � ����� �������� ������� � DI.}
        ADD  SI,DI

        MOV  AX,VIDEOSEG
        MOV  ES,AX
        MOV  DS,AX

        { ��������� ����� �����.}
        CLD

SCROLL_LOOP:

        MOVSW
        LOOP SCROLL_LOOP

        { ��������� ������ ������ ��������� � ASCII - ����� 20h.}

        POP  CX
        PUSH CX

        MOV  AX,$0720

FILL_LOOP:
        MOV  WORD PTR ES:[DI],AX
        ADD  DI,2
        LOOP FILL_LOOP

        POP  CX
        POP  DX
        { �������� ��������,��������������� ������ ������� ����� ������ �
          ������� ����� ��������� ������,��� ��� ��� �������� �����������
          �� ����������� �� ���� ��� ��� ���������� ��������.}
        POP  AX
        { "���������" ��������� ������.}
        SUB  AX,CX
        PUSH AX

COORD_OK:
        POP  AX
        POP  CX
        POP  SI
        POP  DS

        PUSH AX

{ ������������� ���������� BIOS.}
        MOV  BX,BIOSDATASEG
        MOV  ES,BX
        MOV  DI,$0062
        MOV  BH,BYTE PTR ES:[DI] { ������� � BH
                    �������� �� ES:[DI](�������� ��������).}
        XOR  AX,AX

        MOV  AH,02
        INT  $10

        POP  AX

        MOV  BX,VIDEOSEG
        MOV  ES,BX
{ ������� � DI �������� (ES:[DI] -  ��������� �� ������ ������� ����� ������,
  � ������� ����� ������������ ������).}

        MOV  DI,AX

{ ����� � ������.}
        MOV  AL,7

        CLD

WRITE_LOOP:
        MOVSB           { DS:[SI]->ES:[DI]-������������ ���� ����.}
        MOV  ES:[DI],AL { ���������� � ES:[DI] �������.}
        INC  DI         { ����������� ��������.}
        LOOP WRITE_LOOP
THE_END:
{ ��������� ����������� �������� �������.}
        POP  SI
        POP  DS
        POP  DI
        POP  ES

end;



procedure NextScrPos;assembler;
{ ��ॢ���� ����� �� ��砫� ᫥���饩 ��ப�.}
asm
       PUSH ES
       PUSH DI

       MOV  AX,BIOSDATASEG
       MOV  ES,AX
       MOV  DI,$0062
       MOV  BH,BYTE PTR ES:[DI]{ BH=ES:[DI] - �������� ��������.}

       PUSH BX    { ��������� ��� ��� INT 10 ����� �������� BX.}

       XOR  AX,AX

       MOV  AH,03
       INT  $10

       POP  BX

       MOV  AH,02
       INC  DH   { Y_COORD:=Y_COORD+1.}
       MOV  DL,0
       INT  $10  { ���������� ������ BIOS � ������ ������� ��������� ������.}

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
  { �뢮� ⥪��� ����஥� �ணࠬ��.}
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

  { �뢮� ���ଠ樨 � 䠩���.}
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

   AltWriteLn(' Inform�tion about SECOND file.');
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
{ ��ॢ���� ����� �� ��砫� �।��饩 ��ப�.}
asm
       PUSH ES
       PUSH DI

       MOV  AX,BIOSDATASEG
       MOV  ES,AX
       MOV  DI,$0062
       MOV  BH,BYTE PTR ES:[DI]{ BH=ES:[DI] - �������� ��������.}

       PUSH BX    { ��������� ��� ��� INT 10 ����� �������� BX.}

       XOR  AX,AX

       MOV  AH,03
       INT  $10

       POP  BX

       MOV  AH,02
       DEC  DH   { Y_COORD:=Y_COORD-1.}
       MOV  DL,0
       INT  $10  { ���������� ������ BIOS � ������ ������� ��������� ������.}

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
  { ��楤�� ����� � 䠩� ����.}
  var
    Err:byte;
begin
   {$I-}
   Write(F,Value);
   Err:=IOResult;
   if Err<>0 then ErrorMsg(Err,fWriteErr+fUnknown);
end;



procedure WriteStr(var F:FileOfByte;WrStr:string);
  { ��楤�� ����� ��ப� � 䠩�.}
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
{ ��ॢ�� ��ப�.}
  Value:=CR;
  WriteByte(F,Value);

  Value:=LF;
  WriteByte(F,Value);
end;









function AddNul(fStr:String;tStrLen:byte):string;
  { �����稢��� ����� ��ப� �� �ॡ㥬�� �������� ᫥�� ᨬ��� ���.}
  var
    i:byte;
    hStr:string;
begin
   hStr:='';
   for i:=1 to tStrLen-Length(fStr) do hStr:='0'+hStr;
   AddNul:=hStr+fStr;
end;



function AddSpace(Count:byte;fStr:String):string;
  { �����稢��� ����� ��ப� �� �ॡ㥬�� �������� �ࠢ� �஡���.}
  var
    i:byte;
    hStr:string;
begin
   hStr:=fStr;
   for i:=1 to Count do hStr:=hStr+' ';
   AddSpace:=hStr;
end;



function AttrToStr(Attr:word):string;
  { �����頥� ��ப� � ��������� ��ਡ��(���ਬ�� 'System') ��� Attr=4.}
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
{ True �᫨ A=B.�᫨ A<>B,� � ��������� ��ப� ������� ���� /D-� �ந�室��
  ������ ࠧ�������� ���⮢ � 䠩�.}
  var
    Bool:boolean;
    ErrorC:byte;
begin
   Bool:=(A)=(B);
   with DiffFile do
   if (Not(Bool))and(WriteDiff) then
   { �⫨��騥�� ����� �����뢠���� � 䠩�( ���� /D ).}
          with DiffFile do WriteByte(Ptr,B);

   if Not(Bool) then Inc(DiffCount);

   CompareByte:=Bool;
end;



function CompareString(FirstStr,SecStr:string):boolean;
{ ����� �����뢠�� ���४��� ࠡ��� ������ ��楤���.}
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
   { �⫨��騥�� ��ப� �����뢠���� � 䠩�( ���� /D ). }
          with DiffFile do WriteStr(Ptr,SecStr);

   if Not(Bool) then Inc(DiffCount);

   CompareString:=Bool;
end;



function CompareStr_Asm(FirstSeg,FirstOfs,SecSeg,SecOfs:word):boolean;assembler;
{
  ������� ���������� 0 ���� ������ �������� ����������,���� 1 ���� ������
  ��������� �����������.
  ����� ���������� ������������ ������ ������ ���������.
}
label The_END,LEN_DIFF,CMP_LOOP;
asm
{ ��������� ��������.}
       PUSH ES
       PUSH DI
       PUSH DS
       PUSH SI

     { ES:[DI] - ��������� �� ������ ������;CL - ������� �����.}
     { DS:[SI] - ��������� �� ������ ������.}

       MOV  AX,FIRSTSEG
       MOV  ES,AX
       MOV  DI,FIRSTOFS

       MOV  AX,SECSEG
       MOV  DS,AX
       MOV  SI,SECOFS

       XOR  CX,CX
{ AL - ����� 0 ���� ������ ��������,���� 1 ���� ������ ���������.}
       MOV  AL,0

{ BL - ����� ������ ������;BH - ����� ������ ������.}
       MOV  BL,BYTE PTR ES:[DI]
       MOV  BH,BYTE PTR DS:[SI]

{ ������ ������� ��������� ����� ��������� ����������.}
       CMP  BL,BH
       JNE  THE_END

{ ����� ������� � CL.}
       MOV  CL,BL
       MOV  AX,$0001
       CMP  CL,AH
{ ������ ������� ����� ��������� �������.}
       JE   THE_END

       INC  SI
       INC  DI

CMP_LOOP:
{ ���� ������������� ��������� �����.}
       MOV  BL,BYTE PTR ES:[DI]
       MOV  BH,BYTE PTR DS:[SI]

       CMP  BL,BH
{ �������,���� ������� ����������� �����.}
       JNE  LEN_DIFF

       INC  SI
       INC  DI

       LOOP CMP_LOOP
{ ������ ��������� �����������.}
       MOV  AL,1
       JMP  THE_END

LEN_DIFF:
{ ������ ��������� ����������.}
       MOV  AL,0

THE_END:
{ ��������� �������� �� �����.}
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
  { �㭪�� ���� �� Sample Pr�gram Turbo Pascal 7.0 Help.}
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
  { �� Path �뤥��� �� ��᫥���� ᨬ����-���७�� 䠩��.}
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
  { �����頥� �������쭮�.}
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
  { �����頥� � ��ப� �६�.}
  var
     DT:DateTime;
     tStr:string;

          procedure LittleProc(Ch:string;V:byte);
          { Ch- ࠧ����⥫�.}
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