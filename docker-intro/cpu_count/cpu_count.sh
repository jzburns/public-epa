#!/bin/bash

cnt=$(grep "processor" /proc/cpuinfo | wc -l)

echo "There are $cnt CPUs available"