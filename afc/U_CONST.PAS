unit u_const;
{  ����ᥩ �. �����.1996.�����/��᪢�.���.:(095)391-9540. }
{  Alexey Y. Bokow.1996.Russia/Moscow.Phone:(095)391-9540. }

{ ��� ����� ᮤ�ন� ����⠭��.}

interface

const
                      { ������������� ���C����.}
{ ��ப��� ����⠭��.}

{ ���ଠ�� � �ணࠬ��.}
  AuthorInfo=' Alexey Y. Bokow. 2000. Russia/Moscow. yb@aha.ru;arxive@netscape.net';
  InstituteInfo=' MEPhI rulez...';
  ProgramInfo=' The Advanced File Compare.';
  ProgramVerInfo=' AFC Version. 3.00. Full.  FreeWare. 24 March 2000';

{ ������� ᮮ�饭��.}
  fAccessErr=' File is not accessible : ';
  fOpenErr=' File open error : ';
  fReadErr=' File read error : ';
  fWriteErr=' File write error : ';
  fUnknown=' Unknown ';

  cmNameExc='  After swith of command line is excepted file name';

{ ���ᨢ ᮤ�ঠ騩 ��७�� 䠩��� �������� ⥪�⮢묨.}
{ ����� ���ᨢ� ����� 1.}
  Max_TXT_EXT=9;

  TXT_EXT_C:array[0..Max_TXT_EXT] of
       string=('txt','doc','pas','c','asm','bat','log','bak','lst','map');

{ �ணࠬ�� �ᯮ���� �� ���c⠭�� ��� ��אַ�� ���饭�� � �����.}
  BIOSDataSeg=$0040;
  VIDEOSEG=$B800;

{ ����� ���뢠��� �� ������ Ctrl-Break.}
  CTRLBreak_Int_No=$23;

{ ������� �������� ��� �ᯮ��㥬� ASCII ����.}

{ ������ ���⪨.}
  CR=$0D;

{ ��ॢ�� ��ப�.}
  LF=$0A;

  Space=$20;

{ ������ �࠭�� ��᫥����⥫쭮�� ⥪�⮢�� ᨬ����� � ���� ASCII.}
  MinASCII=$20;

{ ������ �࠭�� ��᫥����⥫쭮�� ⥪�⮢�� ᨬ����� � ���� ASCII.}
  MaxASCII=$EF;


{ MaxBinLen - �᫮ ࠧ�冷� �� �뢮�� ������� �ᥫ.}
{ MaxDecLen � MaxHexLen - �᫮ ࠧ�冷� �� �뢮�� ��������
  � ��⭠������� �ᥫ.}
    MaxBinLen=7;
    MaxDecLen=3;
    MaxHexLen=2;


{ ����� �뢮����� ��ப�.}
       StrLen=80;

{ ��᫮ ࠧ�冷� �� �뢮�� ᬥ饭�� �� ��砫� 䠩��.}
       Size_Len=8;

{ ��᫮ �஡���� ����� ����묨.}
       Ofs_Dec=3;
       Dec_Hex=3;
       Hex_ASCII=4;
       ASCII_Bin=5;
       Bin_Next=5;
       ScaleStr=' Offset     Dec   Hex    ASCII Bin        Dec   Hex    ASCII Bin ';
       HalfScaleStr=' Offset     Dec   Hex    ASCII Bin         ';

{
  ���ᨬ��쭮� �᫮ ࠧ�������� ��ப.�᫨ �᫮ ࠧ�������� ��ப
  �� �ॢ�蠥� �� ���祭�� � ���ᨢ� ��ப ������� ������묨.
}
  Max_Diff=2;

  Sep_1='.';
  Sep_2=';';

{ �� 㬮�砭�� ���ଠ�� �㤥� �㡫�஢����� � 䠩�� � �⨬ ������.}
  Def_report='REPORT.AFC';

type
               { �������� �����.}

{ ��� �뢮��.}
   OutType=(ToScreen,ToFile,ToScr_and_File);

{ ��� �ࠢ�����.
  BinaryCmp - ०�� ����筮�� �ࠢ�����.
  TextCmp - ०�� ⥪�⮢��� �ࠢ�����.
}
   CompareType=(BinaryCmp,TextCmp);

{ ������ �ࠢ�����.

  Simple - �ࠢ�������� �������� 䠩�� ����騥 ���������� ᬥ饭�� ��
           ��砫� 䠩��.

  Smart - � ०��� ⥪�⮢��� �ࠢ����� 䠩�� �ࠢ�������� �� �।�������,
  �.�.  �� ��ࢮ�� ᨬ���� '.'(����� �।������� �� ������ �ॢ���� 255).
        - � ०��� ⥪�⮢��� �ࠢ����� ����� �宦����� ��ࢮ�� 䠩�� ��
  ��ன.

  Clever - ���襭�� ������ Smart.
}
   CmpModelType=(Simple,Smart,Clever);

{ �ᯮ����⥫�� ⨯.}
   FileOfByte=File of Byte;

   AddrType=record
               Segment:word;
               Offset:word;
             end;

{ ��� 䠩�-ᮤ�ন� ���� � ����室���� ���ଠ樥�.}
   FileType=record

              { ���� � 䠩��.}
              Path:string;

              { ������ 䠩��.}
              Size:LongInt;

              { ���ਡ�� 䠩��.}
              Attr:word;

              { ���� - ��६����� ⨯� 䠩�.}
              Ptr:FileOfByte;

              { ���� �ਭ����� TRUE �᫨ 䠩� � �����騩 ������ �����.}
              Open:boolean;
           end;

var
                 { �������� ����������.}

{ ��� �ࠢ����� - ��⠭���������� � ����ᨬ��� �� ��ࠬ��஢ ��������� ��ப�.}
   Cmp:CompareType;

{ ������ �ࠢ����� - ��⠢�������� � ����ᨬ��� �� ��ࠬ��஢ ��������� ��ப�.}
   CmpModel:CmpModelType;

{ ������� ��६���� ������騥 �� ��ࠬ��஢ � ��������� ��ப�.}
   MinimOutput , CaseIgnore , SpaceIgnore , WriteDiff ,
   OutInFile , CleanIgnore :boolean;

{ ��ࢮ� � ��ன 䠩�� ᮮ⢥��⢥���.}
   FirstFile,SecondFile:FileType;


{ �᫨ �뢮� �ந�������� � 䠩�,� � OutFile - 䠩� �뢮��.}
   OutFile:FileType;

{ � ��� 䠩� �ந�������� ������ ࠧ��稩 ����� 䠩����.�� "�⠫��"
  ������ ���� 䠩�.}
   DiffFile:FileType;

{ �뢮� �ந�������� � ᮮ⢥��⢨�
  � ���祭��� WhereWrite (�.���ᠭ�� ⨯� OutType).}
   WhereWrite:OutType;

{ ���稪 ࠧ��稩.}
   DiffCount:LongInt;

{ �ᯮ����⥫쭠� ��६����� - �ᯮ������ �� �⫠���.}
   NowDebug:boolean;

   Ctrl_Break_Handler:pointer;

    quiet_mode:boolean;

implementation

end.
