#!/usr/bin/env gawk -f
## This awk script converts a .csv file to a .cxt file that Concept Explorer NG
## Concept Explore FX can handle.
## Developed by Kow Kuroda
## Created: 2020/07/04
## Modifications:
## 2020/07/04:
## 2021/10/08 fixed bugs in counting
## 2021/10/15: changed encoding scheme so that you can choose to encode
## negatively (using on 0 vs other values) or positively (using 1 vs other values)
## 2024/06/24: added handling of .csv variation on the first linel with or without ","

## setup
BEGIN { FS = "," ; debug = 0 ; verbose = 0; oindex = 0; NegativelyBased = 1;
	TrueChar = 1; FalseChar = 0; Positive = "X"; Negative = ".";
	}

## main
{	if (NR == 1) {
		if (debug) {
			print "#debug NR:" NR
			print "#debug NF:" NF
			print "#debug $0:" $0
		}
		# build attribute list
		if ( $1 == "") {
			for (i = 2; i <= NF; i++) { ATTR[i] = $i }
		} else {
			for (i = 1; i <= NF; i++) { ATTR[i] = $i }
		}
	} else {
		if (debug) {
			print "#debug NR:" NR
			print "#debug NF:" NF
			print "#debug $0:" $0
		}
		oindex++
		# build object list
		if (NF > 0) {
			Enc = ""
			for (i = 1; i <= NF; i++) {
				# collects obj names
				if (i < 2) {
					if (verbose) { printf "obj %s: %s\n", oindex, $1 }
					OBJ[oindex] = $1
					}
				# collect encodings
				else {
					if (NegativelyBased) {
						if ($i != FalseChar) { Enc = Enc Positive } else { Enc = Enc Negative }
					} else {
						if ($i == TrueChar) { Enc = Enc Positive } else { Enc = Enc Negative }
					}
				}
			}
			CXT[oindex] = Enc
		}
 	}
}

## output
END {
	#print "% This .cex file is generated from '" FILENAME "' by", ARGV[0];
	## print header
	print "B\n";
	printf oindex "\n";
	printf length(ATTR) "\n\n";
	#
	for (i = 1; i <= oindex; i++) {
		if (debug) { printf "#debug: oindex: %s\n", i }
		obj = OBJ[i]
		if (obj != "") { print OBJ[i] }
	}
	## print encoding
	## attributes
	for (i = 1; i <= length(ATTR); i++) {
		attr = ATTR[i]
		if (attr != "") { print ATTR[i] }
	}
	## objects
	for (i = 1; i <= oindex; i++) {
		obj = CXT[i]
		if (obj != "") { print CXT[i] }
	}
	#
	if (verbose) {
		print " OBJ size: " length(OBJ)
		print "ATTR size: " length(ATTR)
		print " CXT size: " length(CXT)
	}
}

## Functions
#function(A) {
#	for (i = 1; i <= length(A); i++) {
#	print A[i]
#}

### end of script
