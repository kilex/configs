#!/bin/bash
### DESCRIPTION
# $1 - имя узла сети в zabbix'е (не используется)
# $2 - измеряемая метрика
# $3 - http ссылка на станицу статистики
 
### OPTIONS VERIFICATION
if [[ -z "$1" || -z "$2" ]]; then
	exit 1
 fi
 
if [[ "$3" = "none" ]]; then
	exit 1
 fi
 
### PARAMETERS
METRIC="$2"  # измеряемая метрика
STATURL="$3?auto" # http ссылка на станицу статистики
 
CURL="/usr/bin/curl"
 
CACHETTL="55" # Время действия кеша в секундах (чуть меньше чем период опроса элементов)
CACHE="/tmp/apache-status-`echo $STATURL | md5sum | cut -d" " -f1`.cache"
 
### RUN
## Проверка кеша:
# время создание кеша (или 0 есть файл кеша отсутствует или имеет нулевой размер)
if [ -s "$CACHE" ]; then
	TIMECACHE=`stat -c"%Z" "$CACHE"`
 else
	TIMECACHE=0
 fi
# текущее время
TIMENOW=`date '+%s'`
# Если кеш неактуален, то обновить его (выход при ошибке)
if [ "$(($TIMENOW - $TIMECACHE))" -gt "$CACHETTL" ]; then
	$CURL -s "$STATURL" > $CACHE || exit 1
 fi
 
## Извлечение метрики:
if [ "$METRIC" = "accesses" ]; then
	cat $CACHE | grep -i "accesses" | cut -d':' -f2
 fi
if [ "$METRIC" = "kbytes" ]; then
	cat $CACHE | grep -i "kbytes" | cut -d':' -f2
 fi
if [ "$METRIC" = "cpuload" ]; then
	cat $CACHE | grep -i "cpuload" | cut -d':' -f2
 fi
if [ "$METRIC" = "uptime" ]; then
	cat $CACHE | grep -i "uptime" | cut -d':' -f2
 fi
if [ "$METRIC" = "avgreq" ]; then
	cat $CACHE | grep -i "ReqPerSec" | cut -d':' -f2
 fi
if [ "$METRIC" = "avgreqbytes" ]; then
	cat $CACHE | grep -i "BytesPerReq" | cut -d':' -f2
 fi
if [ "$METRIC" = "avgbytes" ]; then
	cat $CACHE | grep -i "BytesPerSec" | cut -d':' -f2
 fi
if [ "$METRIC" = "busyworkers" ]; then
	cat $CACHE | grep -i "BusyWorkers" | cut -d':' -f2
 fi
if [ "$METRIC" = "idleworkers" ]; then
	cat $CACHE | grep -i "idleworkers" | cut -d':' -f2
 fi
 
exit 0
