# Protocol Documentation
<a name="top"/>

## Table of Contents
* [types.proto](#types.proto)
 * [Interval](#Interval)
 * [IntervalEdit](#IntervalEdit)
 * [SequenceReference](#SequenceReference)
 * [SequenceReference.Namespace](#SequenceReference.Namespace)
* [Simple.proto](#Simple.proto)
 * [Simple](#org.ga4gh.vmc.Simple)
 * [Simple.Allele](#org.ga4gh.vmc.Simple.Allele)
 * [Simple.Diplotype](#org.ga4gh.vmc.Simple.Diplotype)
 * [Simple.Genotype](#org.ga4gh.vmc.Simple.Genotype)
 * [Simple.Haplotype](#org.ga4gh.vmc.Simple.Haplotype)
* [ByReference.proto](#ByReference.proto)
 * [ByReference](#org.ga4gh.vmc.ByReference)
 * [ByReference.Allele](#org.ga4gh.vmc.ByReference.Allele)
 * [ByReference.Diplotype](#org.ga4gh.vmc.ByReference.Diplotype)
 * [ByReference.Genotype](#org.ga4gh.vmc.ByReference.Genotype)
 * [ByReference.Haplotype](#org.ga4gh.vmc.ByReference.Haplotype)
* [Scalar Value Types](#scalar-value-types)

<a name="types.proto"/>
<p align="right"><a href="#top">Top</a></p>

## types.proto



<a name="Interval"/>
### Interval
Represents the definite (i.e., not fuzzy) location of a sequence
feature using an interval of interbase coordinates.

Interbase coordinates refer to the points *between* residues.  For
a sequence of length n, 0 ≤ start ≤ end ≤ n, where 0 refers to the
point before the start of the sequence, n refers to the point at
the end of the sequence.  An interval in which start == end is a
zero width point between two nucleotides.  See
http://gmod.org/wiki/Introduction_to_Chado#Interbase_Coordinates
for more information.

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| start | [uint64](#uint64) | required | start position |
| end | [uint64](#uint64) | required | end position |


<a name="IntervalEdit"/>
### IntervalEdit
IntervalEdit represents a located sequence change.

Consider renaming fields to match message name.  One possibility is
location ⇒ interval and replacement ⇒ edit, thus matching the
message name IntervalEdit.

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| location | [Interval](#Interval) | required | location of sequence change |
| replacement | [string](#string) | required | replacement sequence; empty for deletion |


<a name="SequenceReference"/>
### SequenceReference
SequenceReference represents a named reference to a sequence in a
database.  For the purposes of VMC, it is essential that the mapping
from SequenceReference to sequence is many-to-one and immutable.

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| namespace | [SequenceReference.Namespace](#SequenceReference.Namespace) | required | name of recognized sequence reference |
| accession | [string](#string) | required | replacement sequence; empty for deletion |



<a name="SequenceReference.Namespace"/>
### SequenceReference.Namespace


| Name | Number | Description |
| ---- | ------ | ----------- |
| NCBI | 0 | versioned NCBI identifier, such as NM_000059.3 or NC_000001.10 |
| ENSEMBL | 1 | versioned Ensembl identifier, such as ENST00000380152.7 |
| LRG | 2 | Locus Reference Genome; http://www.lrg-sequence.org/ |
| MD5 | 100 | MD5 of sequence |
| SHA1 | 101 | SHA1 of sequence |
| SHA256 | 102 | SHA256 of sequence |
| SHA512 | 103 | SHA512 of sequence |
| SEGUID | 110 | seguid of sequence |
| SEQHASH | 111 | seqhash of sequence |




<a name="Simple.proto"/>
<p align="right"><a href="#top">Top</a></p>

## Simple.proto

Probably the simplest option to consider.

<a name="org.ga4gh.vmc.Simple"/>
### Simple


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |


<a name="org.ga4gh.vmc.Simple.Allele"/>
### Simple.Allele
Allele represents a single contiguous change

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| sequence_reference | [SequenceReference](#SequenceReference) | required | sequence reference (namespace and accession) |
| location | [Interval](#Interval) | required | location of sequence change |
| replacement | [string](#string) | required | replacement sequence; empty for deletion |


<a name="org.ga4gh.vmc.Simple.Diplotype"/>
### Simple.Diplotype
Diplotype represents a collection of haplotypes.

Haplotypes are probably defined on the same sequence, but the model
does not require it and there may be future cases where it's useful
to do otherwise.

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| haplotypes | [Simple.Haplotype](#org.ga4gh.vmc.Simple.Haplotype) | repeated | phased changes; intervals should not overlap |


<a name="org.ga4gh.vmc.Simple.Genotype"/>
### Simple.Genotype
Genotype represents multiple changes at a single location

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| sequence_reference | [SequenceReference](#SequenceReference) | required | sequence reference (namespace and accession) |
| location | [Interval](#Interval) | required | location of sequence change |
| replacements | [string](#string) | repeated | replacement sequences; empty for deletions |


<a name="org.ga4gh.vmc.Simple.Haplotype"/>
### Simple.Haplotype
Haplotype represents a collection of phased changes on a single
reference.

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| sequence_reference | [SequenceReference](#SequenceReference) | required | sequence reference (namespace and accession) |
| interval_edits | [IntervalEdit](#IntervalEdit) | repeated | phased changes; intervals should not overlap |






<a name="ByReference.proto"/>
<p align="right"><a href="#top">Top</a></p>

## ByReference.proto



<a name="org.ga4gh.vmc.ByReference"/>
### ByReference


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |


<a name="org.ga4gh.vmc.ByReference.Allele"/>
### ByReference.Allele
Allele represents a single contiguous change on a specific reference sequence

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| seqref | [SequenceReference](#SequenceReference) | required | sequence reference (namespace and accession) |
| interval | [Interval](#Interval) | required | location of sequence change |
| replacement | [string](#string) | required | replacement sequence |
| cdid | [string](#string) | optional | computed digest identifier |


<a name="org.ga4gh.vmc.ByReference.Diplotype"/>
### ByReference.Diplotype
Diplotype represents a collection of haplotypes.

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| haplotype_cdids | [string](#string) | repeated | list of haplotypes by id |


<a name="org.ga4gh.vmc.ByReference.Genotype"/>
### ByReference.Genotype
Genotype represents multiple changes at a single location

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| alelle_cdids | [string](#string) | repeated | list of haplotypes by id |
| cdid | [string](#string) | optional | computed digest identifier |


<a name="org.ga4gh.vmc.ByReference.Haplotype"/>
### ByReference.Haplotype
Haplotype represents a collection of phased changes on a single
reference.

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| alelle_cdids | [string](#string) | repeated | alleles in known phase |
| cdid | [string](#string) | optional | computed digest identifier |







<a name="scalar-value-types"/>
## Scalar Value Types

| .proto Type | Notes | C++ Type | Java Type | Python Type |
| ----------- | ----- | -------- | --------- | ----------- |
| <a name="double"/> double |  | double | double | float |
| <a name="float"/> float |  | float | float | float |
| <a name="int32"/> int32 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint32 instead. | int32 | int | int |
| <a name="int64"/> int64 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint64 instead. | int64 | long | int/long |
| <a name="uint32"/> uint32 | Uses variable-length encoding. | uint32 | int | int/long |
| <a name="uint64"/> uint64 | Uses variable-length encoding. | uint64 | long | int/long |
| <a name="sint32"/> sint32 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int32s. | int32 | int | int |
| <a name="sint64"/> sint64 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int64s. | int64 | long | int/long |
| <a name="fixed32"/> fixed32 | Always four bytes. More efficient than uint32 if values are often greater than 2^28. | uint32 | int | int |
| <a name="fixed64"/> fixed64 | Always eight bytes. More efficient than uint64 if values are often greater than 2^56. | uint64 | long | int/long |
| <a name="sfixed32"/> sfixed32 | Always four bytes. | int32 | int | int |
| <a name="sfixed64"/> sfixed64 | Always eight bytes. | int64 | long | int/long |
| <a name="bool"/> bool |  | bool | boolean | boolean |
| <a name="string"/> string | A string must always contain UTF-8 encoded or 7-bit ASCII text. | string | String | str/unicode |
| <a name="bytes"/> bytes | May contain any arbitrary sequence of bytes. | string | ByteString | str |
