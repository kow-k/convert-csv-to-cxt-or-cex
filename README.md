# (g)awk script that converts .csv files to .cxt or .cex files.

FCA is a great framework. I often use it for my research.

I usually use Excel workbook to construct formal context files fed to Concept Explorer. This is because complex evaluation of attributes often requires dynamic operations external to FCA tools such as Concept Explorer. Concept Explorer (original version) is ready for this use, but recent re-implementations of it do not accept .csv files generated this way, or more precisely, I can't figure out the exaxt format of .csv files assumed for their input.

For example, I can't figure out the format of .csv files Concept Explorer FX accept, quite regrettably, because there is no documentation provided. So, I decided to develop a converter of .csv files to .cxt files, which are accepted by ConExp FX. I also developed a converter to .cex files, though this would be less required.

# scripts

[convert-csv-to-cxt.awk](convert-csv-to-cxt.awk)

## usage

Run with a (g)awk by issuing:

`(g)awk convert-csv-to-cxt.awk CSV_FILE > CXT_FILE`

where `CSV_FILE is the input` and `CXT_FILE` is the output.

or make the script executable by `chmod +x convert-csv-to-cxt.awk` and then,

`./convert-csv-to-cxt.awk CSV_FILE > CXT_FILE`

[convert-csv-to-cex.awk](convert-csv-to-cex.awk)

## usage

Run with a (g)awk by issuing:

`(g)awk convert-csv-to-cex.awk CSV_FILE > CXT_FILE`

where `CSV_FILE is the input` and `CXT_FILE` is the output.

or make the script executable by `chmod +x convert-csv-to-cex.awk` and then,

`./convert-csv-to-cex.awk CSV_FILE > CEX_FILE`

# sample .csv files

[sample 1](sample1.csv)

# FCA tools

One of the oldest but greatest tool for FCA

[Concept Explorer (original)](http://conexp.sourceforge.net/)

More recent re-implementation of Concept Explorer with advanced visualizations:

[Concept Explorer FX](https://francesco-kriegel.github.io/conexp-fx/)

