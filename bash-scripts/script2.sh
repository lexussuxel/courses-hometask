#!/bin/bash

function input_sum(){
  local sum = 0;
  while read num && [ "$num" != "0" ]; do
    ((sum +=  num))

  done 
  echo "Sum: ${sum}"
}

input_sum