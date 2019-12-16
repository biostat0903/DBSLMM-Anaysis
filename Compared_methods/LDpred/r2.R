#! /usr/bin/env Rscript
library(plyr)
library(data.table)
library(optparse)

## Parameter setting
args_list = list(
  make_option("--pred", type="character", default=NULL,
              help="INPUT: gemma file", metavar="character"), 
  make_option("--pheno", type="character", default=NULL,
              help="INPUT: phenotype number", metavar="character"), 
  make_option("--type", type="character", default=NULL,
              help="INPUT: simluation or real data", metavar="character"), 
  make_option("--r2", type="character", default=NULL,
              help="OUTPUT: r2 file", metavar="character")
)

opt_parser = OptionParser(option_list=args_list)
opt = parse_args(opt_parser)

if (opt$type == "sim"){
  pred_pheno <- read.table(opt$pred, header = T)
  r2 <- cor(pred_pheno[, 3], pred_pheno[, 6])^2
}
if (opt$type == "c"){
  pred_pheno <- read.table(opt$pred, header = T)[, 6]
  pheno <- data.frame(fread("/net/mulan/disk2/yasheng/plink_file/subsample/pheno_sub_v2.txt"))[, as.numeric(opt$pheno)]
  r2 <- cor(pred_pheno, pheno)^2
}
if (opt$type == "b"){
  pred_pheno <- read.table(opt$pred, header = T)[, 6]
  pheno <- data.frame(fread("/net/mulan/disk2/yasheng/plink_file/subsample/pheno_sub_b.txt"))[, as.numeric(opt$pheno)]
  r2 <- cor(pred_pheno, pheno)^2
}  

write.table(r2, file = opt$r2, col.names = F, row.names = F, quote = F)
