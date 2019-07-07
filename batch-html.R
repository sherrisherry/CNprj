# for countries that has more than 10,000 records for a request
ie <- c(0,1); names(ie) <- c('e','i')
yr <- 2018; mth <- 5:12
cty <- 502
out_dir <- 'download'
cookie <- 'exGF5PROFKORznN6exLaU4D2jGddQUneKouN8jK6BqG7o1EVdhqS!-1957586062'
ref <- 'http://43.248.49.97/queryDataForEN/queryDataList'
for(i in ie){
  for(j in cty){
    for(k in mth){
      fnm <- paste(names(ie)[match(i, ie)], j, yr, k, '.txt', sep = ''); out_file <- file.path(out_dir, fnm)
      cmd <- paste('curl "http://43.248.49.97/queryDataForEN/getQueryDataListByWhere?pageNum=1&pageSize=100000&iEType=', i, 
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
