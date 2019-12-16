#! /usr/bin/env Rscript
library(plyr)
library(data.table)
library(optparse)

## Parameter setting
args_list = list(
  make_option("--r2", type="character", default=NULL,
              help="INPUT: gemma file", metavar="character"), 
  make_option("--pbest", type="character", default=NULL,
              help="INPUT: plink file", metavar="character")
)

opt_parser = OptionParser(option_list=args_list)
opt = parse_args(opt_parser)

## p threshold
pth <- c("5e-8", "1e-6", "1e-4", "1e-3", "1e-2", "5e-2", "1e-1", "2e-1", "5e-1", "1.0")
r2_vec <- vector("numeric", length(pth))
for (i in 1: length(pth)){
  r2_tmp <- try(read.table(paste0(opt$r2, pth[i], ".txt"))[1, 1], silent = T)
  if (inherits(r2_tmp, "try-error") == F){
    r2_vec[i] <- r2_tmp
  }
}

write.table(pth[which.max(r2_vec)], file = opt$pbest, 
            row.names = F, col.names = F, quote = F)
