#!/bin/bash
echo "Last Shutdown Report"
last -x | grep shutdown 
