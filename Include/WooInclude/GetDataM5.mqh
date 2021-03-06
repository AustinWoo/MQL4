//+------------------------------------------------------------------+
//|                                                    GetDataM5.mqh |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
// #define MacrosHello   "Hello, world!"
// #define MacrosYear    2010
//+------------------------------------------------------------------+
//| DLL imports                                                      |
//+------------------------------------------------------------------+
// #import "user32.dll"
//   int      SendMessageA(int hWnd,int Msg,int wParam,int lParam);
// #import "my_expert.dll"
//   int      ExpertRecalculate(int wParam,int lParam);
// #import
//+------------------------------------------------------------------+
//| EX5 imports                                                      |
//+------------------------------------------------------------------+
// #import "stdlib.ex5"
//   string ErrorDescription(int error_code);
// #import
//+------------------------------------------------------------------+




string GetDataM5()
{
   //返回字符串
   string rn_str;
   
   //取上一个M5的特征值
   datetime dt = iTime(Symbol(),PERIOD_M5,1);
   //rn_str+="dt:";
   //rn_str+=TimeToString(dt);
   //rn_str+=",";
   
   int pricedateweekday;
   pricedateweekday=TimeDayOfWeek(dt)+1;
   rn_str+="pricedateweekday_m5:";
   rn_str+=IntegerToString(pricedateweekday);
   rn_str+=",";
   //rn_str+="\n";
    
   int pricetimehour;
   pricetimehour=TimeHour(dt);
   rn_str+="pricetimehour_m5:";
   rn_str+=IntegerToString(pricetimehour);
   rn_str+=",";
   //rn_str+="\n";
   
   int pricetimeminute;
   pricetimeminute=TimeMinute(dt);
   rn_str+="pricetimeminute_m5:";
   rn_str+=IntegerToString(pricetimeminute);
   rn_str+=",";
   //rn_str+="\n";
   
   double closebid=iClose(Symbol(),PERIOD_M5,1);
   double closebid_h=iClose(Symbol(),PERIOD_H1,1);
   rn_str+="closebid_m5:";
   rn_str+=DoubleToString(closebid);
   rn_str+=",";
   //rn_str+="\n";
   
   int trend;
   if(iClose(Symbol(),PERIOD_M5,1)>iClose(Symbol(),PERIOD_M5,2))
   {
      trend=1;
   }
   else if (iClose(Symbol(),PERIOD_M5,1)==iClose(Symbol(),PERIOD_M5,2))
   {
      trend=0;
   }
   else
   {
      trend=-1;
   };
   rn_str+="trend_m5:";
   rn_str+=IntegerToString(trend);
   rn_str+=",";
   //rn_str+="\n";
   
   
   //gapbid_pre_m5_      系列特征值
   for(int i=1;i<=12;i++)
      {
         rn_str+="gapbid_pre_m5_"+IntegerToString(i)+":"+DoubleToString(closebid-iClose(Symbol(),PERIOD_M5,i+1));
         rn_str+=",";
      //   rn_str+="\n";
      }
   //trend_pre_m5_       系列特征值
   for(int i=1;i<=12;i++)
     {
      int trend_pre_m5_i;
      if(iClose(Symbol(),PERIOD_M5,i+1)> iClose(Symbol(),PERIOD_M5,i+2))
        {
         trend_pre_m5_i=1;
        }
        else if(iClose(Symbol(),PERIOD_M5,i+1)==iClose(Symbol(),PERIOD_M5,i+2))
          {
           trend_pre_m5_i=0;
          }
        else
          {
           trend_pre_m5_i=-1;
          };
         rn_str+="trend_pre_m5_"+IntegerToString(i)+":"+IntegerToString(trend_pre_m5_i);
         rn_str+=",";
       //  rn_str+="\n";
     }
   //trend_gap_pre_m5_   系列特征值
   for(int i=1;i<=12;i++)
     {
      double trend_gap_pre_m5_i = iClose(Symbol(),PERIOD_M5,i+1)-iClose(Symbol(),PERIOD_M5,i+2);
      rn_str+="trend_gap_pre_m5_"+IntegerToString(i)+":"+DoubleToString(trend_gap_pre_m5_i);
      rn_str+=",";
      //rn_str+="\n";
     }
   //openclose_m5_       系列特征值
   for(int i=1;i<=12;i++)
     {
      double openclose_m5_i = iOpen(Symbol(),PERIOD_M5,i+1)-iClose(Symbol(),PERIOD_M5,i+1);
      rn_str+="openclose_m5_"+IntegerToString(i)+":"+DoubleToString(openclose_m5_i);
      rn_str+=",";
      //rn_str+="\n";
     }
   //highlow_m5_         系列特征值
   for(int i=1;i<=12;i++)
     {
      double highlow_m5_i = iHigh(Symbol(),PERIOD_M5,i+1)-iLow(Symbol(),PERIOD_M5,i+1);
      rn_str+="highlow_m5_"+IntegerToString(i)+":"+DoubleToString(highlow_m5_i);
      rn_str+=",";
      //rn_str+="\n";
     }
     
   //upbar_m5_           系列特征值
   for(int i=1;i<=12;i++)
     {
      double upbar_m5_i;
      if(iOpen(Symbol(),PERIOD_M5,i+1)>=iClose(Symbol(),PERIOD_M5,i+1) )
        {
         upbar_m5_i=iHigh(Symbol(),PERIOD_M5,i+1)-iOpen(Symbol(),PERIOD_M5,i+1);
        }
        else
          {
           upbar_m5_i=iHigh(Symbol(),PERIOD_M5,i+1)-iClose(Symbol(),PERIOD_M5,i+1);
          };
          
      rn_str+="upbar_m5_"+IntegerToString(i)+":"+DoubleToString(upbar_m5_i);
      rn_str+=",";
      //rn_str+="\n";   
     }
   //downbar_m5_         系列特征值
   for(int i=1;i<=12;i++)
     {
      double downbar_m5_i;
      if(iOpen(Symbol(),PERIOD_M5,i+1)>=iClose(Symbol(),PERIOD_M5,i+1)  )
        {
         downbar_m5_i=iClose(Symbol(),PERIOD_M5,i+1)-iLow(Symbol(),PERIOD_M5,i+1);
        }
        else
          {
           downbar_m5_i=iOpen(Symbol(),PERIOD_M5,i+1)-iLow(Symbol(),PERIOD_M5,i+1);
          };
      rn_str+="downbar_m5_"+IntegerToString(i)+":"+DoubleToString(downbar_m5_i);
      rn_str+=",";
      //rn_str+="\n"; 
     }
   //gapbid_pre_m5_h      系列特征值
   for(int i=1;i<=14;i++)
     {
         rn_str+="gapbid_pre_m5_h"+IntegerToString(i)+":"+DoubleToString(closebid_h-iClose(Symbol(),PERIOD_H1,i+1));
         rn_str+=",";
         //rn_str+="\n";
     }
   //trend_pre_m5_h       系列特征值
   for(int i=1;i<=14;i++)
     {
      int trend_pre_m5_hi;
      if(iClose(Symbol(),PERIOD_H1,i+1)> iClose(Symbol(),PERIOD_H1,i+2))
        {
         trend_pre_m5_hi=1;
        }
        else if(iClose(Symbol(),PERIOD_H1,i+1)==iClose(Symbol(),PERIOD_H1,i+2))
          {
           trend_pre_m5_hi=0;
          }
        else
          {
           trend_pre_m5_hi=-1;
          };
         rn_str+="trend_pre_m5_h"+IntegerToString(i)+":"+IntegerToString(trend_pre_m5_hi);
         rn_str+=",";
         //rn_str+="\n";
     }
   //trend_gap_pre_m5_h   系列特征值
   for(int i=1;i<=14;i++)
     {
      double trend_gap_pre_m5_hi = iClose(Symbol(),PERIOD_H1,i+1)-iClose(Symbol(),PERIOD_H1,i+2);
      rn_str+="trend_gap_pre_m5_h"+IntegerToString(i)+":"+DoubleToString(trend_gap_pre_m5_hi);
      rn_str+=",";
      //rn_str+="\n";
     }
   //openclose_m5_h       系列特征值
   for(int i=1;i<=14;i++)
     {
      double openclose_m5_hi = iOpen(Symbol(),PERIOD_H1,i+1)-iClose(Symbol(),PERIOD_H1,i+1);
      rn_str+="openclose_m5_h"+IntegerToString(i)+":"+DoubleToString(openclose_m5_hi);
      rn_str+=",";
      //rn_str+="\n";
     }
   //highlow_m5_h         系列特征值
   for(int i=1;i<=14;i++)
     {
      double highlow_m5_hi = iHigh(Symbol(),PERIOD_H1,i+1)-iLow(Symbol(),PERIOD_H1,i+1);
      rn_str+="highlow_m5_h"+IntegerToString(i)+":"+DoubleToString(highlow_m5_hi);
      rn_str+=",";
      //rn_str+="\n";
     }
   //upbar_m5_h           系列特征值
   for(int i=1;i<=14;i++)
     {
      double upbar_m5_hi;
      if(iOpen(Symbol(),PERIOD_H1,i+1)>=iClose(Symbol(),PERIOD_H1,i+1) )
        {
         upbar_m5_hi=iHigh(Symbol(),PERIOD_H1,i+1)-iOpen(Symbol(),PERIOD_H1,i+1);
        }
        else
          {
           upbar_m5_hi=iHigh(Symbol(),PERIOD_H1,i+1)-iClose(Symbol(),PERIOD_H1,i+1);
          };
          
      rn_str+="upbar_m5_h"+IntegerToString(i)+":"+DoubleToString(upbar_m5_hi);
      rn_str+=",";
      //rn_str+="\n"; 
     }
   //downbar_m5_h         系列特征值
   for(int i=1;i<=14;i++)
     {
      double downbar_m5_hi;
      if(iOpen(Symbol(),PERIOD_H1,i+1)>=iClose(Symbol(),PERIOD_H1,i+1)  )
        {
         downbar_m5_hi=iClose(Symbol(),PERIOD_H1,i+1)-iLow(Symbol(),PERIOD_H1,i+1);
        }
        else
          {
           downbar_m5_hi=iOpen(Symbol(),PERIOD_H1,i+1)-iLow(Symbol(),PERIOD_H1,i+1);
          };
      rn_str+="downbar_m5_h"+IntegerToString(i)+":"+DoubleToString(downbar_m5_hi);
      rn_str+=",";
      //rn_str+="\n"; 
     }
   
   
   
   return rn_str;
};