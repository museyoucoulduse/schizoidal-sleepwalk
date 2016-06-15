#property copyright   "2016, Szymon Blaszczynski"                                     // copyright
#property version     "1.00"                                                      // Version
#property description "This Indicator is based on Sleepwalking." // Description (line 1)
#property description "Have a good fun using it!"         // Description (line 2)
#property icon        "\\Images\\EA_icon.ico";                                    // A file with the product icon

#property indicator_chart_window
#property indicator_buffers 4
#property indicator_color1 Blue
#property indicator_color2 Red
#property indicator_color3 Red
#property indicator_color4 Blue

int num40 = 40;
double appliedprice = 0.0;
double num = 0.0;
double ind2[];
double ind3[];
double ind0[];
double ind1[];
int result;

int init() {
   SetIndexStyle(0, DRAW_NONE, STYLE_SOLID, 2);
   SetIndexStyle(1, DRAW_NONE, STYLE_SOLID, 2);
   SetIndexStyle(2, DRAW_LINE, STYLE_SOLID, 2);
   SetIndexStyle(3, DRAW_LINE, STYLE_SOLID, 2);
   SetIndexBuffer(0, ind0);
   SetIndexBuffer(1, ind1);
   SetIndexBuffer(2, ind2);
   SetIndexBuffer(3, ind3);
   result = num40 + MathFloor(MathSqrt(num40));
   SetIndexDrawBegin(0, result);
   SetIndexDrawBegin(1, result);
   SetIndexDrawBegin(2, result);
   SetIndexDrawBegin(3, result);
   IndicatorDigits(Digits + 1);
   IndicatorShortName("Schizoidal Sleepwalk");
   return (0);
}

int start() {
   int currentbarscounted = IndicatorCounted();
   if (currentbarscounted < 1) {
      for (int i = 1; i <= result; i++) ind2[Bars - i] = 0;
      for (int i2 = 1; i2 <= num40; i2++) ind3[Bars - i2] = 0;
   }
   if (currentbarscounted > 0) currentbarscounted--;
   int startpoint = Bars - currentbarscounted;
   for (int j = 0; j < startpoint; j++) ind3[j] = 2.0 * iMA(NULL, 0, MathFloor(num40 / 2), 0, MODE_LWMA, appliedprice, j) - iMA(NULL, 0, num40, 0, MODE_LWMA, appliedprice, j);
   for (int j2 = 0; j2 < startpoint; j2++) ind2[j2] = iMAOnArray(ind3, 0, MathFloor(MathSqrt(num40)), 0, MODE_LWMA, j2 + num);
   for (int k = j2; k >= 0; k--) {
      if (ind3[k] > ind2[k]) {
         ind0[k] = High[k];
         ind1[k] = Low[k];
      } else {
         if (ind3[k] < ind2[k]) {
            ind1[k] = High[k];
            ind0[k] = Low[k];
         }
      }
   }
   return (0);
}