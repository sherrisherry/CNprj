# number of records in each request < 10,000
ie <- c(0,1); names(ie) <- c('e','i')
yr <- 2018; mth <- 5:12
cty <- c(101,102,103,104,105,106,107,108,109,111,112,113,114,115,116,117,118,119,120,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,141,144,145,146,147,148,149,201,202,204,205,206,207,208,210,211,212,213,214,215,216,218,219,221,222,223,225,226,227,228,229,230,231,232,233,234,235,237)
cookie <- 'exGF5PROFKORznN6exLaU4D2jGddQUneKouN8jK6BqG7o1EVdhqS!-1957586062'
out_dir <- 'data'
ref <- 'http://43.248.49.97/queryDataForEN/queryDataList'
for(i in ie){
  for(j in cty){
    for(k in mth){
      fnm <- paste(names(ie)[match(i, ie)], j, yr, k, '.csv', sep = ''); out_file <- file.path(out_dir, fnm)
      cmd <- paste('curl "http://43.248.49.97/queryDataForEN/downloadQueryData?pageNum=1&pageSize=10&iEType=', i, 
                   '&currencyType=usd&year=', yr, '&startMonth=', k, '&endMonth=', k, 
                   '&monthFlag=1&codeLength=8&outerField1=ORIGIN_COUNTRY&outerField2=CODE_TS&outerField3=TRADE_MODE&outerField4=&outerValue1=', j, 
                   '&outerValue2=&outerValue3=&outerValue4=&orderType=QTY_1+DESC" -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:67.0) Gecko/20100101 Firefox/67.0" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" -H "Accept-Language: en-US,en;q=0.5" -H "Connection: keep-alive" -H "Referer: ',
                   ref, '" -H "Cookie: JSESSIONID=', cookie, '" -H "Upgrade-Insecure-Requests: 1" -o ', out_file, sep = '')
      tmp <- system(cmd)
      if(tmp==0L){
        if(readLines(out_file, n=1L)=="<!DOCTYPE html>"){
          cat(paste(fnm, 'request error\n', sep = '\t'), file = 'batch.log', append = TRUE)
          stop('request error')
        }
      }else{cat(paste(fnm, 'curl error\n', sep = '\t'), file = 'batch.log', append = TRUE); next}
      cat(paste(fnm, 'downloaded\n', sep = '\t'), file = 'batch.log', append = TRUE)
    }
  }
}
