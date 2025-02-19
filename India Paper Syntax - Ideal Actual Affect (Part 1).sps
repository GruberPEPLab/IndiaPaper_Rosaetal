* Encoding: UTF-8.


****************************************************************
    *PARTICIPANT ELIGIBILITY VARIABLE
****************************************************************
   

***If only include participants who have INCLUDE marked for all 4 primary scales
N = 221 total out of 251 collected

USE ALL.
COMPUTE filter_$=(HPS_Exclude = 0 & BDISF_Exclude = 0 & ASRM_Exclude = 0 & AVI_Exclude = 0).
VARIABLE LABELS filter_$ 'HPS_Exclude = 0 & BDISF_Exclude = 0 & ASRM_Exclude = 0 & AVI_Exclude = '+
    '0 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.


****************************************************************
***PRELIMINARY ANALYSES
****************************************************************
   
*********CHECKING SKEWNESS AND KURTOSIS
    
DESCRIPTIVES VARIABLES=hps48_tot ASRM_tot BDISF_tot HighArousalPos_ideal HighArousalPos_actual 
    LowArousalPos_ideal LowArousalPos_actual HighArousalNeg_ideal HighArousalNeg_actual 
    LowArousalNeg_ideal LowArousalNeg_actual
  /STATISTICS=MEAN STDDEV MIN MAX KURTOSIS SKEWNESS.


*********DEMOGRAPHIC VARIABLES AND HPS
    
STATS CORRELATIONS VARIABLES=hps48_tot
/WITH VARIABLES=Age
/OPTIONS CONFLEVEL=95 METHOD=FISHER
/MISSING EXCLUDE=YES PAIRWISE=YES.

CORRELATIONS
  /VARIABLES=hps48_tot Age
  /PRINT=TWOTAIL NOSIG FULL
  /MISSING=PAIRWISE.

CORRELATIONS
  /VARIABLES=hps48_tot Ladder
  /PRINT=TWOTAIL NOSIG FULL
  /MISSING=PAIRWISE.

ONEWAY hps48_tot BY Gender_Binary
  /STATISTICS DESCRIPTIVES 
  /MISSING ANALYSIS
  /CRITERIA=CILEVEL(0.95).


*********OUTLIERS

DESCRIPTIVES VARIABLES=Age Ladder hps48_tot ASRM_tot BDISF_tot HighArousalPos_ideal HighArousalPos_actual 
    LowArousalPos_ideal LowArousalPos_actual HighArousalNeg_ideal HighArousalNeg_actual LowArousalNeg_ideal LowArousalNeg_actual 
    HighArousal_ideal HighArousal_actual
  /SAVE
  /STATISTICS=MEAN STDDEV MIN MAX.





****************************************************************
***REGRESSION ANALYSES
****************************************************************
   

*********RESEARCH QUESTION 1
    

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS CI(95) R ANOVA CHANGE
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT hps48_tot
  /METHOD=ENTER ASRM_tot BDISF_tot
  /METHOD=ENTER HighArousalPos_actual HighArousalNeg_actual LowArousalPos_actual 
    LowArousalNeg_actual.


*********RESEARCH QUESTION 2
    
REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS CI(95) R ANOVA CHANGE
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT hps48_tot
  /METHOD=ENTER ASRM_tot BDISF_tot
  /METHOD=ENTER HighArousalPos_actual LowArousalPos_actual HighArousalNeg_actual 
    LowArousalNeg_actual
  /METHOD=ENTER HighArousalPos_ideal LowArousalPos_ideal HighArousalNeg_ideal LowArousalNeg_ideal.


****************************************************************
***SCALE RELIABILITY ANALYSES
****************************************************************

***HPS
    
RELIABILITY
  /VARIABLES=HPS3 HPS4 HPS5 HPS7 HPS8 HPS9 HPS10 HPS11 HPS12 HPS13 HPS15 HPS18 HPS19 HPS20 HPS22 
    HPS23 HPS26 HPS28 HPS29 HPS30 HPS32 HPS33 HPS34 HPS35 HPS36 HPS37 HPS38 HPS39 HPS40 HPS41 HPS42 
    HPS43 HPS44 HPS45 HPS46 hps1r hps2r hps6r hps14r hps16r hps17r hps21r hps24r hps25r hps27r hps31r 
    hps47r hps48r
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA.


