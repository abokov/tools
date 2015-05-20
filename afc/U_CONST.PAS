unit u_const;
{  Алексей Ю. Боков.1996.Россия/Москва.Тел.:(095)391-9540. }
{  Alexey Y. Bokow.1996.Russia/Moscow.Phone:(095)391-9540. }

{ Этот модуль содержит константы.}

interface

const
                      { ИНИЦИАЛИЗАЦИЯ КОНCТАНТ.}
{ Строковые константы.}

{ Информация о программе.}
  AuthorInfo=' Alexey Y. Bokow. 2000. Russia/Moscow. yb@aha.ru;arxive@netscape.net';
  InstituteInfo=' MEPhI rulez...';
  ProgramInfo=' The Advanced File Compare.';
  ProgramVerInfo=' AFC Version. 3.00. Full.  FreeWare. 24 March 2000';

{ Некоторые сообщения.}
  fAccessErr=' File is not accessible : ';
  fOpenErr=' File open error : ';
  fReadErr=' File read error : ';
  fWriteErr=' File write error : ';
  fUnknown=' Unknown ';

  cmNameExc='  After swith of command line is excepted file name';

{ Массив содержащий раширения файлов считающихся текстовыми.}
{ Длина массива минус 1.}
  Max_TXT_EXT=9;

  TXT_EXT_C:array[0..Max_TXT_EXT] of
       string=('txt','doc','pas','c','asm','bat','log','bak','lst','map');

{ Программа использует эти конcтанты для прямого обращения к памяти.}
  BIOSDataSeg=$0040;
  VIDEOSEG=$B800;

{ Номер прерывания по нажатию Ctrl-Break.}
  CTRLBreak_Int_No=$23;

{ Некоторые наиболее часто используемые ASCII коды.}

{ Возврат каретки.}
  CR=$0D;

{ Перевод строки.}
  LF=$0A;

  Space=$20;

{ Нижняя граница последовательности текстовых символов в коде ASCII.}
  MinASCII=$20;

{ Верхняя граница последовательности текстовых символов в коде ASCII.}
  MaxASCII=$EF;


{ MaxBinLen - число разрядов при выводе двоичных чисел.}
{ MaxDecLen и MaxHexLen - число разрядов при выводе десятичных
  и шестнадцатиричных чисел.}
    MaxBinLen=7;
    MaxDecLen=3;
    MaxHexLen=2;


{ Длина выводимой строки.}
       StrLen=80;

{ Число разрядов при выводе смещения от начала файла.}
       Size_Len=8;

{ Число пробелов между данными.}
       Ofs_Dec=3;
       Dec_Hex=3;
       Hex_ASCII=4;
       ASCII_Bin=5;
       Bin_Next=5;
       ScaleStr=' Offset     Dec   Hex    ASCII Bin        Dec   Hex    ASCII Bin ';
       HalfScaleStr=' Offset     Dec   Hex    ASCII Bin         ';

{
  Максимальное число различающихся строк.Если число различающихся строк
  не превышает это значение то массивы строк считаются идентичными.
}
  Max_Diff=2;

  Sep_1='.';
  Sep_2=';';

{ По умолчанию информация будет дублироваться в файле с этим именем.}
  Def_report='REPORT.AFC';

type
               { ОПИСАНИЯ ТИПОВ.}

{ Тип вывода.}
   OutType=(ToScreen,ToFile,ToScr_and_File);

{ Тип сравнения.
  BinaryCmp - режим двоичного сравнения.
  TextCmp - режим текстового сравнения.
}
   CompareType=(BinaryCmp,TextCmp);

{ Модель сравнения.

  Simple - сравниваются элементы файла имеющие одинаковое смещение от
           начала файла.

  Smart - в режиме текстового сравнения файлы сравниваются по предложениям,
  т.е.  до первого символа '.'(длина предложения не должна превышать 255).
        - в режиме текстового сравнения ищется вхождение первого файла во
  второй.

  Clever - улучшенный аналог Smart.
}
   CmpModelType=(Simple,Smart,Clever);

{ Вспомогательный тип.}
   FileOfByte=File of Byte;

   AddrType=record
               Segment:word;
               Offset:word;
             end;

{ Тип файл-содержит поля с необходимой информацией.}
   FileType=record

              { Путь к файлу.}
              Path:string;

              { Размер файла.}
              Size:LongInt;

              { Аттрибут файла.}
              Attr:word;

              { Поле - переменная типа файл.}
              Ptr:FileOfByte;

              { Поле принимает TRUE если файл в настоящий момент открыт.}
              Open:boolean;
           end;

var
                 { ОПИСАНИЯ ПЕРЕМЕННЫХ.}

{ Тип сравнения - устанавливается в зависимости от параметров командной строки.}
   Cmp:CompareType;

{ Модель сравнения - уставливается в зависимости от параметров командной строки.}
   CmpModel:CmpModelType;

{ Некоторые переменные зависящие от параметров в командной строке.}
   MinimOutput , CaseIgnore , SpaceIgnore , WriteDiff ,
   OutInFile , CleanIgnore :boolean;

{ Первой и второй файлы соответственно.}
   FirstFile,SecondFile:FileType;


{ Если вывод производится в файл,то в OutFile - файл вывода.}
   OutFile:FileType;

{ В этот файл производится запись различий между файлами.За "эталон"
  берется первый файл.}
   DiffFile:FileType;

{ Вывод производится в соответствии
  со значением WhereWrite (см.описание типа OutType).}
   WhereWrite:OutType;

{ Счетчик различий.}
   DiffCount:LongInt;

{ Вспомогательная переменная - используется при отладке.}
   NowDebug:boolean;

   Ctrl_Break_Handler:pointer;

    quiet_mode:boolean;

implementation

end.
