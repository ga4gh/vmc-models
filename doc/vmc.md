# Protocol Documentation
<a name="top"/>

## Table of Contents
* [vmc.proto](#vmc.proto)
 * [Allele](#org.ga4gh.vmc.Allele)
 * [Genotype](#org.ga4gh.vmc.Genotype)
 * [Haplotype](#org.ga4gh.vmc.Haplotype)
 * [Identifier](#org.ga4gh.vmc.Identifier)
 * [Interval](#org.ga4gh.vmc.Interval)
 * [Location](#org.ga4gh.vmc.Location)
 * [Position](#org.ga4gh.vmc.Position)
 * [Sequence](#org.ga4gh.vmc.Sequence)
 * [SequenceIdentifier](#org.ga4gh.vmc.SequenceIdentifier)
 * [Completeness](#org.ga4gh.vmc.Completeness)
 * [Position.Type](#org.ga4gh.vmc.Position.Type)
* [Scalar Value Types](#scalar-value-types)

<a name="vmc.proto"/>
<p align="right"><a href="#top">Top</a></p>

## vmc.proto



<a name="org.ga4gh.vmc.Allele"/>
### Allele
Allele represents a single contiguous change on a specific reference sequence

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [string](#string) | optional | Alelle identifier |
| location_id | [string](#string) | optional | Location of feature |
| replacement | [string](#string) | optional | replacement sequence |


<a name="org.ga4gh.vmc.Genotype"/>
### Genotype
Genotype represents multiple changes at a single location

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [string](#string) | optional | Genotype identifier |
| haplotype_ids | [string](#string) | repeated | list of haplotypes by id |
| completeness | [Completeness](#org.ga4gh.vmc.Completeness) | optional | Completeness of Genotype definition |


<a name="org.ga4gh.vmc.Haplotype"/>
### Haplotype
Haplotype represents a collection of phased changes on a single
reference.

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [string](#string) | optional | Haplotype identifier |
| sequence_id | [string](#string) | optional | Alleles are defined on this sequence |
| completeness | [Completeness](#org.ga4gh.vmc.Completeness) | optional | Completeness of Haplotype definition |
| allele_ids | [string](#string) | repeated | list of haplotypes by id |


<a name="org.ga4gh.vmc.Identifier"/>
### Identifier
Identifier is a namespaced accession to an object.  May be
represented as a URI as namespace:accession.

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| namespace | [string](#string) | optional | name of the object authority or algorithm |
| accession | [string](#string) | optional | replacement sequence; empty for deletion |


<a name="org.ga4gh.vmc.Interval"/>
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
| start | [uint64](#uint64) | optional | start position |
| end | [uint64](#uint64) | optional | end position |


<a name="org.ga4gh.vmc.Location"/>
### Location
Represents a specific position on a specific sequence.

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [string](#string) | optional | Location identifier |
| sequence_id | [string](#string) | optional | sequence id |
| position | [Position](#org.ga4gh.vmc.Position) | optional | position of sequence change on seqref |


<a name="org.ga4gh.vmc.Position"/>
### Position


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| type | [Position.Type](#org.ga4gh.vmc.Position.Type) | optional |  |
| interval | [Interval](#org.ga4gh.vmc.Interval) | optional |  |


<a name="org.ga4gh.vmc.Sequence"/>
### Sequence
A biological sequence, represented using 1-letter nucleic or amino
acids.

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id | [string](#string) | optional | Internal Sequence id |
| sequence | [string](#string) | optional | sequence itself |


<a name="org.ga4gh.vmc.SequenceIdentifier"/>
### SequenceIdentifier


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| sequence_id | [string](#string) | optional | Internal Sequence id |
| identifier | [Identifier](#org.ga4gh.vmc.Identifier) | optional | identifier |



<a name="org.ga4gh.vmc.Completeness"/>
### Completeness
Declares the completeness of haplotype or genotype definitions.

| Name | Number | Description |
| ---- | ------ | ----------- |
| UNKNOWN | 0 | Other alleles or haplotypes may exist |
| UNSPECIFIED | 1 | Other alleles or haplotypes exist but are not specified |
| COMPLETE | 2 | All alleles or haplotypes are included in this definition |

<a name="org.ga4gh.vmc.Position.Type"/>
### Position.Type


| Name | Number | Description |
| ---- | ------ | ----------- |
| INTERVAL | 0 |  |





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
