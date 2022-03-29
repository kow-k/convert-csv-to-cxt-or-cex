#!/usr/bin/env gawk -f
## This awk script converts a .csv file to a .cxt file that Concept Explorer NG
## Concept Explore FX, NG can handle.
## Developed by Kow Kuroda
## Created: 2020/07/04
## Modified:
## 2020/07/04
## 2021/10/08 fixed bugs in counting
## 2021/10/15 solved a tricky behavior at the last element in the string array

## setup
BEGIN { FS = "," ; debug = 0; verbose = 0; oindex = 0;
	TrueChar = 1; FalseChar = 0; Positive = 1; Negative = 0; }

## main
{	if (NR == 1) {
		if (debug) {
			print "#debug NR:" NR
			print "#debug $0:" $0
			print "#debug NF:" NF
		}
		## build attribute list
		for (i = 1; i <= NF; i++) {
			result = gensub("\\W", "", "g", $i) # This works out!!!!!
			#printf "%s\n", result
			ATTR[i] = result
			}
	} else {
		if (debug) {
			print "#debug NR:" NR;
			print "#debug NF:" NF;
			print "#debug $0:" $0;
		}
		oindex++
		## build object list
		if (NF > 0) {
			encX = ""
			for (i = 1; i <= NF; i++) {
				## collects obj names
				if (i < 2) {
					if (verbose) { printf "obj %s: %s\n", oindex, $1 }
					OBJ[oindex] = gensub("\\W", "", "g", $1)
					}
				## collect encodings
				else {
					if ($i != FalseChar) { encX = encX Positive
					} else { encX = encX Negative }
				}
			}
			CXT[oindex] = encX
		}
 	}
}

## output
END {
	print "% This .cex file is generated from '" FILENAME "' by", ARGV[0];
	## print headers
	printf "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
	printf "<ConceptualSystem>\n"
	printf "<Version MajorNumber=\"1\" MinorNumber=\"0\" />\n"
	printf "%s<Contexts>\n", " "
	printf "%s<Context Identifier=\"0\" Type=\"Binary\">\n", "  "
	printf "%s<Attributes>\n", "   "
	## process attributes
	for (i = 1; i <= length(ATTR); i++) {
		printf "%s<Attribute Identifier=\"%d\">\n", "     ", i-1
		printf "%s<Name>%s</Name>\n", "      ", ATTR[i]
		printf "%s</Attribute>\n", "     "
		}
	printf "%s</Attributes>\n", "   "
	## process objects
	NObj = length(OBJ)
	printf "%s<Objects>\n", "   "
	for (i = 1; i <= NObj; i++) {
		if (debug) { printf "#debug: oindex: %d\n", i }
		#
		printf "%s<Object>\n", "    "
		printf "%s<Name>%s</Name>\n", "      ", OBJ[i]
		printf "%s<Intent>\n", "      "
		## print encoding
		encoding = CXT[i]
		for (j = 1; j <= length(encoding); j++ ) {
			enc = substr(encoding, j, 1)
			if (enc == TrueChar) {
				printf "%s<HasAttribute AttributeIdentifier=\"%d\" />\n", "       ", (j - 1)
				}
			}
		printf "%s</Intent>\n", "      "
		printf "%s</Object>\n", "    "
		}
	printf "%s</Objects>\n", "   "
	#
	printf "%s</Context>\n", "  "
	printf "%s</Contexts>\n", " "
	print "</ConceptualSystem>\n"
	#
	if (verbose) {
		print " OBJ size: " length(OBJ)
		print "ATTR size: " length(ATTR)
		print " CXT size: " length(CXT)
	}
}

### end of script