**Internal consistencies

*Actual

RELIABILITY
  /VARIABLES=avi_actual.enthusiastic,avi_actual.excited,avi_actual.elated
  /SCALE('HighArousalPos_actual') ALL
  /MODEL=ALPHA.
RELIABILITY
  /VARIABLES=avi_actual.calm,avi_actual.peaceful,avi_actual.relaxed
  /SCALE('LowArousalPos_actual') ALL
  /MODEL=ALPHA.
RELIABILITY
  /VARIABLES=avi_actual.fearful,avi_actual.hostile,avi_actual.nervous
  /SCALE('HighArousalNeg_actual') ALL
  /MODEL=ALPHA.
RELIABILITY
  /VARIABLES=avi_actual.dull,avi_actual.sleepy,avi_actual.sluggish
  /SCALE('LowArousalNeg_actual') ALL
  /MODEL=ALPHA.

*Ideal

RELIABILITY
  /VARIABLES=avi_ideal.enthusiastic,avi_ideal.excited,avi_ideal.elated
  /SCALE('HighArousalPos_ideal') ALL
  /MODEL=ALPHA.
RELIABILITY
  /VARIABLES=avi_ideal.calm,avi_ideal.peaceful,avi_ideal.relaxed
  /SCALE('LowArousalPos_ideal') ALL
  /MODEL=ALPHA.
RELIABILITY
  /VARIABLES=avi_ideal.fearful,avi_ideal.hostile,avi_ideal.nervous
  /SCALE('HighArousalNeg_ideal') ALL
  /MODEL=ALPHA.
RELIABILITY
  /VARIABLES=avi_ideal.dull,avi_ideal.sleepy,avi_ideal.sluggish
  /SCALE('LowArousalNeg_ideal') ALL
  /MODEL=ALPHA.


***ASRM
    
RELIABILITY
  /VARIABLES=ASRM1 ASRM2 ASRM3 ASRM4 ASRM5
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA.

***BDI-SF
    
RELIABILITY
  /VARIABLES=BDISF1 BDISF2 BDISF3 BDISF4 BDISF5 BDISF6 BDISF7 BDISF8 BDISF9 BDISF10 BDISF11 BDISF12 
    BDISF13
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA.




****************************************************************
***EXPLORATORY ANALYSES
****************************************************************
   
CORRELATIONS
  /VARIABLES=hps48_tot WITH HighArousalPos_ideal HighArousalPos_actual LowArousalPos_ideal 
    LowArousalPos_actual HighArousalNeg_ideal HighArousalNeg_actual LowArousalNeg_ideal 
    LowArousalNeg_actual
  /PRINT=TWOTAIL NOSIG FULL
  /MISSING=PAIRWISE.

CORRELATIONS
  /VARIABLES=ASRM_tot BDISF_tot WITH HighArousalPos_ideal HighArousalPos_actual LowArousalPos_ideal 
    LowArousalPos_actual HighArousalNeg_ideal HighArousalNeg_actual LowArousalNeg_ideal 
    LowArousalNeg_actual
  /PRINT=TWOTAIL NOSIG FULL
  /MISSING=PAIRWISE.

CORRELATIONS
  /VARIABLES=hps48_tot ASRM_tot BDISF_tot WITH HighArousalPos_diff LowArousalPos_diff 
   HighArousalNeg_diff LowArousalNeg_diff
  /PRINT=TWOTAIL NOSIG FULL
  /MISSING=PAIRWISE.
CORRELATIONS
  /VARIABLES=HighArousalPos_diff LowArousalPos_diff 
   HighArousalNeg_diff LowArousalNeg_diff WITH hps48_tot ASRM_tot BDISF_tot
  /PRINT=TWOTAIL NOSIG FULL
  /MISSING=PAIRWISE.

PARTIAL CORR
  /VARIABLES=ASRM_tot HighArousalPos_ideal BY HighArousalPos_actual
  /SIGNIFICANCE=TWOTAIL
  /MISSING=LISTWISE.
