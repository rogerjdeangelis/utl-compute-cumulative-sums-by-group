Compute cumulative sums by group                                                                
                                                                                                
Very elegant                                                                                    
                                                                                                
github                                                                                          
https://tinyurl.com/ygh98syu                                                                    
https://github.com/rogerjdeangelis/utl-compute-cumulative-sums-by-group                         
                                                                                                
SAS Forum                                                                                       
https://tinyurl.com/yds7kplr                                                                    
https://communities.sas.com/t5/New-SAS-User/sum-function-in-SAS/m-p/615584                      
                                                                                                
As a side note, I like to use 'retain' even within do loops                                     
where it may not be needed. It is needed here.                                                  
It is more consistent. Also I like to use 'run;quit;'                                           
for consistentcy.                                                                               
                                                                                                
SOAPBOX ON                                                                                      
   Probably works in WPS but too lazy to check without support for a CLI.                       
   Don't like performance killing EG like IDEs.                                                 
SOAPBOX OFF                                                                                     
                                                                                                
*_                   _                                                                          
(_)_ __  _ __  _   _| |_                                                                        
| | '_ \| '_ \| | | | __|                                                                       
| | | | | |_) | |_| | |_                                                                        
|_|_| |_| .__/ \__,_|\__|                                                                       
        |_|                                                                                     
;                                                                                               
                                                                                                
data have;                                                                                      
      input ID win;                                                                             
      datalines;                                                                                
1000 1                                                                                          
1000 3                                                                                          
1000 5                                                                                          
1000 0                                                                                          
2000 0                                                                                          
2000 0                                                                                          
2000 0                                                                                          
3000 4                                                                                          
3000 1                                                                                          
3000 1                                                                                          
;                                                                                               
run;                                                                                            
                                                                                                
*            _               _                                                                  
  ___  _   _| |_ _ __  _   _| |_                                                                
 / _ \| | | | __| '_ \| | | | __|                                                               
| (_) | |_| | |_| |_) | |_| | |_                                                                
 \___/ \__,_|\__| .__/ \__,_|\__|                                                               
                |_|                                                                             
;                                                                                               
                                                                                                
                                                                                                
Up to 40 obs WORK.WANT total obs=10                                                             
                                                                                                
                      TOTAL_  |                                                                 
Obs     ID     WIN     WINS   | RULES                                                           
                                                                                                
  1    1000     1        1    |  1                                                              
  2    1000     3        4    |  1+3                                                            
  3    1000     5        9    |  1+3+5                                                          
  4    1000     0        9    |  1+3+5+0                                                        
                                                                                                
  5    2000     0        0    |  0                                                              
  6    2000     0        0    |  0+0                                                            
  7    2000     0        0    |  0+0+0                                                          
                                                                                                
  8    3000     4        4    |  4                                                              
  9    3000     1        5    |  4+1                                                            
 10    3000     1        6    |  4+1+1                                                          
                                                                                                
                                                                                                
*          _       _   _                                                                        
 ___  ___ | |_   _| |_(_) ___  _ __                                                             
/ __|/ _ \| | | | | __| |/ _ \| '_ \                                                            
\__ \ (_) | | |_| | |_| | (_) | | | |                                                           
|___/\___/|_|\__,_|\__|_|\___/|_| |_|                                                           
                                                                                                
;                                                                                               
                                                                                                
Note if you want just the total record then just                                                
add 'if last.id then output';                                                                   
                                                                                                
data want;                                                                                      
  set have;                                                                                     
  by id;                                                                                        
  retain total_wins 0;                                                                          
  total_wins = ifn (first.id, win, total_wins + win);                                           
run;                                                                                            
                                                                                                
