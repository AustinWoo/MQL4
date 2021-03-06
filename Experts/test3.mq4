//+------------------------------------------------------------------+
//|                                                        test3.mq4 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+


//交易过程控制信息
datetime dofore_flag;                     //最后一次执行时间标示
string txt;

#include <WooInclude/Check_TimeFlag.mqh>     //函数 检查当前M5时间段是否执行过，是就返回true


int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   int file_handle=FileOpen("ea_log_price.txt",FILE_READ|FILE_WRITE|FILE_TXT|FILE_ANSI);
   FileWriteString(file_handle,txt);
   FileClose(file_handle);
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---


//+------------------------------第一步，根据时间间隔执行 ------------------------------------+

   if(Check_TimeFlag(dofore_flag))          //先检查算法预测的时间间隔，如果满足则执行预测
     { 
         txt+="time->"+iTime(Symbol(),PERIOD_H1,0)+",";
         
         txt+="p_open->"+DoubleToString(iOpen(Symbol(),PERIOD_H1,1))+",";
         txt+="p_high->"+DoubleToString(iHigh(Symbol(),PERIOD_H1,1))+",";
         txt+="p_low->"+DoubleToString(iLow(Symbol(),PERIOD_H1,1))+",";
         txt+="p_close->"+DoubleToString(iClose(Symbol(),PERIOD_H1,1))+"\n";
         
     }

   
  }
//+------------------------------------------------------------------+