PARTIAL CORR
  /VARIABLES=BDISF_tot HighArousalPos_ideal BY HighArousalPos_actual
  /SIGNIFICANCE=TWOTAIL
  /MISSING=LISTWISE.
PARTIAL CORR
  /VARIABLES=ASRM_tot LowArousalPos_ideal BY LowArousalPos_actual
  /SIGNIFICANCE=TWOTAIL
  /MISSING=LISTWISE.
PARTIAL CORR
  /VARIABLES=BDISF_tot LowArousalPos_ideal BY LowArousalPos_actual
  /SIGNIFICANCE=TWOTAIL
  /MISSING=LISTWISE.

PARTIAL CORR
  /VARIABLES=ASRM_tot HighArousalNeg_ideal BY HighArousalNeg_actual
  /SIGNIFICANCE=TWOTAIL
  /MISSING=LISTWISE.
PARTIAL CORR
  /VARIABLES=BDISF_tot HighArousalNeg_ideal BY HighArousalNeg_actual
  /SIGNIFICANCE=TWOTAIL
  /MISSING=LISTWISE.
PARTIAL CORR
  /VARIABLES=ASRM_tot LowArousalNeg_ideal BY LowArousalNeg_actual
  /SIGNIFICANCE=TWOTAIL
  /MISSING=LISTWISE.
PARTIAL CORR
  /VARIABLES=BDISF_tot LowArousalNeg_ideal BY LowArousalNeg_actual
  /SIGNIFICANCE=TWOTAIL
  /MISSING=LISTWISE.



****************************************************************
***EXPLORATORY ANALYSES
****************************************************************
*********RESEARCH QUESTION 1 no current sx
    

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS CI(95) R ANOVA CHANGE
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT hps48_tot
  /METHOD=ENTER HighArousalPos_actual HighArousalNeg_actual LowArousalPos_actual 
    LowArousalNeg_actual.


*********RESEARCH QUESTION 2 no current sx
    
REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS CI(95) R ANOVA CHANGE
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT hps48_tot
  /METHOD=ENTER ASRM_tot BDISF_tot
  /METHOD=ENTER HighArousalPos_actual LowArousalPos_actual HighArousalNeg_actual 
    LowArousalNeg_actual
  /METHOD=ENTER HighArousalPos_ideal LowArousalPos_ideal HighArousalNeg_ideal LowArousalNeg_ideal.


****************************************************************
***EXPLORATORY ANALYSES - MDQ
****************************************************************
*** establish items that are miscoded; change to "missing".

recode MDQ1 to MDQ14 (0, 3, 4, 5 = 9).
recode MDQ15 (5 = 9).
missing values MDQ1 to MDQ15 (9).
execute.

*** recode from 1,2 scoring algorithm to 1,0.

recode MDQ1 to MDQ14 (2 = 0).
execute.

*** compute total for first 13 items.

compute MDQ_tot = mean(MDQ1 to MDQ13) * 13.
EXECUTE.

*** compute MDQ_pos (MDQ_ positive screen variable) based on Hirschfeld et al. (2000, 2003).

compute MDQ_pos = 0.
IF (MDQ_tot >= 7 and MDQ15 >= 3 and MDQ14 = 1) MDQ_pos = 1 .
EXECUTE .



*********RESEARCH QUESTION 1 MDQ
    

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS CI(95) R ANOVA CHANGE
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT MDQ_tot
   /METHOD=ENTER ASRM_tot BDISF_tot
  /METHOD=ENTER HighArousalPos_actual HighArousalNeg_actual LowArousalPos_actual 
    LowArousalNeg_actual.


*********RESEARCH QUESTION 2 MDQ
    
REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS CI(95) R ANOVA CHANGE
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT MDQ_tot
  /METHOD=ENTER ASRM_tot BDISF_tot
  /METHOD=ENTER HighArousalPos_actual LowArousalPos_actual HighArousalNeg_actual 
    LowArousalNeg_actual
  /METHOD=ENTER HighArousalPos_ideal LowArousalPos_ideal HighArousalNeg_ideal LowArousalNeg_ideal.

