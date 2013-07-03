#!/bin/sh
xmllint -schema schema_localized/00_canonical_example00.xsd C2S/???-base-*.xml > /dev/null 
xmllint -schema schema_localized/00_canonical_example01.xsd C2S/*.xml > /dev/null 
xmllint -schema schema_localized/00_canonical_example00.xsd S2C/???-base-*.xml > /dev/null 
xmllint -schema schema_localized/00_canonical_example01.xsd S2C/*.xml > /dev/null 
 
