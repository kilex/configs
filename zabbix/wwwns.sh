#!/bin/bash
host www.$1 8.8.8.8 | grep has | awk '{print($4)}'
exit;
