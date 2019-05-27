# The next two lines install the package - only necessary the first time
source("https://bioconductor.org/biocLite.R")
biocLite("rGADEM")
# Load package
library("rGADEM")

#define pwd as empty vector
pwd <- ""

#load file name "extdata/Test_100.fasta" from package "rGADEM" from previously installed files
#the external data "extdata/Test_100.fasta" are dna sequences to be analyzed
#write as new vector "path"
path<- system.file("extdata/Test_100.fasta", package="rGADEM")

#define Fastafile as the concoction of "pwd" and "path" with seperation length = 0 using function "paste"
FastaFile <- paste(pwd, path, sep="")

#function: "readDNAStringSet" with inputs FastaFile: file with the DNA sequence
#and "fasta": format/type of the file 
#write as new vector sequences
#output: all sequences from the file "FastaFile"
#amount of Sequences, width and names 
#in readable format "DNAStringSet" for the following function
sequences <- readDNAStringSet(FastaFile, "fasta")

#function "GADEM", ref:https://www.rdocumentation.org/packages/rGADEM/versions/2.20.0/topics/GADEM
#C Programm with input of the "sequences" and logical vector "verbose"
#if verbose = TRUE then shows immediate results of function
#output: detailed analysis of said sequence with 2 cycles of 5 generations each
#tries to get lowest "fitness" - deviation from common motif
#with data such as number of sequences, length, frequencies of each base, 
#count of frequent k-mers, number of unique motifs and a consensus sequence
#write as new vector gadem with class gadem
gadem <- GADEM(sequences, verbose=1)

#function "consensus": Input: complete "GADEM" analysis in gadem format
#Output: most likely consensus sequence shown by fitness value of "GADEM" output
consensus(gadem)

#"gadem@motifList[[1]]@pwm" shows likeliness of each base to appear in a position of the consensus motif
#write in new vector pwm
pwm <- gadem@motifList[[1]]@pwm

#seqLogo creates a Plot from "pwn"
#each Position in the consensus with the most likely base to appear indicated by height.
seqLogo(pwm)


