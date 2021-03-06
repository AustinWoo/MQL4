//+------------------------------------------------------------------+
//|                                                     Print_H1.mq4 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

string log_txt;
string hour_flag;
datetime month_flag;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

   log_txt="";
   month_flag="";
 
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---

   
   string check_hour = iTime(Symbol(),PERIOD_D1,1);

   datetime check_month = iTime(Symbol(),PERIOD_MN1,1);
   
   string y = IntegerToString(TimeYear(check_month));
   string m = IntegerToString(TimeMonth(check_month));
   //string d = IntegerToString(TimeDay(check_day));
   //string h = IntegerToString(TimeHour(check_day));
   //string m = IntegerToString(TimeMinute(check_day));


//+------------------------------------------------------------------+
//| 月循环，写文件                                                   |
//+------------------------------------------------------------------+
if(check_month==month_flag)
  {
   
  }else
     {
     
     if(month_flag!="")
       {
        string file_name =Symbol()+"_D1_"+y+"_"+m+".txt";
     
         int file_handle=FileOpen(file_name,FILE_READ|FILE_WRITE|FILE_TXT|FILE_ANSI);
         FileWriteString(file_handle,log_txt);
         FileClose(file_handle);
         
         Print("write -> "+ file_name);
       }
      
     }
   




//+------------------------------------------------------------------+
//| 月循环，添加列名                                                 |
//+------------------------------------------------------------------+
if(check_month==month_flag)
  {
   
  }else
     {
      log_txt = "currency,datetime,open,high,low,close,vol,macd_main,macd_signal,rsi,kdj_main,kdj_signal,adx_main,adx_plusdi,adx_minusdi,ma_18,ma_36,ma_56,mfi,sar,cci,wpr,boll_main,boll_upper,boll_lower";
      log_txt +="\n";
      
      month_flag=check_month;
     };

//+------------------------------------------------------------------+
//| 小时循环，添加特征值                                             |
//+------------------------------------------------------------------+
if(check_hour==hour_flag)
  {
   
  }else
     {
      //基本属性
      log_txt +=Symbol()+",";
      log_txt +=iTime(Symbol(),PERIOD_D1,1)+",";
      
      //价格特征
      log_txt +=iOpen(Symbol(),PERIOD_D1,1)+",";
      log_txt +=iHigh(Symbol(),PERIOD_D1,1)+",";
      log_txt +=iLow(Symbol(),PERIOD_D1,1)+",";
      log_txt +=iClose(Symbol(),PERIOD_D1,1)+",";
      log_txt +=iVolume(Symbol(),PERIOD_D1,1)+",";
      //MACD
      log_txt +=iMACD(Symbol(),PERIOD_D1,12,26,9,PRICE_CLOSE,MODE_MAIN,1)+",";
      log_txt +=iMACD(Symbol(),PERIOD_D1,12,26,9,PRICE_CLOSE,MODE_SIGNAL,1)+",";
      
      //RSI
      log_txt +=iRSI(Symbol(),PERIOD_D1,14,PRICE_CLOSE,1)+",";
      //KDJ
      log_txt +=iStochastic(Symbol(),PERIOD_D1,9,3,3,MODE_SMA,0,MODE_MAIN,1)+",";
      log_txt +=iStochastic(Symbol(),PERIOD_D1,9,3,3,MODE_SMA,0,MODE_SIGNAL,1)+",";
      //DMI/ADX
      log_txt +=iADX(Symbol(),PERIOD_D1,14,PRICE_CLOSE,MODE_MAIN,1)+",";
      log_txt +=iADX(Symbol(),PERIOD_D1,14,PRICE_CLOSE,MODE_PLUSDI,1)+",";
      log_txt +=iADX(Symbol(),PERIOD_D1,14,PRICE_CLOSE,MODE_MINUSDI,1)+",";
      //MA
      log_txt +=iMA(Symbol(),PERIOD_D1,18,0,MODE_SMMA,PRICE_CLOSE,1)+",";
      log_txt +=iMA(Symbol(),PERIOD_D1,36,0,MODE_SMMA,PRICE_CLOSE,1)+",";
      log_txt +=iMA(Symbol(),PERIOD_D1,56,0,MODE_SMMA,PRICE_CLOSE,1)+",";
      //MFI
      log_txt +=iMFI(Symbol(),PERIOD_D1,14,1)+",";
      //SAR
      log_txt +=iSAR(Symbol(),PERIOD_D1,0.02,0.2,1)+",";
      //CCI
      log_txt +=iCCI(Symbol(),PERIOD_D1,12,PRICE_CLOSE,1)+",";
      //WPR
      log_txt +=iWPR(Symbol(),PERIOD_D1,14,1)+",";
      
      //boll
      log_txt += iBands(Symbol(),PERIOD_D1,20,2,0,PRICE_CLOSE,MODE_MAIN,1)+",";
      log_txt += iBands(Symbol(),PERIOD_D1,20,2,0,PRICE_CLOSE,MODE_UPPER,1)+",";
      log_txt += iBands(Symbol(),PERIOD_D1,20,2,0,PRICE_CLOSE,MODE_LOWER,1);
      
      
      //行分隔符
      log_txt +="\n";
      
      //Print("write -> "+check_hour);
      
      hour_flag=check_hour;
     }



//跳过循环
if(check_hour==hour_flag)
  {
   return;
  }
   
  }
//+------------------------------------------------------------------+
