#!/bin/bash

counter=0
cat signatures.csv | while IFS= read -r signature
do
	let counter=$counter+1;
	echo $signature > "office_signature_"$counter".key" 
done
