# Protected Mode Stage

Это вторая стадия начального загрузчика. Она переводит процессор в защищённый режим и проверяет наличие 64-битного
расширения. Если оно найдено, то она подготавливает некоторую загрузочную информацию, выполняет загрузку
стадии `lmstage` в оперативную память и передаёт ей управление, в противном случае она обнаруживает файловую систему,
файлы ядра и драйверов. В зависимости от конфигурации начальной загрузки она либо позволяет выбрать для загрузки
определённое ядро и только необходимые драйвера, либо выбирает определённые, наиболее подходящие самостоятельно. Она
подготавливает некоторую загрузочную информацию, процессор, загружает ядро и драйвера в оперативную память, передаёт
управление ядру. В момент возникновения любой ошибки она загружает стадию `estage` в оперативную память и передаёт ей
управление.
