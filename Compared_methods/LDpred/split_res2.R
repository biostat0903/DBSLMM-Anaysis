#! /usr/bin/env Rscript
library(optparse)
library(data.table)

## Parameter setting
args_list = list(
  make_option("--tot", type="character", default=NULL,
              help="INPUT: ldpred file", metavar="character"),
  make_option("--sp", type="character", default=NULL,
              help="OUTPUT: each chrom file", metavar="character")
)
opt_parser = OptionParser(option_list=args_list)
opt = parse_args(opt_parser)

tot <- data.frame(fread(opt$tot, header = T))

for (chr in 1: 22){
  
  chr_eff <- tot[tot[, 1] == paste0("chrom_", chr), c(3, 4, 7)]
  write.table(chr_eff, file = paste0(opt$sp, as.character(chr), ".txt"), row.names = F, 
              col.names = F, quote = F)
}